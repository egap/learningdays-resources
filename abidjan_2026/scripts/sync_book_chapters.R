# Generate book/chapters/{en,fr}/*.qmd wrappers from index.csv + quizzes.
# Updates book/_quarto-en.yml and book/_quarto-fr.yml chapter lists (with parts).

BOOK_QUIZ_STEMS <- c(
  "quizzes/quiz-tuesday",
  "quizzes/quiz-wednesday",
  "quizzes/quiz-thursday"
)

BOOK_QUIZ_TITLES <- list(
  en = c("Quiz — Day 2", "Quiz — Day 3", "Quiz — Day 4"),
  fr = c("Quiz — jour 2", "Quiz — jour 3", "Quiz — jour 4")
)

BOOK_PART_TITLES <- list(
  en = c(lectures = "Lectures", extras = "Exercises & quizzes"),
  fr = c(lectures = "Cours", extras = "Exercices et quiz")
)

BOOK_RESOURCES_URL <- "https://egap.github.io/learningdays-resources/abidjan_2026/index.html"

format_book_chapter_title <- function(title) {
  title <- trimws(as.character(title))
  if (!nzchar(title) || is.na(title)) {
    return("")
  }
  title
}

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
    grepl("^L\\d+", idx$label) &
      !idx$placeholder &
      !grepl("\\.pdf$", idx$href, ignore.case = TRUE),
    ,
    drop = FALSE
  ]
  lectures <- lectures[order(lectures$sort_order), , drop = FALSE]

  exercises <- idx[
    grepl("^E\\d+", idx$label) & !idx$placeholder,
    ,
    drop = FALSE
  ]
  exercises <- exercises[order(exercises$sort_order), , drop = FALSE]

  if (!nrow(lectures)) {
    stop("No lecture rows found in index.csv", call. = FALSE)
  }

  expected_rel <- character(0)
  lecture_paths_en <- character(0)
  lecture_paths_fr <- character(0)
  extra_paths_en <- character(0)
  extra_paths_fr <- character(0)

  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(root)

  add_row_chapter <- function(row, paths_en, paths_fr, expected) {
    stem <- sub("\\.html$", "", row$href)
    qmd_path <- resolve_qmd_path(stem)
    if (is.na(qmd_path)) {
      message("Skipping (no .qmd): ", stem)
      return(list(en = paths_en, fr = paths_fr, expected = expected))
    }
    wrapper_stem <- basename(stem)
    child_qmd <- if (grepl("/", qmd_path, fixed = TRUE)) qmd_path else basename(qmd_path)

    for (lang in c("en", "fr")) {
      title <- if (lang == "en") row$title else row$title_fr
      if (is.na(title) || !nzchar(trimws(title))) {
        title <- row$title
      }
      title <- format_book_chapter_title(title)
      rel <- write_chapter_wrapper(
        book_root = book_root,
        lang = lang,
        wrapper_stem = wrapper_stem,
        title = title,
        child_qmd = child_qmd
      )
      expected <- c(expected, rel)
      if (lang == "en") {
        paths_en <- c(paths_en, rel)
      } else {
        paths_fr <- c(paths_fr, rel)
      }
    }

    list(en = paths_en, fr = paths_fr, expected = expected)
  }

  for (i in seq_len(nrow(lectures))) {
    out <- add_row_chapter(lectures[i, ], lecture_paths_en, lecture_paths_fr, expected_rel)
    lecture_paths_en <- out$en
    lecture_paths_fr <- out$fr
    expected_rel <- out$expected
  }

  for (i in seq_len(nrow(exercises))) {
    out <- add_row_chapter(exercises[i, ], extra_paths_en, extra_paths_fr, expected_rel)
    extra_paths_en <- out$en
    extra_paths_fr <- out$fr
    expected_rel <- out$expected
  }

  for (i in seq_along(BOOK_QUIZ_STEMS)) {
    stem <- BOOK_QUIZ_STEMS[[i]]
    qmd_path <- resolve_qmd_path(stem)
    if (is.na(qmd_path)) {
      message("Skipping (no .qmd): ", stem)
      next
    }
    wrapper_stem <- sub("\\.qmd$", "", basename(qmd_path))
    for (lang in c("en", "fr")) {
      title <- BOOK_QUIZ_TITLES[[lang]][[i]]
      rel <- write_chapter_wrapper(
        book_root = book_root,
        lang = lang,
        wrapper_stem = wrapper_stem,
        title = title,
        child_qmd = qmd_path
      )
      expected_rel <- c(expected_rel, rel)
      if (lang == "en") {
        extra_paths_en <- c(extra_paths_en, rel)
      } else {
        extra_paths_fr <- c(extra_paths_fr, rel)
      }
    }
  }

  prune_stale_chapters(book_root, expected_rel)

  spec_en <- list(
    list(type = "chapter", path = "index.qmd"),
    list(type = "part", title = BOOK_PART_TITLES$en[["lectures"]], chapters = lecture_paths_en),
    list(type = "part", title = BOOK_PART_TITLES$en[["extras"]], chapters = extra_paths_en)
  )
  spec_fr <- list(
    list(type = "chapter", path = "index.qmd"),
    list(type = "part", title = BOOK_PART_TITLES$fr[["lectures"]], chapters = lecture_paths_fr),
    list(type = "part", title = BOOK_PART_TITLES$fr[["extras"]], chapters = extra_paths_fr)
  )

  write_profile_yml(book_root, "en", spec_en)
  write_profile_yml(book_root, "fr", spec_fr)

  message(
    "Book chapters synced: ",
    length(lecture_paths_en), " lectures + ",
    length(extra_paths_en), " exercises/quizzes (+ index, 2 parts)"
  )

  invisible(list(
    en = c("index.qmd", lecture_paths_en, extra_paths_en),
    fr = c("index.qmd", lecture_paths_fr, extra_paths_fr)
  ))
}

write_chapter_wrapper <- function(book_root, lang, wrapper_stem, title, child_qmd) {
  rel <- file.path("chapters", lang, paste0(wrapper_stem, ".qmd"))
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
  rel
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

write_profile_yml <- function(book_root, lang, spec) {
  resources_label <- if (lang == "fr") "Toutes les ressources" else "All resources"

  lines <- if (lang == "fr") {
    c(
      "lang: fr",
      "",
      "book:",
      '  title: "EGAP Learning Days Abidjan 2026"',
      '  subtitle: "Supports de cours — Français"',
      "  navbar:",
      "    search: true",
      "    left:",
      paste0('      - text: "', resources_label, '"'),
      paste0('        href: "', BOOK_RESOURCES_URL, '"'),
      "  chapters:"
    )
  } else {
    c(
      "book:",
      '  title: "EGAP Learning Days Abidjan 2026"',
      '  subtitle: "Course materials — English"',
      "  navbar:",
      "    search: true",
      "    left:",
      paste0('      - text: "', resources_label, '"'),
      paste0('        href: "', BOOK_RESOURCES_URL, '"'),
      "  chapters:"
    )
  }

  for (item in spec) {
    if (identical(item$type, "chapter")) {
      lines <- c(lines, paste0("    - ", item$path))
    } else if (identical(item$type, "part")) {
      lines <- c(
        lines,
        paste0('    - part: "', gsub('"', '\\"', item$title), '"'),
        "      chapters:"
      )
      if (length(item$chapters)) {
        lines <- c(lines, paste0("        - ", item$chapters))
      }
    }
  }

  lines <- c(
    lines,
    "",
    "project:",
    paste0("  output-dir: output/", lang),
    ""
  )

  out <- file.path(book_root, paste0("_quarto-", lang, ".yml"))
  writeLines(lines, out, useBytes = TRUE)
}
