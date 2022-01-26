This is a directory for slide presentations.

To install all of the packages needed by the slides you'll need to do the following when you first clone the repository:

```
install.packages("renv")
renv::init()
renv::restor()
```

Then to build all slides, for now, do:

```
make all
```

Or if you want to force rebuild them, and do not want to do, `make -f all` you can try:

```
for * in *.Rmd; do Rscript -e "library(rmarkdown);rmarkdown::render('$X')"; done

```

TODO remove
library(rmarkdown)
install.packages("revealjs")
install.packages("kableExtra")

rmarkdown::render('hypothesistesting-slides.Rmd', output_format="pdf_document")
rmarkdown::render('hypothesistesting-slides.Rmd',output_format='all')
rmarkdown::render('randomization-slides.Rmd',output_format='all')
rmarkdown::render('causalinference-slides.Rmd',output_format='all')
rmarkdown::render('introduction-slides.Rmd',output_format='all')
rmarkdown::render('egap-introduction-slides.Rmd',output_format='all')
rmarkdown::render('measurement-slides.Rmd',output_format='all')
rmarkdown::render('researchdesignform-slides.Rmd',output_format='all')
rmarkdown::render('estimation-slides.Rmd',output_format='all')
rmarkdown::render('power-slides.Rmd',output_format='all')
rmarkdown::render('ethics-slides.Rmd',output_format='all')
rmarkdown::render('practice-slides.Rmd',output_format='all')
rmarkdown::render('threats-slides.Rmd',output_format='all')
