# Post-render fixes for the HTML book (Images/, knitr *_files/, img paths).

copy_tree <- function(src, dst) {
  if (!dir.exists(src)) {
    return(FALSE)
  }
  dir.create(dst, recursive = TRUE, showWarnings = FALSE)
  files <- list.files(src, recursive = TRUE, full.names = TRUE, all.files = FALSE)
  if (!length(files)) {
    return(FALSE)
  }
  src_norm <- normalizePath(src, winslash = "/", mustWork = TRUE)
  ok <- TRUE
  for (f in files) {
    f_norm <- normalizePath(f, winslash = "/", mustWork = FALSE)
    rel <- sub(paste0("^", src_norm, "/?"), "", f_norm)
    dest <- file.path(dst, rel)
    dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
    if (!file.copy(f, dest, overwrite = TRUE)) {
      ok <- FALSE
    }
  }
  ok
}

stage_book_images <- function(lang, root = ROOT, book_root = file.path(root, "book")) {
  src <- file.path(root, "Images")
  dst <- file.path(book_root, "output", lang, "Images")
  if (!dir.exists(src)) {
    warning("Missing Images source: ", src, call. = FALSE)
    return(invisible(0L))
  }
  if (dir.exists(dst)) {
    unlink(dst, recursive = TRUE, force = TRUE)
  }
  if (!copy_tree(src, dst)) {
    warning("Failed to copy Images to ", dst, call. = FALSE)
    return(invisible(0L))
  }
  n <- length(list.files(dst, recursive = TRUE))
  message("  copied ", n, " file(s) to book/output/", lang, "/Images/")
  invisible(n)
}

stage_book_assets <- function(lang, root = ROOT, book_root = file.path(root, "book")) {
  src <- file.path(root, "assets", "abidjan-book.css")
  dst_dir <- file.path(book_root, "output", lang, "assets")
  dst <- file.path(dst_dir, "abidjan-book.css")
  if (!file.exists(src)) {
    warning("Missing book CSS: ", src, call. = FALSE)
    return(invisible(FALSE))
  }
  dir.create(dst_dir, recursive = TRUE, showWarnings = FALSE)
  if (!file.copy(src, dst, overwrite = TRUE)) {
    warning("Failed to copy CSS to ", dst, call. = FALSE)
    return(invisible(FALSE))
  }
  message("  copied assets/abidjan-book.css to book/output/", lang, "/assets/")
  invisible(TRUE)
}

stage_book_chapter_files <- function(lang, book_root = file.path(ROOT, "book"), root = ROOT) {
  dst_chapters <- file.path(book_root, "output", lang, "chapters", lang)
  if (!dir.exists(dst_chapters)) {
    return(invisible(0L))
  }

  n <- 0L
  for (html in list.files(dst_chapters, pattern = "\\.html$")) {
    stem <- sub("\\.html$", "", html)
    files_name <- paste0(stem, "_files")
    dest <- file.path(dst_chapters, files_name)
    dest_norm <- normalizePath(dest, winslash = "/", mustWork = FALSE)

    src_roots <- unique(c(
      file.path(root, files_name),
      file.path(book_root, "chapters", lang, files_name),
      file.path(book_root, "_freeze", "chapters", lang, stem, files_name),
      file.path(book_root, ".quarto", "_freeze", "chapters", lang, stem, files_name)
    ))
    for (src in src_roots) {
      if (!dir.exists(src)) next
      src_norm <- normalizePath(src, winslash = "/", mustWork = FALSE)
      if (identical(src_norm, dest_norm)) next
      if (dir.exists(dest)) {
        unlink(dest, recursive = TRUE, force = TRUE)
      }
      if (copy_tree(src, dest)) {
        n <- n + 1L
        break
      }
    }

    # Quarto freeze stores figures under .../{stem}/figure-html/, not {stem}_files/.
    fig_dest <- file.path(dest, "figure-html")
    fig_srcs <- c(
      file.path(book_root, "_freeze", "chapters", lang, stem, "figure-html"),
      file.path(book_root, ".quarto", "_freeze", "chapters", lang, stem, "figure-html"),
      file.path(book_root, "_freeze", "chapters", lang, stem, files_name, "figure-html"),
      file.path(book_root, ".quarto", "_freeze", "chapters", lang, stem, files_name, "figure-html")
    )
    for (fig_src in fig_srcs) {
      if (!dir.exists(fig_src)) next
      dir.create(fig_dest, recursive = TRUE, showWarnings = FALSE)
      pngs <- list.files(fig_src, full.names = TRUE)
      if (length(pngs)) {
        for (f in pngs) {
          file.copy(f, file.path(fig_dest, basename(f)), overwrite = TRUE)
        }
        n <- n + 1L
      }
      break
    }
  }
  if (n > 0L) {
    message("  staged ", n, " knitr support location(s) (*_files/ / figure-html) for chapter output")
  }
  invisible(n)
}

fix_book_image_paths <- function(lang, book_root = file.path(ROOT, "book")) {
  out_root <- normalizePath(file.path(book_root, "output", lang), winslash = "/", mustWork = FALSE)
  if (!dir.exists(out_root)) {
    return(invisible(0L))
  }

  html_files <- list.files(out_root, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
  n <- 0L
  for (f in html_files) {
    f_norm <- normalizePath(f, winslash = "/", mustWork = FALSE)
    rel <- sub(paste0("^", out_root, "/?"), "", f_norm)
    depth <- length(strsplit(rel, "/", fixed = TRUE)[[1]]) - 1L
    prefix <- if (depth > 0L) paste(rep("../", depth), collapse = "") else ""

    txt <- readLines(f, warn = FALSE, encoding = "UTF-8")
    new_txt <- txt
    if (nzchar(prefix)) {
      new_txt <- gsub('src="Images/', paste0('src="', prefix, 'Images/'), new_txt, fixed = TRUE)
      new_txt <- gsub('src="images/', paste0('src="', prefix, 'Images/'), new_txt, fixed = TRUE)
    } else {
      new_txt <- gsub('src="images/', 'src="Images/', new_txt, fixed = TRUE)
    }

    css_href <- paste0('href="', prefix, 'assets/abidjan-book.css"')
    new_txt <- gsub('href="../assets/abidjan-book.css"', css_href, new_txt, fixed = TRUE)
    new_txt <- gsub('href="../../../assets/abidjan-book.css"', css_href, new_txt, fixed = TRUE)
    new_txt <- gsub('href="assets/abidjan-book.css"', css_href, new_txt, fixed = TRUE)

    if (!identical(txt, new_txt)) {
      writeLines(new_txt, f, useBytes = TRUE)
      n <- n + 1L
    }
  }
  invisible(n)
}

count_book_lectures <- function(root = ROOT) {
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
  source(file.path(root, "scripts", "index_helpers.R"), local = TRUE)
  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(root)
  n <- 0L
  for (s in sub("\\.html$", "", lectures$href)) {
    p <- resolve_qmd_path(s)
    if (!is.na(p) && nzchar(p)) {
      n <- n + 1L
    }
  }
  n
}

verify_book_output <- function(lang, book_root = file.path(ROOT, "book"), expected_lectures = NULL) {
  if (is.null(expected_lectures)) {
    expected_lectures <- count_book_lectures()
  }
  out <- file.path(book_root, "output", lang)
  chapters_dir <- file.path(out, "chapters", lang)
  chapter_html <- list.files(chapters_dir, pattern = "\\.html$", full.names = TRUE)
  images_dir <- file.path(out, "Images")
  png_count <- length(list.files(images_dir, pattern = "\\.(png|jpe?g|gif|svg)$", recursive = TRUE, ignore.case = TRUE))

  ok <- TRUE
  if (length(chapter_html) < expected_lectures) {
    warning(
      "Book ", lang, ": expected ", expected_lectures,
      " chapter HTML files, found ", length(chapter_html),
      call. = FALSE
    )
    ok <- FALSE
  }
  small <- chapter_html[file.info(chapter_html)$size < 5000]
  if (length(small)) {
    warning(
      "Book ", lang, ": suspiciously small chapter HTML: ",
      paste(basename(small), collapse = ", "),
      call. = FALSE
    )
    ok <- FALSE
  }
  if (png_count < 20L) {
    warning(
      "Book ", lang, ": Images folder has only ", png_count,
      " image(s) (expected many more). Re-run make_book().",
      call. = FALSE
    )
    ok <- FALSE
  }

  missing_figs <- character(0)
  for (html in chapter_html) {
    txt <- paste(readLines(html, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
    refs <- unique(regmatches(txt, gregexpr('[a-zA-Z0-9_-]+_files/figure-html/[^"\\s]+', txt))[[1]])
    html_dir <- dirname(html)
    for (ref in refs) {
      if (!file.exists(file.path(html_dir, ref))) {
        missing_figs <- c(missing_figs, paste0(basename(html), ": ", ref))
      }
    }
  }
  if (length(missing_figs)) {
    warning(
      "Book ", lang, ": missing R figure(s): ",
      paste(head(missing_figs, 5L), collapse = "; "),
      if (length(missing_figs) > 5L) paste0(" (+", length(missing_figs) - 5L, " more)") else "",
      call. = FALSE
    )
    ok <- FALSE
  }
  invisible(ok)
}

clear_book_freeze <- function(book_root = file.path(ROOT, "book")) {
  rel <- function(d) {
    sub(paste0("^", normalizePath(book_root, winslash = "/"), "/?"), "", normalizePath(d, winslash = "/"))
  }
  for (d in c(
    file.path(book_root, ".quarto", "_freeze"),
    file.path(book_root, "_freeze"),
    file.path(book_root, ".quarto", "idx")
  )) {
    if (dir.exists(d)) {
      label <- rel(d)
      unlink(d, recursive = TRUE, force = TRUE)
      message("  cleared ", label)
    }
  }
}

# Remove nested output/ copies Quarto can create when output/ is not ignored.
clean_book_nested_output <- function(book_root = file.path(ROOT, "book")) {
  out_root <- file.path(book_root, "output")
  if (!dir.exists(out_root)) {
    return(invisible(0L))
  }
  n <- 0L
  for (lang in c("en", "fr")) {
    nested <- file.path(out_root, lang, "output")
    if (dir.exists(nested)) {
      unlink(nested, recursive = TRUE, force = TRUE)
      n <- n + 1L
      message("  removed nested ", lang, "/output/")
    }
  }
  invisible(n)
}

quarto_log_ok <- function(log_file) {
  if (!file.exists(log_file)) {
    return(FALSE)
  }
  lines <- readLines(log_file, warn = FALSE, encoding = "UTF-8")
  if (any(grepl("^ERROR:", lines))) {
    return(FALSE)
  }
  if (any(grepl("Error encountered when rendering|Execution halted|FATAL", lines, ignore.case = TRUE))) {
    return(FALSE)
  }
  TRUE
}

summarize_quarto_log <- function(log_file) {
  if (!file.exists(log_file)) {
    return(invisible(NULL))
  }
  lines <- readLines(log_file, warn = FALSE, encoding = "UTF-8")
  progress <- grep("^\\[\\s*[0-9]+/", lines, value = TRUE)
  if (length(progress)) {
    message("  ", tail(progress, 1L))
  }
  bad <- grep("ERROR:|WARNING: Could not fetch|Execution halted|Error encountered", lines, value = TRUE)
  if (length(bad)) {
    message("--- Quarto messages ---")
    message(paste(tail(bad, 20L), collapse = "\n"))
  }
  invisible(lines)
}
