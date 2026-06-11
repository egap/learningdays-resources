--[[
  Abidjan bilingual slide filter

  1. "## EN | *FR*" → hidden header (English text for menu/TOC) + two-column title row
  2. Consecutive ::: en / ::: fr → .columns body layout
  3. Inserts bilingual two-column TOC slide (level-1 sections)
]]

local toc_entries = {}
local slug_counts = {}
local in_lecture_section = false

local book_lang = os.getenv("ABIDJAN_LANG")

local function is_book_mode()
  return book_lang == "en" or book_lang == "fr"
end

local function is_beamer()
  return FORMAT:match("beamer") ~= nil
end

local function fr_plain(fr_inlines)
  return pandoc.utils.stringify(fr_inlines)
end

local function latex_escape(s)
  s = s:gsub("\\", "\\textbackslash{}")
  s = s:gsub("([%%&$#_{}~^])", "\\%1")
  return s
end

local function trim_spaces(inlines)
  local start, finish = 1, #inlines
  while start <= finish and inlines[start].t == "Space" do
    start = start + 1
  end
  while finish >= start and inlines[finish].t == "Space" do
    finish = finish - 1
  end
  local out = {}
  for i = start, finish do
    table.insert(out, inlines[i])
  end
  return out
end

local function find_split_index(inlines)
  for i, el in ipairs(inlines) do
    if el.t == "Str" then
      if el.text == "|" or el.text == "/" then
        return i
      end
    end
  end
  return nil
end

local function split_bilingual_inlines(inlines)
  local idx = find_split_index(inlines)
  if not idx then
    return nil, nil
  end
  local en = trim_spaces({ table.unpack(inlines, 1, idx - 1) })
  local fr = trim_spaces({ table.unpack(inlines, idx + 1, #inlines) })
  if #en == 0 or #fr == 0 then
    return nil, nil
  end
  return en, fr
end

local function has_class(el, name)
  for _, c in ipairs(el.classes) do
    if c == name then
      return true
    end
  end
  return false
end

local function title_cell(inlines, lang_class)
  return pandoc.Div(
    {
      pandoc.Div(
        { pandoc.Plain(inlines) },
        pandoc.Attr("", { "bilingual-title-text", lang_class }, {})
      ),
    },
    pandoc.Attr("", { "column", lang_class }, { width = "50%" })
  )
end

local function bilingual_title_columns(en_inlines, fr_inlines, header_level)
  local kind = header_level == 1 and "section-title" or "slide-title"
  return pandoc.Div(
    {
      title_cell(en_inlines, "lang-en"),
      title_cell(fr_inlines, "lang-fr"),
    },
    pandoc.Attr("", { "columns", "bilingual-titles", kind }, {})
  )
end

local function simple_slug(text)
  text = text:lower()
  text = text:gsub("&", "and")
  text = text:gsub("[^%w%s-]", "")
  text = text:gsub("%s+", "-")
  text = text:gsub("-+", "-")
  text = text:gsub("^-+", "")
  text = text:gsub("-+$", "")
  return text
end

local function unique_slide_id(en_inlines)
  local base = simple_slug(pandoc.utils.stringify(en_inlines))
  if base == "" then
    base = "slide"
  end
  local n = slug_counts[base] or 0
  n = n + 1
  slug_counts[base] = n
  if n == 1 then
    return base
  end
  return base .. "-" .. n
end

local function slide_classes_from_header(el)
  local classes = {}
  for _, c in ipairs(el.classes) do
    if c ~= "hidden-title" then
      table.insert(classes, c)
    end
  end
  return classes
end

local function hidden_header(el, en_inlines, id, extra_classes)
  local classes = { "hidden-title" }
  for _, c in ipairs(extra_classes or {}) do
    table.insert(classes, c)
  end
  return pandoc.Header(
    el.level,
    en_inlines,
    pandoc.Attr(id, classes, {})
  )
end

local function toc_link(inlines, id)
  return pandoc.Plain({
    pandoc.Link(inlines, "#" .. id, "", { class = "toc-link" }),
  })
end

local NBSP = "\194\160"

local function build_toc_blocks()
  local en_items = {}
  local fr_items = {}
  for _, entry in ipairs(toc_entries) do
    table.insert(en_items, { toc_link(entry.en, entry.id) })
    table.insert(fr_items, { toc_link(entry.fr, entry.id) })
  end
  if #en_items == 0 then
    return nil
  end

  return {
    pandoc.Header(
      2,
      { pandoc.Str(NBSP) },
      pandoc.Attr("table-of-contents", { "hidden-title" }, {})
    ),
    bilingual_title_columns(
      { pandoc.Str("Table of contents") },
      { pandoc.Emph({ pandoc.Str("Table des matières") }) },
      2
    ),
    pandoc.Div(
      {
        pandoc.Div(
          { pandoc.BulletList(en_items) },
          pandoc.Attr("", { "column", "lang-en" }, { width = "50%" })
        ),
        pandoc.Div(
          { pandoc.BulletList(fr_items) },
          pandoc.Attr("", { "column", "lang-fr" }, { width = "50%" })
        ),
      },
      pandoc.Attr("", { "columns", "bilingual-toc" }, {})
    ),
  }
end

local function book_heading_level(orig_level)
  if orig_level == 1 then
    in_lecture_section = true
    return 2
  elseif orig_level == 2 then
    if in_lecture_section then
      return 3
    end
    return 2
  elseif in_lecture_section then
    return math.min(orig_level + 1, 6)
  end
  return orig_level
end

local function transform_header(el)
  local en, fr = split_bilingual_inlines(el.content)
  if not en then
    if is_book_mode() then
      if el.level == 1 and has_class(el, "book-chapter") then
        in_lecture_section = false
        return { el }
      end
      return {
        pandoc.Header(book_heading_level(el.level), el.content, el.attr),
      }
    end
    return { el }
  end

  local id = unique_slide_id(en)

  if el.level == 1 then
    table.insert(toc_entries, { id = id, en = en, fr = fr, level = el.level })
  end

  if is_book_mode() then
    local title = en
    if book_lang == "fr" then
      title = fr
    end
    return {
      pandoc.Header(
        book_heading_level(el.level),
        title,
        pandoc.Attr(id, slide_classes_from_header(el), {})
      ),
    }
  end

  if is_beamer() then
    if el.level == 1 then
      return { pandoc.Header(1, en, pandoc.Attr(id, {}, {})) }
    end
    local fr_text = latex_escape(fr_plain(fr))
    return {
      pandoc.Header(el.level, en, pandoc.Attr(id, slide_classes_from_header(el), {})),
      pandoc.RawBlock("latex", "\\framesubtitle{\\emph{" .. fr_text .. "}}\n"),
    }
  end

  return {
    hidden_header(el, en, id, slide_classes_from_header(el)),
    bilingual_title_columns(en, fr, el.level),
  }
end

local function is_shorthand_en(div)
  return div.t == "Div" and has_class(div, "en") and not has_class(div, "column")
end

local function is_shorthand_fr(div)
  return div.t == "Div" and has_class(div, "fr") and not has_class(div, "column")
end

local function to_lang_column(div, lang)
  div.classes = { "column", lang == "en" and "lang-en" or "lang-fr" }
  div.attributes = div.attributes or {}
  div.attributes["width"] = "50%"
  return div
end

local function wrap_en_fr_columns(en_div, fr_div)
  to_lang_column(en_div, "en")
  to_lang_column(fr_div, "fr")
  return pandoc.Div({ en_div, fr_div }, pandoc.Attr("", { "columns" }, {}))
end

local function pair_shorthand(blocks)
  local out = {}
  local i = 1
  while i <= #blocks do
    local b = blocks[i]
    if b.t == "Div" and is_shorthand_en(b) and i < #blocks then
      local nxt = blocks[i + 1]
      if nxt.t == "Div" and is_shorthand_fr(nxt) then
        if is_book_mode() then
          table.insert(out, book_lang == "fr" and nxt or b)
        else
          table.insert(out, wrap_en_fr_columns(b, nxt))
        end
        i = i + 2
      else
        table.insert(out, b)
        i = i + 1
      end
    else
      table.insert(out, b)
      i = i + 1
    end
  end
  return out
end

local function column_lang(div)
  if has_class(div, "lang-en") then
    return "en"
  end
  if has_class(div, "lang-fr") then
    return "fr"
  end
  return nil
end

local function filter_book_lang_block(block)
  if not is_book_mode() then
    return block
  end

  if block.t == "Div" then
    local lang = column_lang(block)
    if lang and lang ~= book_lang then
      return nil
    end

    if has_class(block, "columns") or has_class(block, "column") then
      local kept = {}
      for _, child in ipairs(block.content) do
        local filtered = filter_book_lang_block(child)
        if filtered then
          table.insert(kept, filtered)
        end
      end
      if #kept == 1 then
        return filter_book_lang_block(kept[1])
      end
      block.content = kept
    else
      local kept = {}
      for _, child in ipairs(block.content) do
        local filtered = filter_book_lang_block(child)
        if filtered then
          table.insert(kept, filtered)
        end
      end
      block.content = kept
    end
  elseif block.t == "Section" then
    local kept = {}
    for _, child in ipairs(block.content) do
      local filtered = filter_book_lang_block(child)
      if filtered then
        table.insert(kept, filtered)
      end
    end
    block.content = kept
  end

  return block
end

local function filter_book_lang_blocks(blocks)
  if not is_book_mode() then
    return blocks
  end
  local out = {}
  for _, block in ipairs(blocks) do
    local filtered = filter_book_lang_block(block)
    if filtered then
      table.insert(out, filtered)
    end
  end
  return out
end

local function transform_blocks(blocks)
  local expanded = {}
  for _, b in ipairs(blocks) do
    if b.t == "Section" then
      b.blocks = transform_blocks(b.blocks)
      table.insert(expanded, b)
    elseif b.t == "Header" and (is_book_mode() or b.level <= 2) then
      local pieces = transform_header(b)
      for _, piece in ipairs(pieces) do
        table.insert(expanded, piece)
      end
    else
      table.insert(expanded, b)
    end
  end
  return pair_shorthand(expanded)
end

function Pandoc(doc)
  slug_counts = {}
  in_lecture_section = false
  doc.blocks = transform_blocks(doc.blocks)
  doc.blocks = filter_book_lang_blocks(doc.blocks)
  if not is_beamer() and not is_book_mode() then
    local toc_blocks = build_toc_blocks()
    if toc_blocks then
      for i = #toc_blocks, 1, -1 do
        table.insert(doc.blocks, 1, toc_blocks[i])
      end
    end
  end
  return doc
end
