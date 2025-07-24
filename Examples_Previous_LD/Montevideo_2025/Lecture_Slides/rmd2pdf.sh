#!/bin/bash

if [ -n $1 ]; then
  Rscript -e "library(rmarkdown);render('$1.Rmd',clean=FALSE,output_format='all')"
fi
