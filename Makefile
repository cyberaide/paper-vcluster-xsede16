FILE=virtual-clusters

all:
	pdflatex --shell-escape ${FILE}
	bibtex ${FILE}
	pdflatex ${FILE}
	pdflatex ${FILE}

real-clean: clean
	rm -rf *.pdf

clean:
	rm -rf *~ *.aux *.bbl *.dvi *.log *.out *.blg *.toc *.fdb_latexmk *.fls *.bcf
view:
	open ${FILE}.pdf

# all dependce taracking taking care of by Latexmk
fast:
	latexmk -pdf ${FILE}

watch:
	latexmk -shell-escape -pvc -view=pdf ${FILE}

.PHONY: all clean view fast watch

pull:
	git pull

up:
	git commit -a
	git push

e:
	e ${FILE}.tex

publish:
	cp ${FILE}.pdf ${FILE}-draft.pdf
	git commit -m "new draft" ${FILE}-draft.pdf
	git push

#	@echo "==============================================================="
#	@echo "publish ${FILE}.pdf -> http://cyberaide.github.io/papers/${FILE}.pdf" 
#	@echo "==============================================================="
#	cp ${FILE}.pdf /tmp
#	cd ..; git checkout gh-pages
#	cp /tmp/${FILE}.pdf .
#	git add ${FILE}.pdf
#	git commit -m "adding new version of ${FILE}.pdf" ${FILE}.pdf
#	git push
#	cd bigdata
#	git checkout master
