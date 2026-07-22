# Index page helpers -- deck grid, R-session list, and textbook links for
# index.qmd. Adapted from abidjan_2026/scripts/index_helpers.R.
#
# index.csv schema:
#   sort_order,label,href_es,href_en,title_es,blurb_es,title_en,blurb_en,placeholder
# A row may have one or both hrefs. The active panel uses href_<lang>; when
# that is empty the card falls back to the other language's file and shows a
# small badge (EN/ES) so the reader knows the target language. When a deck is
# later converted to a bilingual .qmd (saved at the folder root; see
# ROUTING.md) and rendered as <stem>.html, set both href columns to that
# .html -- nothing else changes.

LANGS <- c("es", "en")

html_escape <- function(x) {
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  x <- gsub(">", "&gt;", x, fixed = TRUE)
  x <- gsub('"', "&quot;", x, fixed = TRUE)
  x
}

qmd_overrides <- character(0)

resolve_qmd_path <- function(stem) {
  override <- unname(qmd_overrides[stem])
  if (!is.na(override) && file.exists(override)) {
    return(override)
  }

  candidate <- paste0(stem, ".qmd")
  if (file.exists(candidate)) {
    return(candidate)
  }

  NA_character_
}

resolve_rmd_path <- function(stem) {
  candidate <- paste0(stem, ".Rmd")
  if (file.exists(candidate)) {
    return(candidate)
  }
  NA_character_
}

resolve_pdf_path <- function(stem, pdf_href = NA_character_) {
  if (!is.na(pdf_href) && nzchar(pdf_href) && file.exists(pdf_href)) {
    return(pdf_href)
  }

  candidates <- c(
    sprintf("pdf/%s.pdf", stem),
    sprintf("pdf/%s.pdf", basename(stem)),
    sprintf("%s.pdf", stem)
  )
  for (path in candidates) {
    if (file.exists(path)) {
      return(path)
    }
  }

  NA_character_
}

# Format-link row under a card: every available rendering of the deck whose
# stem is href minus its extension (HTML, PDF, QMD, RMD).
format_links_for_href <- function(href) {
  if (is.na(href) || !nzchar(href)) {
    return("")
  }

  stem <- sub("\\.(html|pdf|qmd|Rmd|R)$", "", href, ignore.case = FALSE)

  html_path <- if (file.exists(paste0(stem, ".html"))) paste0(stem, ".html") else NA_character_
  pdf_path <- resolve_pdf_path(stem)
  qmd_path <- resolve_qmd_path(stem)
  rmd_path <- resolve_rmd_path(stem)
  r_path <- if (grepl("\\.R$", href) && file.exists(href)) href else NA_character_

  link <- function(path, label, class) {
    sprintf(
      '<a class="deck-format-link %s" href="%s">%s</a>',
      class, html_escape(path), label
    )
  }

  parts <- character(0)
  if (!is.na(html_path)) parts <- c(parts, link(html_path, "HTML", "deck-html-link"))
  if (!is.na(pdf_path)) parts <- c(parts, link(pdf_path, "PDF", "deck-pdf-link"))
  if (!is.na(r_path)) parts <- c(parts, link(r_path, "R", "deck-qmd-link"))
  if (!is.na(qmd_path)) parts <- c(parts, link(qmd_path, "QMD", "deck-qmd-link"))
  if (!is.na(rmd_path)) parts <- c(parts, link(rmd_path, "RMD", "deck-qmd-link"))

  if (length(parts) == 0) {
    return("")
  }

  sprintf(
    '<span class="deck-formats">%s</span>',
    paste(parts, collapse = ' <span class="deck-format-sep">&middot;</span> ')
  )
}

# The card's main link for the active panel: prefer href_<lang>, fall back to
# the other language (flagging the fallback so the card can show a badge).
resolve_row_href <- function(row, lang) {
  other <- setdiff(LANGS, lang)
  own <- row[[paste0("href_", lang)]]
  alt <- row[[paste0("href_", other)]]

  if (!is.na(own) && nzchar(own)) {
    return(list(href = own, lang_used = lang, fallback = FALSE))
  }
  if (!is.na(alt) && nzchar(alt)) {
    return(list(href = alt, lang_used = other, fallback = TRUE))
  }
  list(href = NA_character_, lang_used = NA_character_, fallback = FALSE)
}

render_deck_grid <- function(lang = c("es", "en")) {
  lang <- match.arg(lang)
  decks <- read.csv(
    "index.csv",
    stringsAsFactors = FALSE,
    na.strings = c("", "NA"),
    comment.char = ""
  )
  decks <- decks[order(decks$sort_order), , drop = FALSE]
  decks$placeholder <- tolower(as.character(decks$placeholder)) %in%
    c("true", "t", "1", "yes")

  title_col <- paste0("title_", lang)
  blurb_col <- paste0("blurb_", lang)

  lines <- '<div class="deck-grid">'
  for (i in seq_len(nrow(decks))) {
    row <- decks[i, ]
    title <- html_escape(row[[title_col]])
    blurb <- html_escape(row[[blurb_col]])
    if (is.na(title) || title == "") title <- html_escape(row$title_es)
    if (is.na(blurb)) blurb <- ""
    label <- html_escape(row$label)

    resolved <- resolve_row_href(row, lang)
    no_file <- is.na(resolved$href)

    if (isTRUE(row$placeholder) || no_file) {
      lines <- c(
        lines,
        '<div class="deck-card deck-card--placeholder">',
        '<span class="deck-num">&middot;</span>',
        '<span class="deck-body">',
        sprintf('<span class="deck-title">%s</span>', title)
      )
      if (nzchar(blurb)) {
        lines <- c(lines, sprintf('<span class="deck-blurb">%s</span>', blurb))
      }
      lines <- c(lines, "</span>", "</div>")
    } else {
      badge <- if (resolved$fallback) {
        sprintf(
          '<span class="deck-lang-badge">%s</span>',
          toupper(resolved$lang_used)
        )
      } else {
        ""
      }
      lines <- c(
        lines,
        '<div class="deck-card">',
        sprintf('<a class="deck-card-link" href="%s">', html_escape(resolved$href)),
        sprintf('<span class="deck-num">%s</span>', label),
        '<span class="deck-body">',
        sprintf('<span class="deck-title">%s%s</span>', title, badge)
      )
      if (nzchar(blurb)) {
        lines <- c(lines, sprintf('<span class="deck-blurb">%s</span>', blurb))
      }
      lines <- c(lines, "</span>", "</a>")
      format_html <- format_links_for_href(resolved$href)
      if (nzchar(format_html)) {
        lines <- c(lines, format_html)
      }
      lines <- c(lines, "</div>")
    }
  }
  lines <- c(lines, "</div>")
  knitr::asis_output(paste(lines, collapse = "\n"))
}

# Simple linked list for the R-sessions tab (scripts and data download).
render_r_session_list <- function(lang, hrefs, labels) {
  match.arg(lang, LANGS)
  n <- length(hrefs)
  if (length(labels) != n) {
    stop("hrefs and labels must have the same length.", call. = FALSE)
  }

  lines <- '<ul class="quiz-list">'
  for (i in seq_len(n)) {
    label <- html_escape(labels[[i]])
    href <- hrefs[[i]]
    if (file.exists(href)) {
      lines <- c(
        lines,
        sprintf(
          '<li><a class="deck-format-link" href="%s">%s</a></li>',
          html_escape(href), label
        )
      )
    }
  }
  lines <- c(lines, "</ul>")
  knitr::asis_output(paste(lines, collapse = "\n"))
}

# The online textbook stands in for a per-site book build: link all three
# translations from both panels.
TEXTBOOK_URLS <- c(
  es = "https://egap.github.io/theory_and_practice_of_field_experiments_spanish/",
  en = "https://egap.github.io/theory_and_practice_of_field_experiments/",
  pt = "https://egap.github.io/theory_and_practice_of_field_experiments_portuguese/"
)

render_textbook_links <- function(lang = c("es", "en")) {
  lang <- match.arg(lang)

  labels <- if (lang == "es") {
    c(
      es = "Libro del taller (espa&ntilde;ol)",
      en = "Textbook (English)",
      pt = "Livro (portugu&ecirc;s)"
    )
  } else {
    c(
      es = "Textbook (Spanish)",
      en = "Textbook (English)",
      pt = "Textbook (Portuguese)"
    )
  }

  links <- sprintf(
    '<a class="book-all-slides-link" href="%s" target="_blank" rel="noopener noreferrer">%s</a>',
    TEXTBOOK_URLS, labels
  )
  html <- sprintf(
    '<p class="book-all-slides">%s</p>',
    paste(links, collapse = ' <span class="deck-format-sep">&middot;</span> ')
  )
  knitr::asis_output(html)
}
