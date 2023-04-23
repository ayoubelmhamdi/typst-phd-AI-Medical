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






#pagebreak

= RÉSUMÉ.
Le but du présent Projet de Fin d’Études est une étude extensive des
propriétés vibrationnelles des réseaux matériels de nature fractale et du
comportement de leur chaleur spécifique en température.
Pour l’étude, nous partons de la notion importante de fractons qui
remplacent les phonons dans les solides usuels. L’existence des fractons,
démontré expérimentalement, est intimement liée à la forte localisation
des vibrations au sein de ces structures fractales.
D’entrée de jeu, nous esquissons quantitativement les modes de
vibrations des réseaux fractals, en considérant, comme exemple, le tamis
de Sierpenski, sur lequel nous appliquons la méthode de décimation.
Mais la même technique peut s’appliquer à d’autres réseaux fractals.
Cette même technique nous permet également d’extraire la valeur de la
dimension spectrale et de déterminer la loi de dispersion associée.
La dernière partie de ce mémoire est dédiée au calcul de la chaleur
spécifique. Dans un premier temps, nous déterminons la densité d’états,
comme fonction de la fréquence de vibration. C’est une loi de puissances
où figure explicitement la dimension spectrale. Puis, nous étendons le
modèle de Debye pour calculer la chaleur spécifique, comme fonction de
la température. A basse température, c’est-à-dire en dessous d’une
température de Debye généralisée, nous démontrons que la chaleur
spécifique obéit à une loi de puissances de la température, où l’exposant
de cette loi est simplement la dimension spectrale. A haute température,
nous démontrons que la chaleur spécifique tend vers une valeur finie (loi
de Dulong et Petit généralisée). Enfin, il s’avère que la chaleur spécifique
relative aux réseaux fractals reste en dessous de celle concernant les
solides usuels. En effet, ce résultat est attendu, puisque les vibrations
dans ces réseaux fractals sont fortement localisées.

Mots-clés : Réseaux fractals, Dimension spectrale, Modes de vibrations,
Méthode de décimation, Loi de dispersion, Chaleur spécifique. ■
= NTRODUCTION GÉNÉRALE.
= RÉFÉRENCES BIBLIOGRAPHIQUES.
== Introduction.
== Définition
- test

= Chapitre I: APERÇU SUR LES SYSTÈMES FRACTALS.

== Introduction.
== Définition.
== Historique.
== Objets fractals dans la nature.
== Domaines d’application.
== Dimension fractale.
== Exemples de calculs de la dimension fractale.
== Conclusion.
= RÉFÉRENCES BIBLIOGRAPHIQUES.

= Chapitre II: PROPRIÉTÉS VIBRATIONNELLES DES FRACTALES ET CHALEUR SPÉCIFIQUE.
== Introduction.



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
// inset:20pt,
align: (col, row) => if col==0 {center} else if col==2 {left} else{right},
// gutter: 20pt,
fill: (col, row) => if calc.odd(col + row) {
silver })[A][B][C][D]
#lorem(4)
