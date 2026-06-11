# Generate book/chapters/{en,fr}/*.qmd wrappers from index.csv (lectures only).
# Updates book/_quarto-en.yml and book/_quarto-fr.yml chapter lists.

sync_book_chapters <- function(root = normalizePath(".")) {
  source(file.path(root, "scripts", "index_helpers.R"), local = TRUE)
  book_root <- file.path(root, "book")
  idx <- read.csv(
    file.path(root, "index.csv"),
    stringsAsFactors = FALSE,
    na.strings = c("", "NA"),
    comment.char = ""
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
  lectures <- lectures[order(lectures$sort_order), , drop = FALSE]

  if (!nrow(lectures)) {
    stop("No lecture rows found in index.csv", call. = FALSE)
  }

  chapter_paths_en <- c("index.qmd")
  chapter_paths_fr <- c("index.qmd")
  expected_rel <- character(0)

  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(root)

  for (i in seq_len(nrow(lectures))) {
    row <- lectures[i, ]
    stem <- sub("\\.html$", "", row$href)
    qmd_path <- resolve_qmd_path(stem)
    if (is.na(qmd_path)) {
      message("Skipping (no .qmd): ", stem)
      next
    }
    child_qmd <- basename(qmd_path)

    for (lang in c("en", "fr")) {
      title <- if (lang == "en") row$title else row$title_fr
      if (is.na(title) || !nzchar(trimws(title))) {
        title <- if (lang == "en") row$title else row$title_fr
      }
      rel <- file.path("chapters", lang, paste0(stem, ".qmd"))
      expected_rel <- c(expected_rel, rel)
      out <- file.path(book_root, rel)
      dir.create(dirname(out), recursive = TRUE, showWarnings = FALSE)

      body <- c(
        "---",
        paste0('title: "', gsub('"', '\\"', trimws(title)), '"'),
        "---",
        "",
        "```{r, include=FALSE}",
        'source("../../R/chapter_setup.R")',
        paste0('init_lecture_chapter("', lang, '")'),
        "```",
        "",
        "```{r}",
        paste0("#| child: ", child_qmd),
        "#| echo: false",
        "#| warning: false",
        "#| message: false",
        "```",
        ""
      )
      writeLines(body, out, useBytes = TRUE)
    }

    chapter_paths_en <- c(
      chapter_paths_en,
      file.path("chapters", "en", paste0(stem, ".qmd"))
    )
    chapter_paths_fr <- c(
      chapter_paths_fr,
      file.path("chapters", "fr", paste0(stem, ".qmd"))
    )
  }

  prune_stale_chapters(book_root, expected_rel)

  write_profile_yml(book_root, "en", chapter_paths_en)
  write_profile_yml(book_root, "fr", chapter_paths_fr)

  message(
    "Book chapters synced: ",
    length(chapter_paths_en) - 1L,
    " lectures (+ index)"
  )

  invisible(list(en = chapter_paths_en, fr = chapter_paths_fr))
}

prune_stale_chapters <- function(book_root, keep_rel) {
  for (lang in c("en", "fr")) {
    dir_path <- file.path(book_root, "chapters", lang)
    if (!dir.exists(dir_path)) next
    existing <- list.files(dir_path, pattern = "\\.qmd$", full.names = TRUE)
    keep_abs <- file.path(book_root, keep_rel[grepl(paste0("/", lang, "/"), keep_rel)])
    for (path in existing) {
      if (!normalizePath(path, winslash = "/") %in%
          normalizePath(keep_abs, winslash = "/")) {
        unlink(path)
        message("Removed stale chapter wrapper: ", basename(path))
      }
    }
  }
}

write_profile_yml <- function(book_root, lang, chapters) {
  lines <- if (lang == "fr") {
    c(
      "lang: fr",
      "",
      "book:",
      '  title: "EGAP Learning Days Abidjan 2026"',
      '  subtitle: "Supports de cours — Français"',
      "  chapters:"
    )
  } else {
    c(
      "book:",
      '  title: "EGAP Learning Days Abidjan 2026"',
      '  subtitle: "Course materials — English"',
      "  chapters:"
    )
  }

  lines <- c(
    lines,
    paste0("    - ", chapters),
    "",
    "project:",
    paste0("  output-dir: output/", lang),
    ""
  )

  out <- file.path(book_root, paste0("_quarto-", lang, ".yml"))
  writeLines(lines, out, useBytes = TRUE)
}
