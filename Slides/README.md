This is a directory for slide presentations.

To install all of the packages needed by the slides you'll need to do the following when you first clone the repository:

```
install.packages("renv")
renv::init()
```

Then to build all slides, for now, do:

```
make all
```

Or if you want to force rebuild them, and do not want to do, `make -f all` you can try:

```
for * in *.Rmd; do Rscript -e "library(rmarkdown);render('$X')"; done

```
