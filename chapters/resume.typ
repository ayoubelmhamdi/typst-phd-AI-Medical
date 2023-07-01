#import "../functions.typ": heading_center, images, italic

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

= RÉSUMÉ.
// - difficulté de analyse pour expert.
//
// Les images médicales jouent un rôle important dans le diagnostic et la prise en charge des cancers. Les oncologues analysent des images pour déterminer les différentes caractéristiques de la tumeur, pour proposer un traitement adapté et suivre l'évolution de la maladie.
//
// L'objectif de ce rapport est de proposer un méthode de détection automatique des nodules pulmonaire cancéreuse dans le contexte de la radiothérapie, à partir des images de CT scan.
//
// Premièrement, nous nous intéressons à la segmentation des nodules en utilisant des réseaux neuronaux convolutifs entraînés sur des CT images segmentés par des experts. Ceux-ci sont faiblement annotées, et sont souvent disponibles en quantités très limitées du fait de leur coût.
//
// Notre méthode repose sur une version modifiée du réseau de neurones convolutif UNet.
//
// Finalement, diagnostic ...
//
// Les expériences réalisées sur des TDM pulmonaires de haute qualité ont démontré l'efficacité de l'approche proposée pour la segmentation des nodules cancéreuse de  pulmonaire de haut grade,(...detection...).
//
//
// *Mots clés*: Réseau neuronal convolutif, apprentissage profond, CT scan, TDM, radiothérapie, Caner, Nodules pulmonaire, (...).#finchapiter
