# Post-render fixes for the HTML book (Images/, knitr *_files/, img paths).

BOOK_IMAGE_EXTENSIONS <- c("png", "jpg", "jpeg", "gif", "webp", "svg")

is_book_image_file <- function(path) {
  ext <- tolower(sub(".*\\.", "", basename(path)))
  ext %in% BOOK_IMAGE_EXTENSIONS
}

copy_tree <- function(src, dst, keep = is_book_image_file) {
  if (!dir.exists(src)) {
    return(FALSE)
  }
  dir.create(dst, recursive = TRUE, showWarnings = FALSE)
  files <- list.files(src, recursive = TRUE, full.names = TRUE, all.files = FALSE)
  if (is.function(keep)) {
    files <- files[vapply(files, keep, logical(1L))]
  }
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

# Home is unnumbered: drop chapter-number on index links; renumber remaining chapters.
fix_book_home_numbering <- function(lang, book_root = file.path(ROOT, "book")) {
  out_root <- normalizePath(file.path(book_root, "output", lang), winslash = "/", mustWork = FALSE)
  if (!dir.exists(out_root)) {
    return(invisible(0L))
  }

  n <- 0L
  for (f in list.files(out_root, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)) {
    txt <- paste(readLines(f, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
    orig <- txt

    had_numbered_home <- grepl(
      'href="(?:\\./|(?:\\.\\./)+)?index\\.html"[\\s\\S]*?<span class="chapter-number">',
      txt,
      perl = TRUE
    )

    txt <- gsub(
      '(href="(?:\\./|(?:\\.\\./)+)?index\\.html"[\\s\\S]*?)<span class="chapter-number">\\d+</span>&nbsp;\\s*',
      "\\1",
      txt,
      perl = TRUE
    )

    if (isTRUE(had_numbered_home)) {
      for (num in 2:25) {
        txt <- gsub(
          sprintf('<span class="chapter-number">%d</span>', num),
          sprintf('<span class="chapter-number">__TMP_%d__</span>', num),
          txt,
          fixed = TRUE
        )
      }
      for (num in 2:25) {
        txt <- gsub(
          sprintf('<span class="chapter-number">__TMP_%d__</span>', num),
          sprintf('<span class="chapter-number">%d</span>', num - 1L),
          txt,
          fixed = TRUE
        )
      }
    }

    if (!identical(orig, txt)) {
      writeLines(strsplit(txt, "\n", fixed = TRUE)[[1]], f, useBytes = TRUE)
      n <- n + 1L
    }
  }

  if (n > 0L) {
    message("  fixed Home chapter numbering in ", n, " HTML file(s)")
  }
  invisible(n)
}

# Patch stale index.html (e.g. YAML comment rendered as "0.1 Book title/subtitle…").
fix_book_landing_page <- function(lang, book_root = file.path(ROOT, "book")) {
  bad_title <- "Book title/subtitle come from _quarto-{en,fr}.yml (profile)."
  good_title <- "Home"
  out_root <- file.path(book_root, "output", lang)
  if (!dir.exists(out_root)) {
    return(invisible(0L))
  }

  n <- 0L
  for (f in list.files(out_root, pattern = "\\.(html|json)$", recursive = TRUE, full.names = TRUE)) {
    txt <- paste(readLines(f, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
    if (!grepl(bad_title, txt, fixed = TRUE)) next
    txt <- gsub(bad_title, good_title, txt, fixed = TRUE)
    writeLines(strsplit(txt, "\n", fixed = TRUE)[[1]], f, useBytes = TRUE)
    n <- n + 1L
  }

  for (index_path in file.path(out_root, "index.html")) {
    if (!file.exists(index_path)) next
    txt <- paste(readLines(index_path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
    orig <- txt

    txt <- gsub(
      '(?s)<hr>\\s*<section id="book-titlesubtitle[^"]*" class="level2" data-number="0\\.1">.*?</section>\\s*',
      "",
      txt,
      perl = TRUE
    )
    txt <- gsub(
      '<section id="home" class="level2 unnumbered">\\s*<h2 class="unnumbered anchored" data-anchor-id="home">Home</h2>\\s*',
      '<section id="home" class="level2 unnumbered book-landing-intro">',
      txt,
      perl = TRUE
    )
    txt <- gsub(
      '(?s)<!-- margin-sidebar -->\\s*<div id="quarto-margin-sidebar" class="sidebar margin-sidebar">.*?</div>\\s*<!-- main -->',
      "<!-- main -->",
      txt,
      perl = TRUE
    )
    txt <- gsub(
      '<body class="([^"]*)"',
      '<body class="\\1 book-landing"',
      txt,
      perl = TRUE
    )

    if (!identical(orig, txt)) {
      writeLines(strsplit(txt, "\n", fixed = TRUE)[[1]], index_path, useBytes = TRUE)
      n <- n + 1L
    }
  }

  if (n > 0L) {
    message("  patched book landing page (", lang, ")")
  }
  invisible(n)
}

count_book_lectures <- function(root = ROOT) {
  count_book_chapters(root, "lecture")
}

count_book_chapters <- function(root = ROOT, kind = c("all", "lecture", "extra")) {
  kind <- match.arg(kind)
  source(file.path(root, "scripts", "sync_book_chapters.R"), local = TRUE)
  source(file.path(root, "scripts", "index_helpers.R"), local = TRUE)

  idx <- read.csv(
    file.path(root, "index.csv"),
    stringsAsFactors = FALSE,
    na.strings = c("", "NA")
  )
  idx$placeholder <- tolower(as.character(idx$placeholder)) %in%
    c("true", "t", "1", "yes")

  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(root)

  n_lectures <- 0L
  lectures <- idx[
    grepl("^L\\d+", idx$label) &
      !idx$placeholder &
      !grepl("\\.pdf$", idx$href, ignore.case = TRUE),
    ,
    drop = FALSE
  ]
  for (s in sub("\\.html$", "", lectures$href)) {
    if (!is.na(resolve_qmd_path(s))) n_lectures <- n_lectures + 1L
  }

  n_extras <- 0L
  exercises <- idx[grepl("^E\\d+", idx$label) & !idx$placeholder, , drop = FALSE]
  for (s in sub("\\.html$", "", exercises$href)) {
    if (!is.na(resolve_qmd_path(s))) n_extras <- n_extras + 1L
  }
  for (s in BOOK_QUIZ_STEMS) {
    if (!is.na(resolve_qmd_path(s))) n_extras <- n_extras + 1L
  }

  switch(
    kind,
    all = n_lectures + n_extras,
    lecture = n_lectures,
    extra = n_extras
  )
}

BOOK_RESOURCES_URL <- "https://egap.github.io/learningdays-resources/abidjan_2026/index.html"

fix_book_sidebar_nav <- function(lang, book_root = file.path(ROOT, "book"), resources_url = BOOK_RESOURCES_URL) {
  out_root <- normalizePath(file.path(book_root, "output", lang), winslash = "/", mustWork = FALSE)
  if (!dir.exists(out_root)) {
    return(invisible(0L))
  }

  resources_label <- if (lang == "fr") "Toutes les ressources" else "All resources"
  resources_li <- paste0(
    '<li class="sidebar-item sidebar-resources-link">',
    '<div class="sidebar-item-container"> ',
    '<a href="', resources_url, '" class="sidebar-item-text sidebar-link" target="_blank" rel="noopener noreferrer">',
    '<span class="menu-text">', resources_label, "</span></a>",
    "</div></li>"
  )
  marker <- 'class="sidebar-resources-link"'

  html_files <- list.files(out_root, pattern = "\\.html$", recursive = TRUE, full.names = TRUE)
  n <- 0L
  for (f in html_files) {
    f_norm <- normalizePath(f, winslash = "/", mustWork = FALSE)
    rel <- sub(paste0("^", out_root, "/?"), "", f_norm)
    depth <- length(strsplit(rel, "/", fixed = TRUE)[[1]]) - 1L
    index_href <- if (depth > 0L) {
      paste0(paste(rep("../", depth), collapse = ""), "index.html")
    } else {
      "index.html"
    }

    txt <- readLines(f, warn = FALSE, encoding = "UTF-8")
    new_txt <- gsub(
      '(<div class="sidebar-title mb-0 py-0">\\s*\\n\\s*<a href=")[^"]*(">)',
      paste0("\\1", index_href, "\\2"),
      txt,
      perl = TRUE
    )

    if (!any(grepl(marker, new_txt, fixed = TRUE))) {
      new_txt <- gsub(
        '(<ul class="list-unstyled mt-1">\\s*\\n)',
        paste0("\\1        ", resources_li, "\n"),
        new_txt,
        perl = TRUE
      )
    }

    if (!identical(txt, new_txt)) {
      writeLines(new_txt, f, useBytes = TRUE)
      n <- n + 1L
    }
  }
  if (n > 0L) {
    message("  fixed sidebar navigation in ", n, " HTML file(s)")
  }
  invisible(n)
}

verify_book_output <- function(lang, book_root = file.path(ROOT, "book"), expected_lectures = NULL) {
  if (is.null(expected_lectures)) {
    expected_lectures <- count_book_chapters()
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
