# Shared knitr setup for book pages (index + chapter wrappers).
init_lecture_chapter <- function(lang = "en") {
  Sys.setenv(ABIDJAN_LANG = lang)

  input_path <- knitr::current_input()
  input_dir <- dirname(knitr::current_input(dir = TRUE))
  book_root <- input_dir
  while (!file.exists(file.path(book_root, "_quarto.yml")) && book_root != dirname(book_root)) {
    book_root <- dirname(book_root)
  }
  repo_root <- normalizePath(file.path(book_root, ".."))
  knitr::opts_knit$set(root.dir = repo_root)
  knitr::opts_chunk$set(cache = FALSE)
  source(file.path(repo_root, "R", "pdf_lang_helpers.R"), local = TRUE)

  # Chapter HTML lives at output/{lang}/chapters/{lang}/*.html; resources at output/{lang}/Images/
  if (grepl("[/\\\\]chapters[/\\\\][^/\\\\]+[/\\\\]", input_path)) {
    Sys.setenv(ABIDJAN_BOOK_IMG_PREFIX = "../../")
  } else {
    Sys.setenv(ABIDJAN_BOOK_IMG_PREFIX = "")
  }
}
