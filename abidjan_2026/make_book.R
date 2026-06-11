# Build monolingual HTML course books from lecture .qmd files in index.csv.
#
#   source("make_book.R")
#   make_book()
#
# Every run re-executes all R chunks (no Quarto freeze / knitr cache).
# Output (one HTML page per lecture):
#   book/output/en/index.html
#   book/output/fr/index.html

source("0_make_everything.R")
source("scripts/sync_book_chapters.R")
source("scripts/book_postprocess.R")

BOOK_ROOT <- file.path(ROOT, "book")
BOOK_LANGS <- c("en", "fr")

STALE_BOOK_HTML <- file.path(BOOK_ROOT, "output", c("book_en.html", "book_fr.html"))

remove_stale_book_html <- function() {
  for (path in STALE_BOOK_HTML) {
    if (file.exists(path)) {
      unlink(path)
      message("  removed stale ", basename(path))
    }
  }
}

clean_book_chapter_artifacts <- function() {
  for (lang in c("en", "fr")) {
    chapter_dir <- file.path(BOOK_ROOT, "chapters", lang)
    if (!dir.exists(chapter_dir)) next
    dirs <- list.dirs(chapter_dir, recursive = FALSE, full.names = TRUE)
    dirs <- dirs[grepl("_files$", basename(dirs))]
    for (d in dirs) {
      tryCatch(unlink(d, recursive = TRUE, force = TRUE), error = function(e) NULL)
      if (dir.exists(d)) {
        Sys.sleep(1)
        unlink(d, recursive = TRUE, force = TRUE)
      }
    }
  }
}

run_quarto_book <- function(profile, extra_args = character()) {
  cmd <- c("render", "--profile", profile, extra_args)
  message("  quarto ", paste(cmd, collapse = " "), "  (project: book/)")

  log_file <- tempfile(fileext = ".log")
  on.exit(unlink(log_file), add = TRUE)

  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(BOOK_ROOT)

  status <- system2("quarto", cmd, stdout = log_file, stderr = log_file, wait = TRUE)
  summarize_quarto_log(log_file)

  isTRUE(status == 0) && isTRUE(quarto_log_ok(log_file))
}

make_book <- function(langs = BOOK_LANGS, sync = TRUE) {
  stop_if_missing_quarto()
  stop_if_missing_r_pkgs()

  if (isTRUE(getOption("abidjan.ensure_images", TRUE))) {
    ensure_local_images()
  }

  if (isTRUE(sync)) {
    message("\n== Sync book chapters from index.csv ==")
    sync_book_chapters(ROOT)
  }

  message("\n== Fresh book build (all R chunks re-run) ==")
  clear_book_freeze()

  remove_stale_book_html()
  clean_book_chapter_artifacts()
  clean_book_nested_output()

  expected_lectures <- count_book_lectures()
  ok <- 0L
  failed <- 0L
  old_lang <- Sys.getenv("ABIDJAN_LANG", unset = NA_character_)
  on.exit(
    {
      if (is.na(old_lang)) {
        Sys.unsetenv("ABIDJAN_LANG")
      } else {
        Sys.setenv(ABIDJAN_LANG = old_lang)
      }
    },
    add = TRUE
  )

  for (lang in langs) {
    lang <- match.arg(lang, BOOK_LANGS)
    out_index <- file.path(BOOK_ROOT, "output", lang, "index.html")

    message("\n== Book ", lang, " ==")
    message("  profile: ", lang, " -> book/output/", lang, "/")
    message("  expecting ", expected_lectures, " lecture chapters")

    Sys.setenv(ABIDJAN_LANG = lang)

    render_ok <- isTRUE(run_quarto_book(lang))
    clean_book_nested_output()
    stage_book_assets(lang)
    stage_book_images(lang)
    stage_book_chapter_files(lang)
    n_fixed <- fix_book_image_paths(lang)
    if (n_fixed > 0L) {
      message("  fixed image paths in ", n_fixed, " HTML file(s)")
    }
    verify_ok <- isTRUE(verify_book_output(lang, expected_lectures = expected_lectures))

    if (render_ok && verify_ok) {
      ok <- ok + 1L
      message("  OPEN: ", out_index)
    } else {
      failed <- failed + 1L
      if (!render_ok) {
        warning("FAILED book render: ", lang, call. = FALSE)
      } else {
        warning(
          "Book ", lang, " render exited OK but output verification failed. ",
          "Re-run make_book() from RStudio.",
          call. = FALSE
        )
      }
    }
  }

  message("\nBook: ", ok, " ok, ", failed, " failed")
  invisible(list(ok = ok, failed = failed, output_dir = file.path(BOOK_ROOT, "output")))
}

make_book_poc <- make_book

if (sys.nframe() == 0L) {
  make_book()
}
