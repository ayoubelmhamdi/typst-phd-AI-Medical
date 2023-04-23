
compile:
	typst  --font-path ~/home/.fonts compile main.typ
watch:
	typst --font-path ~/home/.fonts watch main.typ
test:
	typst --font-path ~/home/.fonts watch test.typ

image:
	convert -density 300 pfe.pdf -quality 100 pfe.jpg
	convert -resize 50% pfe-0.jpg pfe.jpg
	rm pfe-0.jpg pfe-1.jpg
