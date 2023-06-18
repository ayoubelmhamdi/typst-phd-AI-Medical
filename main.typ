#import "template.typ": book
#import "cover.typ": cover
#import "functions.typ": heading_center, images, italic

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

#let book_info = (
  title: "UTILISATION DU DEEP LEARNING POUR IDENTIFIER LES NODULES PULMONAIRES
  CANCÉREUX SUR LES IMAGES DE TDM",
  // title: "DÉTECTION DES NODULES PULMONAIRES CANCÉREUX PAR DES RÉSEAUX DE
  // NEURONES PROFONDS À PARTIR D'IMAGES DE TOMODENSITOMÉTRIE.",
  // title: "VISION PAR ORDINATEUR POUR LE DÉPISTAGE DES NODULES PULMONAIRES
  // CANCÉREUX À L'AIDE D'IMAGES DE TOMODENSITOMÉTRIE.",
  // title: "DÉPISTAGE AUTOMATISÉ DES NODULES PULMONAIRES CANCÉREUX PAR ANALYSE
  // D'IMAGES DE TOMODENSITOMÉTRIE.",
  // title: "SEGMENTATION DES IMAGE MEDICAL PAR INTELLIGENT ARTIFICIAL",
  authors: (
    "Ayoub EL MHAMDI",
    "youssef MADANE",
  ),
  encaders: (
    // "Pr BENHAMOU Mabrouk",
    // "Examinateur",
    // "Pr HACHEM El-Kaber",
    // "Examinateur",
    "Pr RAJAE Sebihi",
    "Encadrant",
  )
)

#show: doc => book(
  book_info,
  doc
)

#cover(book_info)
= REMERCIEMENTS.

Nous tenons à remercier d'abord toutes les équipes pédagogiques de *la Filière
Science de la Matière Physique* de la Faculté des Sciences à Meknès, ainsi que les
professeurs ayant contribué activement à notre formation.

Nous profitons de cette occasion, pour remercier vivement notre Professeur
*RAJAE SEBIHI* qui n'a pas cessé de nous encourager tout au long de
l'exécution de notre Projet de Fin d'Études, ainsi que pour sa générosité et ses
compétences en matière de formation et d'encadrement. Nous lui sommes
reconnaissants pour ses aides et conseils précieux qui nous ont permis de mener à
bien le présent projet.

Nos vifs remerciements vont aussi aux membres de jury pour avoir accepté de
juger ce travail.

A la même occasion, nous voudrons également remercier chaleureusement nos
parents qui nous ont toujours encouragés durant notre cursus de formation.

Enfin, nos vifs remerciements sont adressés à toutes ces personnes qui nous
ont apporté leur aide précieuse et leur soutien inconditionnel. #finchapiter

= TABLE DES MATIÈRES.

#outline()

= RÉSUMÉ.
#lorem(10) #finchapiter


= INTRODUCTION GÉNÉRALE.
#lorem(10) #finchapiter
= RÉFÉRENCES BIBLIOGRAPHIQUES.

#include "chapters/ch01.typ"
= RÉFÉRENCES BIBLIOGRAPHIQUES.


#include "chapters/ch02.typ"
= RÉFÉRENCES BIBLIOGRAPHIQUES.


#include "chapters/ch03.typ"
= RÉFÉRENCES BIBLIOGRAPHIQUES.

// #include "chapters/ch04.typ"

= FIN

= CONCLUSION GÉNÉRALE.

// #include "chapters/ch05.typ"



#bibliography("ch1.bib", title: "RÉFÉRENCES BIBLIOGRAPHIQUES.", style: "ieee") // final
