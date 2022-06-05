This is a directory for slide presentations.

To install all of the packages needed by the slides you'll need to type the following at the Unix/Mac command line when you first clone the repository:

```
install.packages("renv")
renv::init()
renv::restore()
```

Then to build all slides, for now, type the following:

```
make all
```

To force rebuild them in case the make system thinks they do not need to be rebuilt type `make --always-make all`

Or if you want to force rebuild them, and do not want to use the Makefile system you can try using the following bash shell script:

```
for * in *.Rmd; do Rscript -e "library(rmarkdown);render('$X')"; done

```
