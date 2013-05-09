

robin-houston-phd-thesis.pdf: robin-houston-phd-thesis.dvi
	dvipdf $<

%.dvi: %.tex
	latexmk $<

.PHONY: clean
clean:
	rm -f robin-houston-phd-thesis.dvi robin-houston-phd-thesis.pdf robin-houston-phd-thesis.fdb_latexmk robin-houston-phd-thesis.fls robin-houston-phd-thesis.fdb_latexmk.blg *.aux *.out *.log
