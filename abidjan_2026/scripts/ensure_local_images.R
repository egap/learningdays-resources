# Ensure Slides_abidjan_2026/Images points at repo Images/ (for file:// and local render).
# Run via Quarto pre-render or: Rscript scripts/ensure_local_images.R [project_root]

ensure_local_images <- function(root = NULL) {
  if (is.null(root)) {
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) >= 1L) {
      root <- normalizePath(args[[1L]], winslash = "/", mustWork = TRUE)
    } else {
      script <- sub("^--file=", "", grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE))
      root <- normalizePath(file.path(dirname(script), ".."), winslash = "/", mustWork = TRUE)
    }
  } else {
    root <- normalizePath(root, winslash = "/", mustWork = TRUE)
  }

  link <- file.path(root, "Images")
  target <- normalizePath(file.path(root, "..", "Images"), winslash = "/", mustWork = FALSE)

  if (file.exists(link)) {
    return(invisible(TRUE))
  }
  if (!dir.exists(target)) {
    warning("Missing image source: ", target, call. = FALSE)
    return(invisible(FALSE))
  }

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

if (!interactive()) {
  ok <- ensure_local_images()
  if (!isTRUE(ok)) {
    quit(save = "no", status = 1L)
  }
}
