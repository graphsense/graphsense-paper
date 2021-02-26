.PHONY: figures

all: *.tex sections/*.tex #tables/*.tex figures/*.pdf
	pdflatex main
	bibtex main
	pdflatex main
	pdflatex main
	latexmk -c main

clean:
	latexmk -C

count:
	texcount sections/*.tex

arxiv:
	tar cfvz arxiv-submission.tar.gz \
	         main.tex packages.tex macros-generic.tex main.bbl \
	         llncs.cls \
	         sections/*.tex \
	         tables/*.tex \
	         figures/* \
	         listings/*.*
