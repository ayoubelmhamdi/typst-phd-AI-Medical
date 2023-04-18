
compile:
	typst compile pfe.typ

watch:
	typst watch pfe.typ

image:
	convert -density 300 pfe.pdf -quality 100 pfe.jpg
	convert -resize 50% pfe-0.jpg pfe.jpg
	rm pfe-0.jpg pfe-1.jpg
