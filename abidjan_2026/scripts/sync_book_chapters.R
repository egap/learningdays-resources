# Generate book/chapters/{en,fr}/*.qmd wrappers from index.csv (lectures only).

# Updates book/_quarto-en.yml and book/_quarto-fr.yml chapter lists.

#

#   source("scripts/sync_book_chapters.R")

#   sync_book_chapters()



sync_book_chapters <- function(root = normalizePath(".")) {

  book_root <- file.path(root, "book")

  idx <- read.csv(file.path(root, "index.csv"), stringsAsFactors = FALSE)



  lectures <- idx[

    grepl("^Lecture", idx$label) &

      !idx$placeholder &

      !grepl("\\.pdf$", idx$href, ignore.case = TRUE),

    ,

    drop = FALSE

  ]



  if (!nrow(lectures)) {

    stop("No lecture rows found in index.csv", call. = FALSE)

  }



  chapter_paths_en <- c("index.qmd")

  chapter_paths_fr <- c("index.qmd")



  for (i in seq_len(nrow(lectures))) {

    row <- lectures[i, ]

    stem <- sub("\\.html$", "", row$href)

    qmd <- paste0(stem, ".qmd")

    if (!file.exists(file.path(root, qmd))) {

      message("Skipping (no .qmd): ", qmd)

      next

    }



    for (lang in c("en", "fr")) {

      title <- if (lang == "en") row$title else row$title_fr

      rel <- file.path("chapters", lang, paste0(stem, ".qmd"))

      out <- file.path(book_root, rel)

      dir.create(dirname(out), recursive = TRUE, showWarnings = FALSE)



      body <- c(

        "---",

        paste0('title: "', gsub('"', '\\"', title), '"'),

        "---",

        "",

        "```{r, include=FALSE}",

        'source("../../R/chapter_setup.R")',

        paste0('init_lecture_chapter("', lang, '")'),

        "```",

        "",

        "```{r}",

        paste0("#| child: ", stem, ".qmd"),

        "#| echo: false",

        "#| warning: false",

        "#| message: false",

        "```",

        ""

      )

      writeLines(body, out, useBytes = TRUE)

      message("Wrote ", rel)

    }



    chapter_paths_en <- c(chapter_paths_en, file.path("chapters", "en", paste0(stem, ".qmd")))

    chapter_paths_fr <- c(chapter_paths_fr, file.path("chapters", "fr", paste0(stem, ".qmd")))

  }



  write_profile_yml(book_root, "en", chapter_paths_en)

  write_profile_yml(book_root, "fr", chapter_paths_fr)



  invisible(list(en = chapter_paths_en, fr = chapter_paths_fr))

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

  message("Updated ", basename(out), " (", length(chapters), " entries)")

}



if (sys.nframe() == 0L) {

  sync_book_chapters()

}


