# Build monolingual HTML course books from existing lecture .qmd files.

#

#   source("make_book.R")

#   make_book_poc()

#

# Quarto book project (book/): one HTML page per lecture chapter.

#   book/output/en/index.html

#   book/output/en/chapters/en/1_why-experiment.html

#   book/output/fr/...

#

# Chapters = lectures from index.csv (see scripts/sync_book_chapters.R).
# POC profile lists: 1_why-experiment, 2_causalinference




source("0_make_everything.R")



BOOK_ROOT <- file.path(ROOT, "book")

BOOK_LANGS <- c("en", "fr")



run_quarto_book <- function(profile, extra_args = character()) {

  cmd <- c("render", "--profile", profile, extra_args)

  message("  quarto ", paste(cmd, collapse = " "), "  (project: book/)")



  log_file <- tempfile(fileext = ".log")

  on.exit(unlink(log_file), add = TRUE)



  old_wd <- getwd()

  on.exit(setwd(old_wd), add = TRUE)

  setwd(BOOK_ROOT)



  status <- system2("quarto", cmd, stdout = log_file, stderr = log_file, wait = TRUE)

  if (!identical(status, 0L) && file.exists(log_file)) {

    log_lines <- readLines(log_file, warn = FALSE)

    if (length(log_lines)) {

      message("--- Quarto failed: profile ", profile, " ---")

      message(paste(tail(log_lines, 40L), collapse = "\n"))

    }

  }

  isTRUE(status == 0)

}



make_book_poc <- function(langs = BOOK_LANGS) {

  stop_if_missing_quarto()

  stop_if_missing_r_pkgs()



  if (isTRUE(getOption("abidjan.ensure_images", TRUE))) {

    ensure_local_images()

  }



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

    out_dir <- file.path(BOOK_ROOT, "output", lang)

    out_index <- file.path(out_dir, "index.html")



    message("\n== Book ", lang, " (HTML, one page per lecture) ==")

    message("  profile: ", lang, " -> book/output/", lang, "/")



    Sys.setenv(ABIDJAN_LANG = lang)



    if (isTRUE(run_quarto_book(lang))) {

      ok <- ok + 1L

      if (file.exists(out_index)) {

        message("  -> ", out_index)

      }

    } else {

      failed <- failed + 1L

      warning("FAILED book profile: ", lang, call. = FALSE)

    }

  }



  message("\nBook POC: ", ok, " ok, ", failed, " failed")

  invisible(list(ok = ok, failed = failed, output_dir = file.path(BOOK_ROOT, "output")))

}



if (sys.nframe() == 0L) {

  make_book_poc()

}


