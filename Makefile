
compile:
	typst compile main.typ

watch:
	typst watch main.typ

image:
	convert -density 300 pfe.pdf -quality 100 pfe.jpg
	convert -resize 50% pfe-0.jpg pfe.jpg
	rm pfe-0.jpg pfe-1.jpg
