SHELL = /bin/sh

all: allpdf allhtml

allpdf: causalinference-slides.pdf \
	egap-introduction-slides.pdf \
	estimation-slides.pdf \
	hypothesistesting-slides.pdf \
	introduction-slides.pdf \
	power-slides.pdf \
	randomization-slides.pdf \
	researchdesignform-slides.pdf \
	threats-slides.pdf \
	ethics-slides.pdf \
	measurement-slides.pdf \
	practice-slides.pdf

allhtml: causalinference-slides.html \
	egap-introduction-slides.html \
	estimation-slides.html \
	hypothesistesting-slides.html \
	introduction-slides.html \
	power-slides.html \
	randomization-slides.html \
	researchdesignform-slides.html \
	threats-slides.html \
	ethics-slides.html \
	measurement-slides.html \
	practice-slides.html


causalinference-slides.pdf: causalinference-slides.Rmd
	Rscript -e "library(rmarkdown); render('causalinference-slides.Rmd')"

egap-introduction-slides.pdf: egap-introduction-slides.Rmd
	Rscript -e "library(rmarkdown); render('egap-introduction-slides.Rmd')"

estimation-slides.pdf: estimation-slides.Rmd
	Rscript -e "library(rmarkdown); render('estimation-slides.Rmd')"

hypothesistesting-slides.pdf: hypothesistesting-slides.Rmd
	Rscript -e "library(rmarkdown); render('hypothesistesting-slides.Rmd')"

introduction-slides.pdf: introduction-slides.Rmd
	Rscript -e "library(rmarkdown); render('introduction-slides.Rmd')"

power-slides.pdf: power-slides.Rmd
	Rscript -e "library(rmarkdown); render('power-slides.Rmd')"

randomization-slides.pdf: randomization-slides.Rmd
	Rscript -e "library(rmarkdown); render('randomization-slides.Rmd')"

researchdesignform-slides.pdf: researchdesignform-slides.Rmd
	Rscript -e "library(rmarkdown); render('researchdesignform-slides.Rmd')"

threats-slides.pdf: threats-slides.Rmd
	Rscript -e "library(rmarkdown); render('threats-slides.Rmd')"

ethics-slides.pdf: ethics-slides.Rmd
	Rscript -e "library(rmarkdown); render('ethics-slides.Rmd')"

measurement-slides.pdf: measurement-slides.Rmd
	Rscript -e "library(rmarkdown); render('measurement-slides.Rmd')"

practice-slides.pdf: practice-slides.Rmd
	Rscript -e "library(rmarkdown); render('practice-slides.Rmd')"

### HTML Versions
causalinference-slides.html: causalinference-slides.Rmd
	Rscript -e "library(rmarkdown); render('causalinference-slides.Rmd',output_format='all')"

egap-introduction-slides.html: egap-introduction-slides.Rmd
	Rscript -e "library(rmarkdown); render('egap-introduction-slides.Rmd',output_format='all')"

estimation-slides.html: estimation-slides.Rmd
	Rscript -e "library(rmarkdown); render('estimation-slides.Rmd',output_format='all')"

hypothesistesting-slides.html: hypothesistesting-slides.Rmd
	Rscript -e "library(rmarkdown); render('hypothesistesting-slides.Rmd',output_format='all')"

introduction-slides.html: introduction-slides.Rmd
	Rscript -e "library(rmarkdown); render('introduction-slides.Rmd',output_format='all')"

power-slides.html: power-slides.Rmd
	Rscript -e "library(rmarkdown); render('power-slides.Rmd',output_format='all')"

randomization-slides.html: randomization-slides.Rmd
	Rscript -e "library(rmarkdown); render('randomization-slides.Rmd',output_format='all')"

researchdesignform-slides.html: researchdesignform-slides.Rmd
	Rscript -e "library(rmarkdown); render('researchdesignform-slides.Rmd',output_format='all')"

threats-slides.html: threats-slides.Rmd
	Rscript -e "library(rmarkdown); render('threats-slides.Rmd',output_format='all')"

ethics-slides.html: ethics-slides.Rmd
	Rscript -e "library(rmarkdown); render('ethics-slides.Rmd',output_format='all')"

measurement-slides.html: measurement-slides.Rmd
	Rscript -e "library(rmarkdown); render('measurement-slides.Rmd',output_format='all')"

practice-slides.html: practice-slides.Rmd
	Rscript -e "library(rmarkdown); render('practice-slides.Rmd',output_format='all')"
