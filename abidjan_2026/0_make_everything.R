# =============================================================================
# 0_make_everything.R — build Abidjan 2026 slides, quizzes, PDFs, and index
# =============================================================================
#
# Run from this folder (Slides_abidjan_2026):
#
#   Rscript 0_make_everything.R              # full build
#   Rscript 0_make_everything.R --html-only  # reveal.js HTML only (fastest)
#   Rscript 0_make_everything.R --index-only # refresh index.html only
#
# Or interactively:
#
#   source("0_make_everything.R")
#   make_everything()
#   make_lecture_html()
#   make_quiz_html()
#   make_lecture_pdfs()
#   make_index()
#   source("make_book.R"); make_book()  # -> book/output/en|fr/ from index.csv lectures
#
# WHAT THIS BUILDS
#   • Lecture decks  — reveal.js HTML next to each .qmd (from index.csv)
#   • Quizzes        — reveal.js HTML in quizzes/ (quiz-*.qmd)
#   • Lecture PDFs   — bilingual beamer PDFs in pdf/ (from index.csv)
#   • Index page     — index.html (deck grid + quiz links; reads index.csv)
#
# REQUIREMENTS
#   • Quarto on PATH
#   • R packages knitr + rmarkdown (index + R-heavy decks)
#   • Images/ junction to ../Images/ (created automatically if missing)
#
# NOTES
#   • index.qmd only *displays* links (helpers in scripts/index_helpers.R).
#   • Batch rendering lives here — not in index.qmd.
#   • Edit index.csv to add/reorder lecture cards, then re-run make_index().
#   • Quiz sources: quizzes/quiz-*.qmd (see make_quiz_html()).
# =============================================================================

# ---- paths ------------------------------------------------------------------

.abidjan_root <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg)) {
    normalizePath(
      dirname(sub("^--file=", "", file_arg[1])),
      winslash = "/",
      mustWork = TRUE
    )
  } else {
    normalizePath(getwd(), winslash = "/")
  }
}

ROOT <- .abidjan_root()
INDEX_CSV <- file.path(ROOT, "index.csv")
PDF_DIR <- file.path(ROOT, "pdf")

QMD_OVERRIDES <- character(0)

QUIZ_QMDS <- c(
  "quizzes/quiz-tuesday.qmd",
  "quizzes/quiz-wednesday.qmd",
  "quizzes/quiz-thursday.qmd"
)

# Extra reveal decks not listed on index.csv (optional)
EXTRA_LECTURE_QMDS <- c(
  "12b_stages.qmd"
)

# ---- helpers ----------------------------------------------------------------

stop_if_missing_quarto <- function() {
  if (Sys.which("quarto") == "") {
    stop("Quarto not found on PATH. Install from https://quarto.org", call. = FALSE)
  }
}

stop_if_missing_r_pkgs <- function() {
  required <- c("knitr", "rmarkdown")
  missing <- required[!vapply(required, requireNamespace, quietly = TRUE, FUN.VALUE = logical(1))]
  if (length(missing)) {
    stop(
      "Missing R packages for Quarto/knitr:\n  install.packages(c(",
      paste(sprintf('"%s"', missing), collapse = ", "),
      "))",
      call. = FALSE
    )
  }
}

is_placeholder <- function(value) {
  tolower(trimws(as.character(value))) %in% c("true", "t", "1", "yes")
}

href_to_qmd <- function(href) {
  if (!grepl("\\.html$", href, ignore.case = TRUE)) {
    return(NA_character_)
  }

  stem <- sub("\\.html$", "", href, ignore.case = TRUE)
  candidate <- file.path(ROOT, paste0(stem, ".qmd"))
  if (file.exists(candidate)) {
    return(normalizePath(candidate, winslash = "/", mustWork = TRUE))
  }

  override <- unname(QMD_OVERRIDES[href])
  if (!is.na(override)) {
    path <- file.path(ROOT, override)
    if (file.exists(path)) {
      return(normalizePath(path, winslash = "/", mustWork = TRUE))
    }
  }

  NA_character_
}

run_quarto <- function(qmd_path, extra_args = character()) {
  rel <- sub(paste0("^", ROOT, "/?"), "", normalizePath(qmd_path, winslash = "/", mustWork = TRUE))
  cmd <- c("render", rel, extra_args)
  message("  quarto ", paste(cmd, collapse = " "))
  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(ROOT)
  log_file <- tempfile(fileext = ".log")
  on.exit(unlink(log_file), add = TRUE)
  status <- system2("quarto", cmd, stdout = log_file, stderr = log_file, wait = TRUE)
  if (!identical(status, 0L) && file.exists(log_file)) {
    log_lines <- readLines(log_file, warn = FALSE)
    if (length(log_lines)) {
      message("--- Quarto failed: ", rel, " ---")
      message(paste(tail(log_lines, 40L), collapse = "\n"))
    }
  }
  isTRUE(status == 0)
}

cleanup_render_artifacts <- function(qmd_path) {
  stem <- tools::file_path_sans_ext(basename(qmd_path))
  files_dir <- file.path(ROOT, paste0(stem, "_files"))
  if (dir.exists(files_dir)) {
    unlink(files_dir, recursive = TRUE)
  }
  for (ext in c(".tex", ".log", ".aux", ".nav", ".snm", ".toc", ".vrb", ".out")) {
    artifact <- file.path(ROOT, paste0(stem, ext))
    if (file.exists(artifact)) {
      unlink(artifact)
    }
  }
}

cleanup_pdf_dir_junk <- function() {
  if (!dir.exists(PDF_DIR)) {
    return(invisible(NULL))
  }
  entries <- list.files(PDF_DIR, full.names = TRUE, all.files = TRUE, no.. = TRUE)
  for (entry in entries) {
    if (!grepl("\\.pdf$", entry, ignore.case = TRUE) && basename(entry) != ".gitkeep") {
      unlink(entry, recursive = TRUE)
    }
  }
}

cleanup_old_split_pdfs <- function() {
  if (!dir.exists(PDF_DIR)) {
    return(invisible(NULL))
  }
  old <- list.files(
    PDF_DIR,
    pattern = "-(en|fr)\\.pdf$",
    full.names = TRUE,
    ignore.case = TRUE
  )
  if (length(old)) {
    unlink(old)
  }
}

read_index_decks <- function() {
  if (!file.exists(INDEX_CSV)) {
    stop("Missing index.csv at: ", INDEX_CSV, call. = FALSE)
  }
  decks <- read.csv(INDEX_CSV, stringsAsFactors = FALSE, comment.char = "")
  decks[order(decks$sort_order), , drop = FALSE]
}

# ---- pre-render -------------------------------------------------------------

#' Ensure Images/ junction exists (Quarto pre-render hook).
ensure_local_images <- function(root = ROOT) {
  link <- file.path(root, "Images")
  target <- normalizePath(file.path(root, "..", "Images"), winslash = "/", mustWork = FALSE)

  if (file.exists(link)) {
    return(invisible(TRUE))
  }
  if (!dir.exists(target)) {
    warning("Missing image source: ", target, call. = FALSE)
    return(invisible(FALSE))
  }

  message("\n== Images junction ==")
  link_abs <- normalizePath(link, winslash = if (.Platform$OS.type == "windows") "\\" else "/", mustWork = FALSE)
  target_abs <- normalizePath(target, winslash = if (.Platform$OS.type == "windows") "\\" else "/", mustWork = TRUE)

  if (.Platform$OS.type == "windows") {
    status <- system2(
      "cmd",
      c("/c", sprintf('mklink /J "%s" "%s"', link_abs, target_abs)),
      stdout = FALSE,
      stderr = FALSE,
      wait = TRUE
    )
    if (!identical(status, 0L)) {
      warning("Failed to create Images junction: ", link, " -> ", target, call. = FALSE)
      return(invisible(FALSE))
    }
  } else {
    file.symlink(target_abs, link_abs)
  }

  message("Linked ", link, " -> ", target)
  invisible(TRUE)
}

#' Build saved/cardgame_simulation.rds if missing (E01_experiment_slides.qmd).
ensure_cardgame_simulation <- function() {
  out_path <- file.path(ROOT, "saved", "cardgame_simulation.rds")
  if (file.exists(out_path)) {
    return(invisible(TRUE))
  }
  script <- file.path(ROOT, "scripts", "build_cardgame_simulation.R")
  if (!file.exists(script)) {
    warning("Missing ", script, call. = FALSE)
    return(invisible(FALSE))
  }
  helpers <- new.env()
  source(script, local = helpers)
  message("\n== Card-game simulation ==")
  helpers$build_cardgame_simulation(ROOT)
}

# ---- HTML: lectures (reveal.js) ---------------------------------------------

#' Render reveal.js HTML for each index.csv deck that has a source .qmd.
make_lecture_html <- function(extra_qmds = EXTRA_LECTURE_QMDS) {
  stop_if_missing_quarto()
  stop_if_missing_r_pkgs()

  message("\n== Lecture HTML (reveal.js) ==")
  decks <- read_index_decks()

  ok <- 0L
  failed <- 0L
  skipped <- 0L

  for (i in seq_len(nrow(decks))) {
    row <- decks[i, ]
    href <- trimws(row$href)
    title <- if (!is.na(row$title) && nzchar(row$title)) row$title else href

    if (is_placeholder(row$placeholder)) {
      message("SKIP (placeholder): ", title)
      skipped <- skipped + 1L
      next
    }
    if (grepl("\\.pdf$", href, ignore.case = TRUE)) {
      message("SKIP (PDF href): ", href)
      skipped <- skipped + 1L
      next
    }

    qmd <- href_to_qmd(href)
    if (is.na(qmd)) {
      message("SKIP (no .qmd): ", href)
      skipped <- skipped + 1L
      next
    }

    message("\n", title, " — ", basename(qmd))
    if (isTRUE(run_quarto(qmd, c("--to", "revealjs")))) {
      ok <- ok + 1L
    } else {
      failed <- failed + 1L
      warning("FAILED HTML: ", basename(qmd), call. = FALSE)
    }
  }

  if (length(extra_qmds)) {
    message("\n-- Extra decks (not on index.csv) --")
    for (rel in extra_qmds) {
      qmd <- file.path(ROOT, rel)
      if (!file.exists(qmd)) {
        message("SKIP (missing): ", rel)
        skipped <- skipped + 1L
        next
      }
      message("\n", rel)
      if (isTRUE(run_quarto(qmd, c("--to", "revealjs")))) {
        ok <- ok + 1L
      } else {
        failed <- failed + 1L
        warning("FAILED HTML: ", rel, call. = FALSE)
      }
    }
  }

  message("\nLecture HTML: ", ok, " ok, ", failed, " failed, ", skipped, " skipped")
  invisible(list(ok = ok, failed = failed, skipped = skipped))
}

# ---- HTML: quizzes (reveal.js) ----------------------------------------------

#' Render bilingual quiz decks in quizzes/.
make_quiz_html <- function(quiz_qmds = QUIZ_QMDS) {
  stop_if_missing_quarto()

  message("\n== Quiz HTML (reveal.js) ==")
  ok <- 0L
  failed <- 0L
  skipped <- 0L

  for (rel in quiz_qmds) {
    qmd <- file.path(ROOT, rel)
    if (!file.exists(qmd)) {
      message("SKIP (missing): ", rel)
      skipped <- skipped + 1L
      next
    }
    message("\n", rel)
    if (isTRUE(run_quarto(qmd, c("--to", "revealjs")))) {
      ok <- ok + 1L
    } else {
      failed <- failed + 1L
      warning("FAILED quiz: ", rel, call. = FALSE)
    }
  }

  message("\nQuiz HTML: ", ok, " ok, ", failed, " failed, ", skipped, " skipped")
  invisible(list(ok = ok, failed = failed, skipped = skipped))
}

# ---- PDF: lectures (beamer) -------------------------------------------------

render_one_pdf <- function(qmd, output_pdf) {
  temp_pdf <- paste0(".render-", basename(output_pdf))
  temp_path <- file.path(ROOT, temp_pdf)

  if (file.exists(temp_path)) {
    unlink(temp_path)
  }

  ok <- run_quarto(
    qmd,
    c("--to", "beamer", "-o", temp_pdf)
  )

  if (!ok || !file.exists(temp_path)) {
    if (file.exists(temp_path)) {
      unlink(temp_path)
    }
    cleanup_render_artifacts(qmd)
    return(FALSE)
  }

  dir.create(dirname(output_pdf), recursive = TRUE, showWarnings = FALSE)
  if (file.exists(output_pdf)) {
    unlink(output_pdf)
  }
  moved <- file.rename(temp_path, output_pdf)
  cleanup_render_artifacts(qmd)
  isTRUE(moved)
}

#' Render bilingual beamer PDFs for index.csv decks into pdf/.
make_lecture_pdfs <- function() {
  stop_if_missing_quarto()
  stop_if_missing_r_pkgs()

  message("\n== Lecture PDFs (beamer) ==")
  dir.create(PDF_DIR, recursive = TRUE, showWarnings = FALSE)
  cleanup_pdf_dir_junk()
  cleanup_old_split_pdfs()

  decks <- read_index_decks()
  ok <- 0L
  failed <- 0L
  skipped <- 0L

  for (i in seq_len(nrow(decks))) {
    row <- decks[i, ]
    href <- trimws(row$href)
    title <- if (!is.na(row$title) && nzchar(row$title)) row$title else href

    if (is_placeholder(row$placeholder)) {
      message("SKIP (placeholder): ", title)
      skipped <- skipped + 1L
      next
    }
    if (grepl("\\.pdf$", href, ignore.case = TRUE)) {
      message("SKIP (already PDF href): ", href)
      skipped <- skipped + 1L
      next
    }

    qmd <- href_to_qmd(href)
    if (is.na(qmd)) {
      message("SKIP (no .qmd): ", href)
      skipped <- skipped + 1L
      next
    }

    stem <- sub("\\.html$", "", href, ignore.case = TRUE)
    output_pdf <- file.path(PDF_DIR, paste0(stem, ".pdf"))
    message("\n", title)
    message("  ", basename(qmd), " -> pdf/", basename(output_pdf))

    if (isTRUE(render_one_pdf(qmd, output_pdf))) {
      ok <- ok + 1L
    } else {
      failed <- failed + 1L
      warning("FAILED PDF: ", basename(output_pdf), call. = FALSE)
    }
  }

  cleanup_pdf_dir_junk()
  message("\nLecture PDF: ", ok, " ok, ", failed, " failed, ", skipped, " skipped")
  invisible(list(ok = ok, failed = failed, skipped = skipped))
}

# ---- index hub page ---------------------------------------------------------

#' Render index.html (deck grid + quiz links from index.csv).
make_index <- function() {
  stop_if_missing_quarto()
  stop_if_missing_r_pkgs()

  message("\n== Index page ==")
  qmd <- file.path(ROOT, "index.qmd")
  if (!file.exists(qmd)) {
    stop("Missing index.qmd", call. = FALSE)
  }
  ok <- run_quarto(qmd, c("--to", "html"))
  if (!ok) {
    stop("Failed to render index.qmd", call. = FALSE)
  }
  message("Wrote index.html")
  invisible(TRUE)
}

# ---- full pipeline ----------------------------------------------------------

#' Run the full build (or a subset via flags).
make_everything <- function(
  html = TRUE,
  quizzes = TRUE,
  pdfs = TRUE,
  index = TRUE,
  images = TRUE
) {
  stop_if_missing_quarto()

  t0 <- Sys.time()
  message("Abidjan 2026 build — root: ", ROOT)

  if (images) {
    ensure_local_images()
    ensure_cardgame_simulation()
  }
  if (html) {
    make_lecture_html()
  }
  if (quizzes) {
    make_quiz_html()
  }
  if (pdfs) {
    make_lecture_pdfs()
  }
  if (index) {
    make_index()
  }

  elapsed <- round(difftime(Sys.time(), t0, units = "mins"), 1)
  message("\nAll done (", elapsed, " min).")
  invisible(TRUE)
}

# ---- CLI --------------------------------------------------------------------

.abidjan_cli <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  if (!length(args)) {
    make_everything()
    return(invisible(NULL))
  }

  if ("--html-only" %in% args) {
    ensure_local_images()
    ensure_cardgame_simulation()
    make_lecture_html()
    make_quiz_html()
    make_index()
    return(invisible(NULL))
  }
  if ("--index-only" %in% args) {
    make_index()
    return(invisible(NULL))
  }
  if ("--pdf-only" %in% args) {
    make_lecture_pdfs()
    make_index()
    return(invisible(NULL))
  }
  if ("--quizzes-only" %in% args) {
    make_quiz_html()
    make_index()
    return(invisible(NULL))
  }

  stop(
    "Unknown args: ", paste(args, collapse = " "),
    "\nTry: --html-only | --pdf-only | --quizzes-only | --index-only",
    call. = FALSE
  )
}

# Run CLI only when executed as Rscript 0_make_everything.R (not when sourced).
if (sys.nframe() == 0L) {
  .abidjan_cli()
}
