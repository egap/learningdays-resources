# Index page helpers — deck grid and quiz link HTML for index.qmd
# (Batch rendering lives in 0_make_everything.R.)

html_escape <- function(x) {
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  x <- gsub(">", "&gt;", x, fixed = TRUE)
  x <- gsub('"', "&quot;", x, fixed = TRUE)
  x
}

qmd_overrides <- c(
  "15_grants" = "13_grants.qmd"
)

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

resolve_pdf_path <- function(stem, pdf_href = NA_character_) {
  if (!is.na(pdf_href) && nzchar(pdf_href) && file.exists(pdf_href)) {
    return(pdf_href)
  }

  candidates <- c(
    sprintf("pdf/%s.pdf", stem),
    sprintf("%s.pdf", stem)
  )
  for (path in candidates) {
    if (file.exists(path)) {
      return(path)
    }
  }

  NA_character_
}

format_links_for_stem <- function(
  stem,
  html_href = sprintf("%s.html", stem),
  pdf_href = NA_character_
) {
  html_path <- if (!is.na(html_href) && nzchar(html_href) && file.exists(html_href)) {
    html_href
  } else {
    NA_character_
  }

  pdf_path <- resolve_pdf_path(stem, pdf_href)
  qmd_path <- resolve_qmd_path(stem)

  parts <- character(0)
  if (!is.na(html_path)) {
    parts <- c(
      parts,
      sprintf(
        '<a class="deck-format-link deck-html-link" href="%s">HTML</a>',
        html_escape(html_path)
      )
    )
  }
  if (!is.na(pdf_path)) {
    parts <- c(
      parts,
      sprintf(
        '<a class="deck-format-link deck-pdf-link" href="%s">PDF</a>',
        html_escape(pdf_path)
      )
    )
  }
  if (!is.na(qmd_path)) {
    parts <- c(
      parts,
      sprintf(
        '<a class="deck-format-link deck-qmd-link" href="%s">QMD</a>',
        html_escape(qmd_path)
      )
    )
  }

  if (length(parts) == 0) {
    return("")
  }

  sprintf(
    '<span class="deck-formats">%s</span>',
    paste(parts, collapse = ' <span class="deck-format-sep">·</span> ')
  )
}

format_links_html <- function(href) {
  if (grepl("\\.html$", href, ignore.case = TRUE)) {
    stem <- sub("\\.html$", "", href, ignore.case = TRUE)
    return(format_links_for_stem(stem, html_href = href))
  }

  if (grepl("\\.pdf$", href, ignore.case = TRUE)) {
    stem <- sub("\\.pdf$", "", href, ignore.case = TRUE)
    return(format_links_for_stem(stem, html_href = NA_character_, pdf_href = href))
  }

  ""
}

render_quiz_list <- function(language, stem, labels) {
  match.arg(language, c("en", "fr"))
  n <- length(stem)
  if (length(labels) != n) {
    stop("stem and labels must have the same length.", call. = FALSE)
  }

  lines <- '<ul class="quiz-list">'
  for (i in seq_len(n)) {
    label <- html_escape(labels[[i]])
    formats <- format_links_for_stem(stem[[i]])
    lines <- c(
      lines,
      sprintf(
        '<li><span class="quiz-label">%s</span>%s</li>',
        label,
        if (nzchar(formats)) paste0(" ", formats) else ""
      )
    )
  }
  lines <- c(lines, "</ul>")
  knitr::asis_output(paste(lines, collapse = "\n"))
}

render_deck_grid <- function(lang = c("en", "fr")) {
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

  if (lang == "fr") {
    label_col <- "label_fr"
    title_col <- "title_fr"
    blurb_col <- "blurb_fr"
  } else {
    label_col <- "label"
    title_col <- "title"
    blurb_col <- "blurb"
  }

  lines <- '<div class="deck-grid">'
  for (i in seq_len(nrow(decks))) {
    row <- decks[i, ]
    title <- html_escape(row[[title_col]])
    blurb <- html_escape(row[[blurb_col]])
    if (is.na(title) || title == "") title <- html_escape(row$title)
    if (is.na(blurb)) blurb <- ""
    format_html <- format_links_html(row$href)

    if (isTRUE(row$placeholder)) {
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
      label <- html_escape(row[[label_col]])
      if (is.na(label) || label == "") label <- html_escape(row$label)
      href <- html_escape(row$href)
      lines <- c(
        lines,
        '<div class="deck-card">',
        sprintf('<a class="deck-card-link" href="%s">', href),
        sprintf('<span class="deck-num">%s</span>', label),
        '<span class="deck-body">',
        sprintf('<span class="deck-title">%s</span>', title)
      )
      if (nzchar(blurb)) {
        lines <- c(lines, sprintf('<span class="deck-blurb">%s</span>', blurb))
      }
      lines <- c(lines, "</span>", "</a>")
      if (nzchar(format_html)) {
        lines <- c(lines, format_html)
      }
      lines <- c(lines, "</div>")
    }
  }
  lines <- c(lines, "</div>")
  knitr::asis_output(paste(lines, collapse = "\n"))
}
