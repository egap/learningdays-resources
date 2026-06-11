# Shared knitr setup for lecture chapter wrappers (book/chapters/*/*.qmd).
init_lecture_chapter <- function(lang = "en") {
  Sys.setenv(ABIDJAN_LANG = lang)

  input_dir <- dirname(knitr::current_input(dir = TRUE))
  book_root <- input_dir
  while (!file.exists(file.path(book_root, "_quarto.yml")) && book_root != dirname(book_root)) {
    book_root <- dirname(book_root)
  }
  repo_root <- normalizePath(file.path(book_root, ".."))
  knitr::opts_knit$set(root.dir = repo_root)
  source(file.path(repo_root, "R", "pdf_lang_helpers.R"), local = TRUE)
}
