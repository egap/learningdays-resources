#!/usr/bin/env Rscript
# Thin wrapper — PDF build logic lives in 0_make_everything.R
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

source(file.path(root, "0_make_everything.R"), local = FALSE)

result <- make_lecture_pdfs()
if (isTRUE(result$failed > 0L)) {
  quit(save = "no", status = 1)
}
