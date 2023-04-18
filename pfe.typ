#let col_class(texts,height,num) = { linebreak() +  box( height:  height,

  columns(num, gutter: 11pt)[
  #texts
])
 linebreak()
}
#let col1(texts) = col_class(texts,272pt,2)
#let col2(texts) = col_class(texts,160pt,2)

#let TheTitle(texts) = align(center, text(17pt)[
  #texts
])

/* #show par: set block(spacing: 6.65em) */
/* #set par(justify: true) */
// ---------------------------
#TheTitle([
  *SEGMENTATION DES IMAGE\
  PAR INTELEGENT ARTIFICIEL*
])

#let dots() = box(width: 1fr,repeat[.])

#set list(marker: ([#square(width:8pt, stroke:blue)], [#square(width:8pt, stroke:gray)], [--]))



- RÉSUMÉ
- INTRODUCTION GÉNÉRAL
- REVERENCE BIBLIOGRAPHIES
- Chapiter 1: APERÇU SUR AI EN MEDICINES
- Chapiter 2: STEPS TO IMPLEMENT U-NET FOR SEGMENTATION
- Chapiter 3: RÉSULTATS ET DISSCUSSION
- CONCLUSION

= Chapiter 1: APERCU SUR AI EN MEDICINES
#col1([
- Introduction
- Historique
- Définition
- Applications
- Qu'est-ce que l'intelligence artificielle ?
  - L'apprentissage automatique ?
  - Fondamentaux de l'apprentissage automatique
- Machine learning et radioprotection :
  - Le secteur médical
    - Reconnaissance de l'image médiale
    - Définition du traitement
    - Radiobiologie et épidémiologie
  - Métrologie
    - Identification des radionucléides et détection de l'événement
    - Modélisation
- La segmentation et la reconstruction 3D
  - La definition d’une segmentation d’image
  - Les methodes de segmentation existantes
  - La construction et la representation 3D
  - La segmentation des différentes structures
  - La fusion des différentes segmentations

- Les métriques d’évaluation de segmentations
  - Les métriques utilisant la matrice de confusion

- L'acquisition des données
- Intérêts et limites
- #dots()
- #dots()
- #dots()
- Conclusion
])

= Chapiter 2: STEPS TO IMPLEMENT U-NET

#col2([
- Introduction
- Steps to train a Model
  - define:
    - paths to the image and mask datasets
    - a custom dataset class
    - a block class
    - an encoder class
    - a decoder class
    - a forward function for the decoder
    - a crop function for the decoder
  - Initialize the encoder and decoder
  - Train the model on the given dataset
  - Save the trained model to disk
- #dots()
- #dots()
- #dots()
- Conclusion
])


= Discussions
