#' Shared knitr configuration for the santiago_2026 Quarto decks.
#'
#' Adapted from slides/rmd_setup.R, the helper the legacy .Rmd decks source.
#' Two deliberate differences:
#'   1. No library() grab-bag -- each deck's setup chunk loads the packages
#'      that deck actually uses, so renv/replication captures true deps.
#'   2. The LaTeX-only chunk defaults (\scriptsize, \textwidth, fig.pos)
#'      apply only when rendering beamer; the reveal.js HTML gets percentage
#'      widths instead of \textwidth strings the browser cannot parse.
#' slides/rmd_setup.R stays untouched for the archived .Rmd sources.

library(knitr)

options(width = 132, digits = 4, scipen = 3)

options(knitr.table.format = function() {
  if (knitr::is_latex_output()) "latex" else "pandoc"
})

## Chunks set size="\\scriptsize" to shrink code on beamer slides; this hook
## restores \normalsize after the chunk. HTML output needs neither.
## The blank lines around the size commands matter: knitr concatenates the
## before-hook string directly onto the chunk's first output line, and when
## that line is a "::: {.cell-output...}" fence (echo=FALSE chunks), a bare
## "\\scriptsize" glues onto the fence and breaks it, leaving literal ":::"
## text on the slides.
knitr::knit_hooks$set(mysize = function(before, options, envir) {
  if (!knitr::is_latex_output()) {
    return(NULL)
  }
  if (before) {
    return(paste0(options$size, "\n\n"))
  } else {
    return("\n\n\\normalsize")
  }
})

## Tight base-graphics margins so slide figures do not waste space
knit_hooks$set(plotdefault = function(before, options, envir) {
  if (before) par(mar = c(3, 3, .1, .1), oma = rep(0, 4), mgp = c(1.5, .5, 0))
})

format_defaults <- if (knitr::is_latex_output()) {
  list(
    size = "\\scriptsize",
    out.width = ".8\\textwidth",
    fig.pos = "H",
    out.extra = ""
  )
} else {
  list(out.width = "80%")
}

opts_chunk$set(c(
  list(
    echo = FALSE,
    results = "markup",
    strip.white = TRUE,
    fig.path = "figs/fig",
    cache = FALSE,
    highlight = TRUE,
    width.cutoff = 132,
    fig.retina = FALSE,
    message = FALSE,
    comment = NA,
    mysize = TRUE,
    plotdefault = TRUE
  ),
  format_defaults
))
