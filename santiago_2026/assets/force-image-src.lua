--[[
  Emit <img src="..."> with CSS width (HTML width attr must be integer pixels).
  Used for reveal.js slide decks only (Images/ next to HTML).
  The HTML book does not use this filter — Quarto + postprocess handle images there.
]]

local function normalize_src(src)
  return src
    :gsub("^%.%./Images/", "Images/")
    :gsub("^%.%.%/Images/", "Images/")
    :gsub("^images/", "Images/")
    :gsub("^Images/", "Images/")
end

local function style_attr(width)
  if width == nil or width == "" then
    return ' style="width:auto;height:auto;object-fit:contain;display:block;margin:0.15em auto;"'
  end
  if not width:match("%%") and not width:match("px") and not width:match("em") then
    width = width .. "px"
  end
  return string.format(
    ' style="width:%s;height:auto;object-fit:contain;display:block;margin:0.15em auto;"',
    width
  )
end

local function img_tag(img)
  local w = img.attr.attributes["width"] or ""
  local cls = "slide-figure"
  if #img.attr.classes > 0 then
    cls = cls .. " " .. table.concat(img.attr.classes, " ")
  end
  return string.format(
    '<img src="%s" class="%s"%s alt="" />',
    normalize_src(img.src),
    cls,
    style_attr(w)
  )
end

function Image(el)
  return pandoc.RawInline("html", img_tag(el))
end

function Figure(fig)
  for _, block in ipairs(fig.content) do
    local inlines = block.t == "Plain" and block.content
      or (block.t == "Para" and block.content)
    if inlines then
      for _, inline in ipairs(inlines) do
        if inline.t == "Image" then
          return pandoc.RawBlock(
            "html",
            '<div class="slide-figure-wrap">' .. img_tag(inline) .. "</div>"
          )
        end
      end
    end
  end
  return fig
end
