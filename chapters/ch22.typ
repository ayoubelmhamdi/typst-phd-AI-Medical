#import "../functions.typ": heading_center, images, italic,linkb, dots
#import "../tablex.typ": tablex, cellx, rowspanx, colspanx, hlinex

#let finchapiter = text(fill:rgb("#1E045B"),"■")

// #linebreak()
// #linebreak()
// #counter("tabl").update(n=>n+20)

= DÉTECTION DES NODULES PULMONAIRES DU CANCER.

== Introduction

Les nodules pulmonaires sont des lésions arrondies ou ovales qui se forment dans le poumon. Ils peuvent être bénins ou malins, et leur détection précoce est cruciale pour le diagnostic et le traitement du cancer du poumon. Selon l'Organisation mondiale de la santé, le cancer du poumon est la première cause de décès par cancer dans le monde, avec environ 2,2 millions de nouveaux cas et 1,8 million de décès en 2020.

L'imagerie par scanner est la méthode la plus courante pour détecter et caractériser les nodules pulmonaires. Cependant, il existe une grande variabilité dans l'interprétation des images et la prise en charge des nodules. Pour harmoniser les pratiques cliniques et réduire les examens inutiles ou invasifs, il existe des directives basées sur la taille, la forme, l'évolution et le risque de malignité des nodules.

Dans cet étude, nous proposons d'utiliser le deep learning pour améliorer la prise en charge des nodules pulmonaires. Le deep learning est une technique d'intelligence artificielle qui permet d'apprendre à partir de grandes quantités de données et de réaliser des tâches complexes comme la classification ou la segmentation d'images. Nous utilisons le dataset LIDC-IDRI, qui contient 1018 scanners thoraciques annotés par quatre radiologues experts. Chaque nodule pulmonaire est décrit par un fichier XML qui contient son identifiant, ses caractéristiques et sa région d'intérêt. Par exemple, voici le fichier XML correspondant au nodule numéro 4 :


#pagebreak()

```xml
<unblindedReadNodule>
    <noduleID>4</noduleID>
    <characteristics>
        <subtlety>4</subtlety>
        <internalStructure>1</internalStructure>
        <calcification>6</calcification>
        <sphericity>4</sphericity>
        <margin>4</margin>
        <lobulation>1</lobulation>
        <spiculation>2</spiculation>
        <texture>5</texture>
        <malignancy>3</malignancy>
    </characteristics>
    <roi>
        <imageZposition>1487.5</imageZposition>
        <imageSOP_UID>1.3.6.1.4.1.14519.5.2.1.6279.6001.270602739536521934855332163694</imageSOP_UID>
        <inclusion>TRUE</inclusion>
        <edgeMap><xCoord>322</xCoord><yCoord>303</yCoord></edgeMap>
        <edgeMap><xCoord>322</xCoord><yCoord>304</yCoord></edgeMap>
        <edgeMap><xCoord>322</xCoord><yCoord>305</yCoord></edgeMap>
        <edgeMap><xCoord>323</xCoord><yCoord>303</yCoord></edgeMap>
        <edgeMap><xCoord>322</xCoord><yCoord>303</yCoord></edgeMap>
    </roi>
</unblindedReadNodule>
```

Ce fichier XML contient des informations importantes sur le nodule, telles que sa taille, sa forme, sa structure, sa calcification, sa texture et son risque de malignité. Il contient également la position et le contour du nodule sur l’image.

Nous commençons par développer un modèle de classification qui peut identifier le type de nodulaire à partir des images CT scan. Nous avons utilisé le dataset LUNA16, qui est un sous-ensemble du dataset LIDC-IDRI, pour entraîner et évaluer notre modèle de classification. Nous avons comparé les performances de notre modèle de classification avec celles des radiologues et des directives existantes.

Ensuite, nous créons un nouveau dataset appelé *TRPMLN*, qui extrait les nodules qui ont une moyenne de malignité égale à 3 ou plus dans les annotations des quatre experts. Nous avons inclus une annexe qui présente l'implémentation du code pour créer cet ensemble de données. Nous développons un autre modèle de classification qui peut classer les nodules en fonction de leur malignité à partir des images CT scan. Nous comparons les performances de notre modèle avec celles des radiologues et des directives existantes.

Le plan de l'étude est le suivant : dans la section Méthode, nous présentons le dataset LIDC-IDRI, le dataset LUNA16, le dataset TRPMLN, les modèles de deep learning et les critères d'évaluation. Dans la section Résultats, nous montrons les résultats obtenus par nos modèles sur les datasets LUNA16 et TRPMLN. Dans la section Discussion, nous analysons les forces et les limites de notre approche, ainsi que les implications cliniques. Dans la section Conclusion, nous résumons nos contributions et proposons des perspectives futures. #finchapiter


== Méthode

Notre étude comprenait trois étapes principales : le prétraitement des données, le développement des algorithmes de classification des nodules et l'évaluation des performances.

=== Ressources

Les ressources de notre étude étaient des scans CT et des annotations provenant du dataset LIDC-IDRI, du dataset LUNA16 et TRPMLN. Le dataset LIDC-IDRI est une base de données publique qui contient 1018 scans thoraciques annotés par quatre radiologues experts. Chaque nodule pulmonaire est décrit par un fichier XML qui contient son identifiant, ses caractéristiques et sa région d'intérêt.

- LUNA16:
Le dataset LUNA16 est un sous-ensemble du dataset LIDC-IDRI, qui contient 1186 nodules annotés dans 888 scans thoraciques. Ce dataset fournit également deux fichiers CSV distincts contenant les détails des candidats et des annotations. Dans le fichier candidates.csv, quatre colonnes sont illustrées : seriesuid, coordX, coordY, coordZ, et classe. Ici, le seriesuid fonctionne comme un identifiant unique pour chaque scan ; coordX, coordY, et coordZ représentent les coordonnées spatiales pour chaque candidat en millimètres, et 'classe' fournit une catégorisation binaire, dépeignant si le candidat est un nodule (1) ou non (0).

#figure(
  tablex(
    columns: 5,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [*seriesuid*], [*coordX*], [*coordY*], [*coordZ*], [*class*],
    [1.3.6...666836860], [68.42], [-74.48], [-288.7], [0],
    hlinex(stroke: 0.25pt),
    [1.3.6...666836860], [68.42], [-74.48], [-288.7], [0],
    hlinex(stroke: 0.25pt),
    [1.3.6...666836860], [-95.20936148], [-91.80940617], [-377.4263503], [0],
  ),
  caption: [Coordonnées des candidats détectés dans le dataset Luna16 avec diamètres],
  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],

)

Le fichier annotations.csv est composé de cinq colonnes : seriesuid, coordX, coordY, coordZ, et diamètre_mm, commandant l'identifiant unique du scanner, les coordonnées d'annotation spatiales en millimètres, et le diamètre de chaque annotation en millimètres, respectivement. Ces annotations ont été marquées manuellement en se basant sur l'identification des nodules de plus de 3 mm de diamètre par quatre radiologistes indépendants.

#figure(
  tablex(
    columns: 5,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [*seriesuid*], [*coordX*], [*coordY*], [*coordZ*], [*diameter_mm*],

    [1.3.6.1....6860], [-128.6994211], [-175.3192718], [-298.3875064], [5.65147063],
    hlinex(stroke: 0.25pt),
    [1.3.6.1....6860], [103.7836509], [-211.9251487], [-227.12125], [4.224708481],
    hlinex(stroke: 0.25pt),
    [1.3.6.1....5208], [69.63901724], [-140.9445859], [876.3744957], [5.786347814],
  ),
  caption: [Annotations des nodules détectés dans le dataset Luna16],

  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],

)

=== Scans CT avec Nodules Pulmonaires

Pour lire, traiter et représenter visuellement les scans CT montrant des nodules pulmonaires  , nous avons mis en œuvre deux bibliothèques Python : SimpleITK et matplotlib. SimpleITK offre un point d'accès simplifié à l'Insight Segmentation and Registration Toolkit (ITK), un cadre construit pour l'analyse et le traitement d'images. Matplotlib, en revanche, offre des fonctionnalités pour la visualisation et l'amélioration des images.

Avec SimpleITK, nous avons lu les fichiers de scan CT du dataset LUNA16, convertissant ces images de leur format DICOM ou NIfTI en tableaux numériques multidimensionnels manipulables, appelés tableaux numpy. De plus, SimpleITK a été utilisé pour obtenir l'origine et l'espacement des images, qui sont des informations nécessaires pour convertir les coordonnées des annotations en indices de tableau numpy. Avec matplotlib, nous avons affiché les images CT avec les annotations superposées, en utilisant des cercles rouges pour indiquer les nodules.

=== Prétraitement des Données

Avant d'entraîner nos modèles de deep learning, nous avons effectué quelques étapes de prétraitement sur les données. Tout d'abord, nous avons normalisé les valeurs de pixels des images CT en utilisant la formule suivante :

$$
x_{norm} = \frac{x - \mu}{\sigma}
$$

où $x$ est la valeur originale du pixel, $\mu$ est la moyenne globale des pixels, et $\sigma$ est l'écart-type global des pixels. Cette normalisation permet de réduire l'échelle des valeurs et de faciliter l'apprentissage des modèles.

Ensuite, nous avons appliqué une segmentation du poumon sur les images CT, afin d'éliminer le bruit et les structures non pertinentes. Nous avons utilisé un algorithme basé sur le seuillage et la croissance de région, qui consiste à sélectionner un seuil initial pour séparer le poumon du fond, puis à étendre progressivement la région du poumon en fonction de la similarité des pixels voisins. Nous avons ensuite extrait la région du poumon comme une nouvelle image et rempli les trous éventuels avec une opération de fermeture morphologique.

Enfin, nous avons extrait des patchs 3D autour des nodules annotés et des candidats non nodulaires. Nous avons utilisé une taille de patch de 64 x 64 x 64 pixels, ce qui correspond à environ 40 x 40 x 40 mm dans l'espace réel. Nous avons centré le patch sur la coordonnée du nodule ou du candidat, et nous avons rempli les bords avec des zéros si le patch dépassait les limites de l'image. Nous avons obtenu un total de 1186 patchs nodulaires et 551065 patchs non nodulaires.

=== Modèles de Deep Learning

Nous avons développé deux modèles de deep learning pour classer les nodules pulmonaires à partir des patchs 3D extraits. Le premier modèle vise à distinguer les nodules des lésions non nodulaires, tandis que le second modèle vise à classer les nodules selon leur malignité.

=== Modèle de Classification Binaire

Le modèle de classification binaire est un réseau neuronal convolutif 3D (CNN) qui prend en entrée un patch 3D et produit en sortie une probabilité d'être un nodule. Le modèle est composé de cinq couches convolutives avec des filtres 3 x 3 x 3 et des fonctions d'activation ReLU, suivies chacune d'une couche de normalisation par lots et d'une couche de max-pooling avec un facteur 2. La dernière couche convolutive est suivie d'une couche entièrement connectée avec 512 neurones et une fonction d'activation ReLU, puis d'une couche de dropout avec un taux de 0.5. La couche finale est une couche entièrement connectée avec un neurone et une fonction d'activation sigmoïde, qui produit la probabilité d'être un nodule.

Nous avons entraîné le modèle sur le dataset LUNA16, en utilisant une fraction de validation de 0.2 et une fraction de test de 0.1. Nous avons utilisé la fonction de perte d'entropie croisée binaire comme critère d'optimisation, et l'algorithme Adam comme optimiseur. Nous avons utilisé un taux d'apprentissage initial de 0.001, que nous avons réduit par un facteur 0.1 si la perte de validation ne diminuait pas pendant 10 époques consécutives. Nous avons arrêté l
