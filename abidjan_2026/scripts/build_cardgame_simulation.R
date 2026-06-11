# Build saved/cardgame_simulation.rds for 2_experiment_slides.qmd
# Source from 0_make_everything.R or: Rscript scripts/build_cardgame_simulation.R

build_cardgame_simulation <- function(
  root = NULL,
  sims = 1000,
  seed = 1,
  force = FALSE
) {
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

  out_dir <- file.path(root, "saved")
  out_path <- file.path(out_dir, "cardgame_simulation.rds")
  if (file.exists(out_path) && !isTRUE(force)) {
    return(invisible(out_path))
  }

  if (!requireNamespace("DeclareDesign", quietly = TRUE)) {
    stop("Package 'DeclareDesign' is required to build cardgame_simulation.rds.", call. = FALSE)
  }
  suppressPackageStartupMessages(library(DeclareDesign))

  set.seed(seed)
  full_data <- fabricate(
    N = 20,
    prompt = sample(rep(c(FALSE, TRUE), each = 10)),
    clue = seq(-19, 19, 2),
    ID = sample(1:20),
    Y0 = 1:20,
    Y1a = 20:1,
    Y1b = 1:20,
    Y1c = 20:1 + 5 + clue,
    Y1d = 1:20 + 5 + clue,
    Y1e = rep(15, 20),
    Y1f = 2 * (20:1) * prompt + 5
  )

  design <- declare_model(
    full_data,
    Z = simple_ra(N),
    Ya = Z * Y1a + (1 - Z) * Y0,
    Yb = Z * Y1b + (1 - Z) * Y0,
    Yc = Z * Y1c + (1 - Z) * Y0,
    Yd = Z * Y1d + (1 - Z) * Y0,
    Ye = Z * Y1e + (1 - Z) * Y0,
    Yf = Z * Y1f + (1 - Z) * Y0
  ) +
    declare_inquiry(
      Qa = mean(Y1a - Y0),
      Qb = mean(Y1b - Y0),
      Qc = mean(Y1c - Y0),
      Qd = mean(Y1d - Y0),
      Qe = mean(Y1e - Y0),
      Qf = mean(Y1f - Y0)
    ) +
    declare_estimator(Ya ~ Z, inquiry = "Qa", label = "a") +
    declare_estimator(Yb ~ Z, inquiry = "Qb", label = "b") +
    declare_estimator(Yc ~ Z, inquiry = "Qc", label = "c") +
    declare_estimator(Yd ~ Z, inquiry = "Qd", label = "d") +
    declare_estimator(Ye ~ Z, inquiry = "Qe", label = "e") +
    declare_estimator(Yf ~ Z, inquiry = "Qf", label = "f")

  message("Simulating card-game diagnosis (sims = ", sims, ") ...")
  diagnosis <- diagnose_design(design, sims = sims)

  if (!dir.exists(out_dir)) {
    dir.create(out_dir, recursive = TRUE)
  }
  saveRDS(diagnosis, out_path)
  message("Wrote ", out_path)
  invisible(out_path)
}

if (!interactive()) {
  build_cardgame_simulation()
}
