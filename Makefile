typst=typst5

compile:
	$(typst)  --font-path ~/home/.fonts compile main.typ build/main.pdf
watch:
	$(typst) --font-path ~/home/.fonts watch main.typ build/main.pdf
test:
	$(typst) --font-path ~/home/.fonts watch test.typ build/main.pdf

image:
	convert -density 300 build/main.pdf -quality 100 pfe.jpg
	convert -resize 50% pfe-0.jpg pfe.jpg
	mv pfe-0.jpg main.jpg
	rm pfe-*.jpg

clean:
	rm *.pdf
