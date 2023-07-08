typst=typst6 -v

# all: compile
.PHONY: build
all: build/main.pdf

DEPS != find . -type f -iname "*.typ"

watch:
	$(typst) --font-path ~/home/.fonts watch main.typ build/main.pdf

compile:
	@clear && time $(typst)  --font-path ~/home/.fonts compile main.typ build/main.pdf

test:
	$(typst) --font-path ~/home/.fonts watch test.typ build/main.pdf


build/main.pdf: main.typ $(DEPS)
	clear
	$(typst) compile $<  build/main.pdf
	@echo "Finished"

image:
	convert -density 300 build/main.pdf -quality 100 pfe.jpg
	convert -resize 50% pfe-0.jpg pfe.jpg
	mv pfe-0.jpg main.jpg
	rm pfe-*.jpg

clean:
	@rm -f *.pdf chapters/*.pdf main.pdf build/main.pdf
	@rm -f images/rem-*
