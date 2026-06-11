# Move unused files out of Images/ into images_archive/.
# Run from project root: Rscript scripts/prune_images.R
# Optional dry run: Rscript scripts/prune_images.R --dry-run

args <- commandArgs(trailingOnly = TRUE)
dry_run <- "--dry-run" %in% args

script <- sub("^--file=", "", grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)[1])
root <- normalizePath(file.path(dirname(script), ".."), winslash = "/", mustWork = TRUE)
if (!dir.exists(file.path(root, "Images"))) {
  stop("No Images/ directory under ", root, call. = FALSE)
}

scan_dirs <- c(root, file.path(root, "quizzes"))
skip_dir_parts <- c("/book/", "/images_archive/", "/.quarto/", "/.git/")

collect_text_files <- function() {
  out <- character(0)
  for (dir_path in scan_dirs) {
    if (!dir.exists(dir_path)) next
    hits <- list.files(
      dir_path,
      pattern = "\\.qmd$",
      recursive = FALSE,
      full.names = TRUE,
      ignore.case = TRUE
    )
    hits <- hits[!vapply(hits, function(p) {
      any(vapply(skip_dir_parts, function(s) grepl(s, p, fixed = TRUE), logical(1L)))
    }, logical(1L))]
    out <- c(out, hits)
  }
  unique(out)
}

extract_image_basenames <- function(text) {
  hits <- unlist(regmatches(
    text,
    gregexpr("(?i)(?:Images|images)/[^\\s\"'\\)\\}\\],`]+", text, perl = TRUE)
  ))
  if (!length(hits)) {
    return(character(0))
  }
  basenames <- basename(sub("(?i)^(Images|images)/", "", hits, perl = TRUE))
  basenames <- unique(basenames[grepl(
    "^[A-Za-z0-9._-]+\\.(png|jpe?g|gif|webp|svg)$",
    basenames,
    ignore.case = TRUE
  )])
  basenames
}

files <- collect_text_files()
text <- paste(vapply(files, function(f) paste(readLines(f, warn = FALSE, encoding = "UTF-8"), collapse = "\n"), character(1L)), collapse = "\n")
referenced <- unique(extract_image_basenames(text))

images_dir <- file.path(root, "Images")
all_files <- list.files(images_dir, full.names = FALSE, all.files = TRUE, no.. = TRUE)
all_files <- all_files[all_files != "" & !grepl("^\\.DS_Store$", all_files)]

# Keep README; everything else must be referenced or it moves to archive.
keep <- unique(c("README.md", referenced))
keep_present <- intersect(keep, all_files)
move <- setdiff(all_files, keep_present)

archive_dir <- file.path(root, "images_archive")
if (!dry_run) {
  dir.create(archive_dir, recursive = TRUE, showWarnings = FALSE)
}

message("Referenced in sources (Images/...): ", length(referenced))
if (length(referenced)) {
  for (b in sort(referenced)) message("  keep: ", b)
}

message("\nKeeping ", length(keep_present), " file(s) in Images/")
message("Moving ", length(move), " file(s) to images_archive/")

if (length(move)) {
  for (f in sort(move)) {
    src <- file.path(images_dir, f)
    dst <- file.path(archive_dir, f)
    message(if (dry_run) "  [dry-run] " else "  ", f)
    if (!dry_run) {
      if (file.exists(dst)) unlink(dst)
      ok <- file.rename(src, dst)
      if (!isTRUE(ok)) {
        stop("Failed to move: ", src, call. = FALSE)
      }
    }
  }
}

if (!dry_run && !file.exists(file.path(archive_dir, "README.md"))) {
  writeLines(
    c(
      "# images_archive",
      "",
      "Unused slide assets moved here from `Images/` to keep the active repo light.",
      "Safe to delete or move off-repo when no longer needed.",
      "",
      paste0("Pruned: ", format(Sys.time(), "%Y-%m-%d")),
      ""
    ),
    file.path(archive_dir, "README.md")
  )
}

if (!dry_run) {
  readme <- file.path(images_dir, "README.md")
  writeLines(
    c(
      "Static images referenced by Abidjan 2026 slides and the HTML book.",
      "",
      paste0("Active files: ", length(list.files(images_dir, all.files = FALSE)), " (see `scripts/prune_images.R`)"),
      "Archived unused assets live in `images_archive/`.",
      ""
    ),
    readme
  )
}

invisible(list(keep = keep_present, moved = move, referenced = referenced))
