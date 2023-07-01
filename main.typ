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
// = REMERCIEMENTS.
//
// Nous tenons à remercier d'abord toutes les équipes pédagogiques de *la Filière
// Science de la Matière Physique* de la Faculté des Sciences à Meknès, ainsi que les
// professeurs ayant contribué activement à notre formation.
//
// Nous profitons de cette occasion, pour remercier vivement notre Professeur
// *RAJAE SEBIHI* qui n'a pas cessé de nous encourager tout au long de
// l'exécution de notre Projet de Fin d'Études, ainsi que pour sa générosité et ses
// compétences en matière de formation et d'encadrement. Nous lui sommes
// reconnaissants pour ses aides et conseils précieux qui nous ont permis de mener à
// bien le présent projet.
//
// Nos vifs remerciements vont aussi aux membres de jury pour avoir accepté de
// juger ce travail.
//
// A la même occasion, nous voudrons également remercier chaleureusement nos
// parents qui nous ont toujours encouragés durant notre cursus de formation.
//
// Enfin, nos vifs remerciements sont adressés à toutes ces personnes qui nous
// ont apporté leur aide précieuse et leur soutien inconditionnel. #finchapiter

= TABLE DES MATIÈRES.

#outline()

// #include "chapters/resume.typ"


#counter(page).update(0)
= INTRODUCTION GÉNÉRALE.
//1== Définitions.
//1// == Contexte et importance de la détection du cancer du poumon à l'aide de l'apprentissage en profondeur.
//1== Contexte
//1== Aperçu de la structure de votre thèse.
//1== Fournir un contexte et un cadre pour votre sujet de recherche.
//1== Expliquer l'importance et la motivation de votre recherche.
//1== Objectifs et objectifs de votre recherche.
//1
//1
//1#lorem(10) #finchapiter
//1= RÉFÉRENCES BIBLIOGRAPHIQUES.

/*
 *
 * chapters
 *
 *
*/
//
#include "chapters/ch01-ana.typ"

//= RÉFÉRENCES BIBLIOGRAPHIQUES.
//
//
#include "chapters/ch02-dep.typ"
// = RÉFÉRENCES BIBLIOGRAPHIQUES.
// //
// //

// #include "chapters/ch03-mrd.typ"
// #include "chapters/ch04-art.typ"
// #include "chapters/ch05-the.typ"
// #include "chapters/ch06-men.typ"
// #include "chapters/ch07-gpt.typ"
// #include "chapters/ch08-ss.typ"

#counter(heading).step()
#counter(heading).step()
#include "chapters/ch09-wil-fr.typ"

// = RÉFÉRENCES BIBLIOGRAPHIQUES.


// #include "chapters/ch05.typ"



#bibliography("ch1.bib", title: "RÉFÉRENCES BIBLIOGRAPHIQUES.", style: "ieee") // final
