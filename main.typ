#import "template.typ": book
#import "cover.typ": cover
#import "functions.typ": heading_center, images, italic

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

#let book_info = (
  title: "DETECTION ET CLASSIFICATION DES NODULES PULMONAIRES À L’AIDE DU DEEP LEARNING",
  // title: "DÉTECTION DES NODULES PULMONAIRES CANCÉREUX SUR LES IMAGES DE TDM",
  // title: "DÉTECTION DES NODULES PULMONAIRES CANCÉREUX PAR DES RÉSEAUX DE
  // NEURONES PROFONDS À PARTIR D'IMAGES DE TOMODENSITOMÉTRIE.",
  // title: "VISION PAR ORDINATEUR POUR LE DÉPISTAGE DES NODULES PULMONAIRES
  // CANCÉREUX À L'AIDE D'IMAGES DE TOMODENSITOMÉTRIE.",
  // title: "DÉPISTAGE AUTOMATISÉ DES NODULES PULMONAIRES CANCÉREUX PAR ANALYSE
  // D'IMAGES DE TOMODENSITOMÉTRIE.",
  // title: "SEGMENTATION DES IMAGE MEDICAL PAR INTELLIGENT ARTIFICIAL",
  authors: (
    "Ayoub EL MHAMDI",
    "Youssef MADANE",
  ),
  encaders: (
    // "Pr BENHAMOU Mabrouk",
    // "Examinateur",
    "Pr. MOHAMED Khalis",   "Examinateur",  "FS Meknes",
    "Pr. Zouhir El Amraoui","Examinateur",  "FS Meknes",
    "Pr. RAJAE Sebihi",     "Encadrant",    "FS Rabat",
    "Pr. MORAD EL Kafhali", "Co-Encadrant", "",
    ""
    // box(width: 200pt,repeat[.]),
    // box(width: 1fr,repeat[.]),
    // box(width: 200pt,repeat[.]),
    // box(width: 1fr,repeat[.]),
  )
)

#show: doc => book(
  book_info,
  doc
)

#counter(page).update(0)
#cover(book_info)
#include "chapters/ch00-rem.typ"

= TABLE DES MATIÈRES.

#outline()
#counter(page).update(0)
#include "chapters/resume.typ"

#include "chapters/ch00-int.typ"
#include "chapters/ch01-ana.typ"
#include "chapters/ch02-dep.typ"
// #include "chapters/ch03-mrd.typ"
// #include "chapters/ch04-art.typ"
// #include "chapters/ch05-the.typ"
// #include "chapters/ch06-men.typ"
// #include "chapters/ch07-gpt.typ"
// #include "chapters/ch08-ss.typ"

// #counter(heading).step()
// #counter(heading).step()
#include "chapters/ch21.typ"
#include "chapters/annexe.typ"
// #include "PPT/main.typ"

// = RÉFÉRENCES BIBLIOGRAPHIQUES.


// #include "chapters/ch05.typ"



#bibliography("ch1.bib", title: "RÉFÉRENCES BIBLIOGRAPHIQUES.", style: "ieee")
#finchapiter
