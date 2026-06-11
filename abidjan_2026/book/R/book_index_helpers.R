# Chapter list for book/index.qmd home page.
render_book_chapter_list <- function(lang = Sys.getenv("QUARTO_PROFILE", unset = "en")) {
  if (!lang %in% c("en", "fr")) lang <- "en"

  input_dir <- dirname(knitr::current_input(dir = TRUE))
  book_root <- input_dir
  while (!file.exists(file.path(book_root, "_quarto.yml")) && book_root != dirname(book_root)) {
    book_root <- dirname(book_root)
  }
  root <- normalizePath(file.path(book_root, ".."))
  source(file.path(root, "scripts", "index_helpers.R"), local = TRUE)

  idx <- read.csv(
    file.path(root, "index.csv"),
    stringsAsFactors = FALSE,
    na.strings = c("", "NA")
  )
  idx$placeholder <- tolower(as.character(idx$placeholder)) %in%
    c("true", "t", "1", "yes")
  lectures <- idx[
    grepl("^Lecture", idx$label) &
      !idx$placeholder &
      !grepl("\\.pdf$", idx$href, ignore.case = TRUE),
    ,
    drop = FALSE
  ]
  lectures <- lectures[order(lectures$sort_order), , drop = FALSE]

  title_col <- if (lang == "fr") "title_fr" else "title"
  lines <- c("<ol class=\"book-chapter-list\">")
  n <- 0L
  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(root)

  for (i in seq_len(nrow(lectures))) {
    row <- lectures[i, ]
    stem <- sub("\\.html$", "", row$href)
    if (is.na(resolve_qmd_path(stem))) next
    n <- n + 1L
    title <- row[[title_col]]
    if (is.na(title) || !nzchar(trimws(title))) title <- row$title
    href <- sprintf("chapters/%s/%s.html", lang, stem)
    lines <- c(
      lines,
      sprintf(
        '<li><a href="%s"><span class="book-chapter-num">%d.</span> %s</a></li>',
        href,
        n,
        html_escape(trimws(title))
      )
    )
  }
  lines <- c(lines, "</ol>")
  knitr::asis_output(paste(lines, collapse = "\n"))
}
