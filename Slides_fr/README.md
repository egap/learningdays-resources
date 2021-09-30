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
for * in *.Rmd; do Rscript -e "library(rmarkdown);render('$X')"; done

```

TODO remove
library(rmarkdown)
install.packages("revealjs")
install.packages("kableExtra")

render('hypothesistesting-slides.Rmd')
render('randomization-slides.Rmd')
render('causalinference-slides.Rmd')
render('introduction-slides.Rmd')
render('egap-introduction-slides.Rmd')
render('measurement-slides.Rmd')
render('researchdesignform-slides.Rmd')
render('estimation-slides.Rmd')
render('power-slides.Rmd')
render('ethics-slides.Rmd')
render('practice-slides.Rmd')
render('threats-slides.Rmd')