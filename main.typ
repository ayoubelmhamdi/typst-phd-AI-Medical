#import "book.typ": book
#import "cover.typ": cover

#let book_info = (
  // title: "SEGMENTATION DES IMAGE MEDICAL PAR IA",
  title: "ÉTUDE ÉTENDUE DES PROPRIÉTÉS
          VIBRATIONNELLES DES MATÉRIAUX
          FRACTALS – CHALEUR SPÉCIFIQUE",
  authors: (
    "Ayoub EL MHAMDI",
    "Abdellah ETTARCHOUCH",
    "Radya OURAS",
  ),
  encaders: (
    "Pr BENHAMOU Mabrouk",
    "Examinateur",
    "Pr HACHEM El-Kaber",
    "Examinateur",
    "Pr RAJAE Sebihi",
    "Encadrant",
  )
  // url: "https://github.com/ayoubelmhamdi/typst-test"
)
#show: book.with(book_info)
#cover(book_info)
#pagebreak(weak:true)
#outline()
#pagebreak(weak:true)


#v(2em)

#lorem(2)


#table(columns: (1fr,2fr,1fr,auto),
// inset:20pt,
align: (col, row) => if col==0 {center} else if col==2 {left} else{right},
// gutter: 20pt,
fill: (col, row) => if calc.odd(col + row) {
silver })[A][B][C][D]
#lorem(4)




== test
#lorem(21)

#pagebreak
=== test
- test
#lorem(21)
- dd
  - dd
  - dd
- dd
