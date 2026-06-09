#!/usr/bin/env Rscript
# Render bilingual beamer PDFs for index.csv decks.
#
# Usage (from Slides_abidjan_2026/):
#   Rscript scripts/render_lecture_pdfs.R

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
root <- if (length(file_arg)) {
  normalizePath(file.path(dirname(sub("^--file=", "", file_arg[1])), ".."), winslash = "/")
} else {
  normalizePath(getwd(), winslash = "/")
}

pdf_dir <- file.path(root, "pdf")
index_csv <- file.path(root, "index.csv")

qmd_overrides <- c(
  "15_grants.html" = "13_grants.qmd"
)

required_pkgs <- c("knitr", "rmarkdown")
missing_pkgs <- required_pkgs[!vapply(
  required_pkgs,
  requireNamespace,
  quietly = TRUE,
  FUN.VALUE = logical(1)
)]
if (length(missing_pkgs)) {
  stop(
    "Quarto needs these R packages in the R installation it uses:\n  ",
    paste0("install.packages(c(", paste(sprintf('"%s"', missing_pkgs), collapse = ", "), "))"),
    call. = FALSE
  )
}

if (!file.exists(index_csv)) {
  stop("Missing index.csv at: ", index_csv, call. = FALSE)
}

dir.create(pdf_dir, recursive = TRUE, showWarnings = FALSE)

is_placeholder <- function(value) {
  tolower(trimws(as.character(value))) %in% c("true", "t", "1", "yes")
}

href_to_qmd <- function(href) {
  if (!grepl("\\.html$", href, ignore.case = TRUE)) {
    return(NA_character_)
  }

  stem <- sub("\\.html$", "", href, ignore.case = TRUE)
  candidate <- file.path(root, paste0(stem, ".qmd"))
  if (file.exists(candidate)) {
    return(candidate)
  }

  override <- unname(qmd_overrides[href])
  if (!is.na(override)) {
    path <- file.path(root, override)
    if (file.exists(path)) {
      return(path)
    }
  }

  NA_character_
}

cleanup_pdf_dir_junk <- function() {
  entries <- list.files(pdf_dir, full.names = TRUE, all.files = TRUE, no.. = TRUE)
  for (entry in entries) {
    if (!grepl("\\.pdf$", entry, ignore.case = TRUE) && basename(entry) != ".gitkeep") {
      unlink(entry, recursive = TRUE)
    }
  }
}

cleanup_old_split_pdfs <- function() {
  old <- list.files(
    pdf_dir,
    pattern = "-(en|fr)\\.pdf$",
    full.names = TRUE,
    ignore.case = TRUE
  )
  if (length(old)) {
    unlink(old)
  }
}

cleanup_render_artifacts <- function(qmd_path) {
  stem <- tools::file_path_sans_ext(basename(qmd_path))
  files_dir <- file.path(root, paste0(stem, "_files"))
  if (dir.exists(files_dir)) {
    unlink(files_dir, recursive = TRUE)
  }
  for (ext in c(".tex", ".log", ".aux", ".nav", ".snm", ".toc", ".vrb", ".out")) {
    artifact <- file.path(root, paste0(stem, ext))
    if (file.exists(artifact)) {
      unlink(artifact)
    }
  }
}

render_pdf <- function(qmd, output_pdf) {
  temp_pdf <- paste0(".render-", basename(output_pdf))
  temp_path <- file.path(root, temp_pdf)

  cmd <- c(
    "render",
    basename(qmd),
    "--to", "beamer",
    "-o", temp_pdf
  )

  message("  quarto ", paste(cmd, collapse = " "))
  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(root)

  if (file.exists(temp_path)) {
    unlink(temp_path)
  }

  status <- system2("quarto", cmd, stdout = "", stderr = "", wait = TRUE)
  if (!isTRUE(status == 0) || !file.exists(temp_path)) {
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
  ok <- file.rename(temp_path, output_pdf)
  cleanup_render_artifacts(qmd)
  isTRUE(ok)
}

cleanup_pdf_dir_junk()
cleanup_old_split_pdfs()

decks <- read.csv(index_csv, stringsAsFactors = FALSE, comment.char = "")
decks <- decks[order(decks$sort_order), , drop = FALSE]

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
    message("SKIP (already PDF): ", href)
    skipped <- skipped + 1L
    next
  }

  qmd <- href_to_qmd(href)
  if (is.na(qmd)) {
    message("SKIP (no source .qmd): ", href)
    skipped <- skipped + 1L
    next
  }

  stem <- sub("\\.html$", "", href, ignore.case = TRUE)
  output_pdf <- file.path(pdf_dir, paste0(stem, ".pdf"))
  message("\n", title)
  message("  source: ", basename(qmd), " -> pdf/", basename(output_pdf))

  if (isTRUE(render_pdf(qmd, output_pdf))) {
    ok <- ok + 1L
  } else {
    failed <- failed + 1L
    warning("FAILED: ", basename(output_pdf), call. = FALSE)
  }
}

cleanup_pdf_dir_junk()
message("\nDone: ", ok, " rendered, ", failed, " failed, ", skipped, " skipped")
if (failed > 0L) {
  quit(save = "no", status = 1)
}
