

topdown.pdf: topdown.dvi
	dvipdf $<

%.dvi: %.tex
	latex $<
