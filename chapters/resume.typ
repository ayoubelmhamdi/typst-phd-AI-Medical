#import "../functions.typ": heading_center, images, italic

#let finchapiter = text(fill:rgb("#1E045B"),[■])

= RÉSUMÉ.
Les images médicales jouent un rôle important dans le diagnostic et la prise en charge des cancers. Les oncologues analysent des images pour déterminer les différentes caractéristiques de la tumeur, pour proposer un traitement adapté et suivre l'évolution de la maladie.

L'objectif de ce rapport est d'évaluer la détection automatique des nodules pulmonaire cancéreuse dans le contexte de la radiothérapie, à partir des images de CT scan.

Nous utilisons les nodules candidats qui sont segmentés par un réseau neuronal convolutif entraîné sur des images de scanner segmentées par des experts. Notant que celles-ci sont faiblement annotées, et sont souvent disponibles en quantités très limitées du fait de leur coût.

Nous créons un modèle basé sur un CNN (Convolutional Neural Network) pour diagnostiquer ces nodules. et les expériences réalisées sur des scanners pulmonaires de haute qualité ont démontré une détection assez bonne des nodules cancéreux du poumon.


*Mots clés*: Réseau neuronal convolutif, CNN, apprentissage profond, CT scan, TDM, radiothérapie, Caner, Nodules pulmonaire.#finchapiter
