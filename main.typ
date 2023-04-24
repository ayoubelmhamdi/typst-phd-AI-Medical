#import "book.typ": book
#import "cover.typ": cover
#import "functions.typ": heading_center

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

#heading_center("REMERCIEMENTS")

Nous tenons à remercier d’abord toutes les équipes pédagogiques de la Filière
Science de la Matière Physique de la Faculté des Sciences à Meknès, ainsi que les
professeurs ayant contribué activement à notre formation.

Nous profitons de cette occasion pour remercier vivement notre Professeur
Mabrouk BENHAMOU qui n’a pas cessé de nous encourager tout au long de
l’exécution de notre Projet de Fin d’Études, ainsi que pour sa générosité et ses
compétences en matière de formation et d’encadrement. Nous lui sommes
reconnaissants pour ses aides et conseils précieux qui nous ont permis de mener à
bien le présent projet.

Nos vifs remerciements vont aussi aux membres de jury pour avoir accepté de
juger ce travail.

A la même occasion, nous voudrons également remercier chaleureusement nos
parents qui nous ont toujours encouragés durant notre cursus de formation.

Enfin, nos vifs remerciements sont adressés à toutes ces personnes qui nous
ont apporté leur aide précieuse et leur soutien inconditionnel. ■
#pagebreak(weak:true)

#heading_center("TABLE DES MATIÈRES")
#outline(
  title: none,
  depth:3,
  fill: none,
)

#pagebreak(weak:true)

= RÉSUMÉ.

Le but du présent Projet de Fin d’Études est une étude extensive des
propriétés vibrationnelles des réseaux matériels de nature fractale et du
comportement de leurtals, Dimension spectrale, Modes de vibrations,
Méthode de décimation, Loi de dispersion, Chaleur spécifique. ■

= INTRODUCTION GÉNÉRALE.

= RÉFÉRENCES BIBLIOGRAPHIQUES.

= APERÇU SUR LES SYSTÈMES FRACTALS.

== Introduction.
=== Définition.
== Historique.
== Conclusion.

= PROPRIÉTÉS VIBRATIONNELLES DES FRACTALES ET CHALEUR SPÉCIFIQUE.
== Introduction
== conclusion

= RÉFÉRENCES BIBLIOGRAPHIQUES.
= CONCLUSION



#lorem(2)


#table(columns: (1fr,2fr,1fr,auto),
// inset:20pt,
align: (col, row) => if col==0 {center} else if col==2 {left} else{right},
// gutter: 20pt,
fill: (col, row) => if calc.odd(col + row) {
silver })[A][B][C][D]
#lorem(4)
#lorem(2)


#table(columns: (1fr,2fr,1fr,auto),
align: (row,col) => if row==0 {center} else if row==2 {left} else{right},
fill: (col, row) => if calc.odd(col + row) {
silver })[A][B][C][D]
#lorem(4)
