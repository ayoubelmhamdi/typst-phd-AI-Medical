#import "../functions.typ": heading_center, images, italic,linkb, dots
#import "../tablex.typ": tablex, cellx, rowspanx, colspanx, hlinex

#let finchapiter = text(fill:rgb("#1E045B"),"■")

// #linebreak()
// #linebreak()
// #counter("tabl").update(n=>n+20)

= DÉTECTION DES NODULES PULMONAIRES DU CANCER.

== Introduction

Le cancer du poumon figure parmi les principales causes de mortalité liées au cancer dans le monde entier #cite("national2011reduced"). La reconnaissance et le diagnostic précoces des nodules pulmonaires, petites masses de tissu dans les poumons, peuvent considérablement augmenter les taux de survie et le succès du traitement pour les individus atteints de cancer du poumon. Cependant, la détection et la classification de ces nodules pulmonaires représentent un défi de taille en raison de leur taille, forme, emplacement et caractéristiques physiques variables #cite("SetioTBBBC0DFGG16"). De plus, la majorité des nodules pulmonaires sont bénins ou non cancéreux, avec seulement un faible pourcentage classé comme malin ou cancéreux #cite("dou2017automated"). Ces conditions créent des complications pour la détection et la classification automatisées des nodules pulmonaires par des modèles d'apprentissage automatique.


Un des défis majeurs dans le dépistage du cancer du poumon est de distinguer les nodules pulmonaires _bénins_ et _malins_ à partir des images de scanner. Les systèmes de détection assistée par ordinateur (CAO) peuvent aider les radiologues à identifier et à caractériser les nodules en fonction de leur taille, leur forme, leur évolution et leur _*risque de malignité*_#cite("Shen2015","Nasrullah2019"). Ces systèmes utilisent des techniques d'intelligence artificielle, notamment des réseaux de neurones profonds, pour analyser les images et fournir une classification automatique des nodules. Cette approche peut réduire le temps de lecture, augmenter le taux de détection, harmoniser les pratiques cliniques et éviter des examens inutiles ou invasifs.

Dans cet étude, nous proposons d'utiliser le deep learning pour améliorer la prise en charge des nodules pulmonaires. Le deep learning permet d'apprendre à partir de grandes quantités de données et de réaliser des tâches complexes comme la classification ou la segmentation d'images. Nous utilisons le dataset *LIDC-IDRI*#footnote("sous licence «Creative Commons Attribution 3.0 Unported License».")@Clark2013, qui contient $1018$ scanners thoraciques annotés par *quatre radiologues experts*. Chaque nodule pulmonaire est décrit par un fichier _XML_ qui contient son _identifiant_, ses _caractéristiques_ et sa _région d'intérêt_. Par exemple, voici le fichier XML correspondant au nodule numéro 4 :


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

Ce fichier _XML_ contient des informations importantes sur le nodule, telles que sa _taille_, sa _forme_, sa _structure_, sa _calcification_, sa _texture_ et son _*risque de malignité*_. Il contient également la _position_ et le _contour_ du nodule sur l’image.

Nous commençons par développer un modèle de classification qui peut identifier le *type* de nodulaire à partir des images CT scan(nodule ou lésion). Nous avons utilisé le dataset *LUNA16*#footnote("sous licence «Creative Commons Attribution 4.0 International License».") #cite("SetioTBBBC0DFGG16"), qui est un sous-ensemble du dataset _LIDC-IDRI_, pour entraîner et évaluer notre modèle de classification. Nous avons comparé les performances de notre modèle de classification avec celles des radiologues et avec d'autres études dans la tâche de classification des nodules.

Ensuite, nous créons un nouveau dataset appelé *TRPMLN*, qui extrait *les nodules qui ont une moyenne de malignité égale à 3 ou plus dans les annotations des quatre experts*. Nous avons inclus une annexe qui présente l'implémentation du code _PYTHON_ pour créer cet ensemble de données. Nous développons un autre modèle de classification qui peut *classer les nodules en fonction de leur risque de malignité* à partir des images CT scan. Nous comparons les performances de notre modèle avec celles des radiologues et avec d'autres études dans le même tâche.

Le plan de l'étude est le suivant : dans la section Méthode, nous présentons le dataset _LIDC-IDRI_, le dataset _LUNA16_, le dataset _TRPMLN_, les modèles de deep learning et les critères d'évaluation. Dans la section Résultats, nous montrons les résultats obtenus par nos modèles sur les datasets _LUNA16_ et _TRPMLN_. Dans la section Discussion, nous analysons les forces et les limites de notre approche, ainsi que les implications cliniques. Dans la section Conclusion, nous résumons nos contributions et proposons des perspectives futures. #finchapiter


== Méthode.

Notre étude comprenait trois étapes principales : le prétraitement des données, le développement de l'algorithme de détection des nodules et l'évaluation des performances #cite("dou2017automated","ding2017accurate","armato2011lidc").

=== Ressources

Les ressources de notre étude étaient des scans CT et des annotations provenant du dataset _ LIDC-IDRI_, du dataset  _LUNA16_ et  _TRPMLN_. Le dataset _ LIDC-IDRI_ est une base de données publique qui contient 1018 scans thoraciques annotés par quatre radiologues experts. Chaque nodule pulmonaire est décrit par un fichier XML qui contient son identifiant, ses caractéristiques et sa région d'intérêt#footnote("Dataset Wiki: https://wiki.cancerimagingarchive.net/pages/viewpage.action?pageId=1966254").


Voici un tableau des points clés du résumé :

#figure(
  tablex(
    columns: 2,
    align: horizon,
    auto-vlines: false,
    repeat-header: false,
    [ *Pointer* ],[ *Résumé* ],
    [ Origine ],[ Partenariat public-privé] + footnote("L'origine de l'ensemble de données LIDC-IDRI est un partenariat public-privé car il a été financé à la fois par le secteur public (le National Cancer Institute) et le secteur privé (la Fondation pour les National Institutes of Health et les sociétés d'imagerie médicale qui ont participé à le projet)."), hlinex(stroke: 0.25pt),
    [ Taille ],[ 1018 CT scans ], hlinex(stroke: 0.25pt),
    [ Nodules ],[ Annoté par 4 radiologues ], hlinex(stroke: 0.25pt),
    [ Annotations ],[ Deux phases ], hlinex(stroke: 0.25pt),
    [ Disponibilité ],[ Disponible publiquement ], hlinex(stroke: 0.25pt),
    [ Utiliser ],[ Développement et évaluation CAO ],
  ),
  // caption: [Coordonnées des candidats détectés dans le dataset Luna16 avec diamètres],
  // kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)


=== Scans CT avec Nodules Pulmonaires.

Pour lire, traiter et représenter visuellement les scans CT montrant des nodules pulmonaires, nous avons mis en œuvre tois bibliothèques Python : SimpleITK#footnote("sous licence «Apache License 2.0.»."), Pylidc #footnote("sous licence «MIT License.»."), et matplotlib#footnote("sous licence «PSF License.»."). 

- Avec _*SimpleITK*_#cite("Beare2018", "Yaniv2017", "Lowekamp2013") et _*Pylidc*_#cite("Hancock2016") , nous avons lu les fichiers de scan CT de l'ensemble de données  _LUNA16_ ou _LIDC-IDRI_, convertissant ces images de leur format _raw_ , _mhd_ ou _DICOM_ en tableaux numériques multidimensionnels manipulables, appelés tableaux numpy.  

- Nous avons utilisé _*Matplotlib*_#cite("Hunter2007") pour tracer et afficher les tranches de scan CT contenant des nodules, complétant ces images par des lignes blanches marquant les limites autour de chaque nodule pour souligner leur emplacement et leurs dimensions.

La @Fig1 offre un exemple d'une tranche de scan CT, où le nodule est mis en évidence par des lignes blanches.

#images(
    filename:"images/seg4.png",
    caption:[
    Exemples d'une tranche de scan CT avec un nodule mis en évidence par des lignes blanches.
    ],
    width: 90%
    // ref:
) <Fig1>


==== Dataset LUNA16.

Le dataset  _LUNA16_ est un sous-ensemble du dataset _ LIDC-IDRI_, qui contient 1186 nodules annotés dans $888$ scans thoraciques. Ce dataset fournit également deux fichiers CSV distincts contenant les détails des candidats et des annotations. Dans le fichier candidates.csv, quatre colonnes sont illustrées : _seriesuid_, _coordX_, _coordY_, _coordZ_, et _classe_. Ici, le _seriesuid_ fonctionne comme un identifiant unique pour chaque scan ; _coordX_, _coordY_, et _coordZ_ représentent les coordonnées spatiales pour chaque candidat en millimètres, et _classe_ fournit une catégorisation binaire, dépeignant si le candidat est un nodule (1) ou non (0).


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


Le fichier _annotations.csv_ est composé de cinq colonnes : _seriesuid_, _coordX_, _coordY_, _coordZ_, et _diamètre_mm_, commandant l'identifiant unique du scanner, les coordonnées d'annotation spatiales en millimètres, et le diamètre de chaque annotation en millimètres, respectivement. Ces annotations ont été marquées manuellement en se basant sur l'identification des nodules de plus de 3 mm de diamètre par quatre radiologistes indépendants #cite("dou2017automated","ding2017accurate","armato2011lidc").

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


==== Dataset TRPMLN.


=== Développement des l'algorithmes de détection des nodules.
// nombres de nodules de enteaitenment de test?
//TODO accurence

Après avoir préparé les images de scans CT, l'ensemble de données (_LUNA16_ ou _TRPMLN_) a été divisé en ensembles d'entraînement et de test. L'ensemble d'entraînement comprenait 67% des données, tandis que l'ensemble de test comprenait les 33% restants. 

Deux modèles ont été entraînés sur l'ensemble d'entraînement et évalués sur l'ensemble de test : un modèle CNN et un modèle ResNet50. Les performances des modèles ont été mesurées en utilisant l'exactitude, le rappel et le score F1.

La construction des algorithmes de détection des nodules a été divisée en plusieurs étapes impératives. À leur base, les algorithmes reposaient sur un modèle de réseau neuronal convolutif (_CNN_) et un modèle ResNet50, chargés d'identifier les nodules à partir d'images de scans CT #cite("lin2017feature"). Le modèle _CNN_ était utilisé pour détecter la présence de nodules pulmonaires ou de lésions pulmonaires, tandis que le modèle _ResNet50_ était utilisé pour classification des nodules selon l'approximation du risque de cancer, malin ou non malin.

==== Model 1: Detection de type de Nodule.

#images(
    filename:"images/model2.png",
    caption:[
    La structure du modèle.
    ],
    width: 90%
    // ref:
)

Utilisant le dataset _LUNA16_, qui contient des images de nodules et de lésions pulmonaires, nous avons expérimenté différentes combinaisons de couches et de filtres pour trouver la meilleure architecture pour notre problème. Nous avons trouvé que le meilleur modèle pour nous était conçu comme suit :



#figure(
  tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [*Stage*], [*Output*], [*Param*],
    [Conv2D],                 [(None, 64, 64, 64)],        [4160],      
    hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 64, 64, 64)],        [16448],     
    hlinex(stroke: 0.25pt),
    [MaxPooling2D],           [(None, 8, 8, 64)],          [0],         
    
    [Conv2D],                 [(None, 8, 8, 64)],          [16448],     
    hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 8, 8, 64)],          [16448],     
    hlinex(stroke: 0.25pt),
    [MaxPooling2D],           [(None, 4, 4, 64)],          [0],         
    
    [Conv2D],                 [(None, 4, 4, 64)],          [16448],     
    hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 4, 4, 64)],          [16448],     
    hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 4, 4, 64)],          [262208],    
    hlinex(stroke: 0.25pt),
    [MaxPooling2D],           [(None, 2, 2, 64)],          [0],         
    
    [GlobalAveragePooling2],  [(None, 64)],                [0],         
    hlinex(stroke: 0.25pt),
    [Flatten],                [(None, 64)],                [0],         
    hlinex(stroke: 0.25pt),
    [Dense],                  [(None, 2)],                 [130],       
    colspanx(3)[*Total params: 348,738*]
  ),
  caption: [Cartes des caractéristiques de sortie à différentes étapes de notre architecture CNN.],
  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)

// TODO: check rate epoches
Pour entraîner le modèle, l'optimiseur _Adam_#cite("kingma2014adam") a été utilisé avec un taux d'apprentissage de $0,001$, et la fonction de perte _d'entropie croisée binaire_. Cette fonction de perte mesure la divergence entre la probabilité prédite par le modèle et la vérité terrain pour chaque image. Elle est adaptée aux problèmes de classification binaire, comme celui de détecter la présence ou l'absence de nodules. L'entropie croisée binaire pénalise les prédictions erronées plus fortement que les prédictions correctes, ce qui encourage le modèle à apprendre à distinguer les nodules des non-nodules avec une grande confiance. L'entraînement du modèle s'est étendu sur 100 époques.


==== Model 2: Détection de nodule à risque de cancer.

Nous développons aussi un modèle pour _*approximer la probabilité de risque de malignité des nodules pulmonaires*_ à partir d'images CT scan, basé sur l'ensemble de données qui a été créé en se basant sur le dataset original *LIDC-IDRI* et en nous appuyant sur les annotations de quatre radiologues experts. Nous avons expérimenté différentes combinaisons de couches et de filtres pour trouver la meilleure architecture pour notre problème. Nous avons trouvé que le meilleur modèle pour nous était conçu comme suit :


1568 nodules
(1568, 801, 767)


Les performances de classification des nodules du système conçu ont été évaluées sur TRPMLN. Pour la formation à la classification, 3 250 nodules ont été utilisés, contenant un nombre égal de nodules positifs et négatifs. Les nodules recadrés détectés sont de taille 64 × 64 × 1. En raison de la différence infime entre les nodules bénins et malins, 1 000 époques ont été utilisées avec un taux d'apprentissage de 0,001. Les performances de classification des nodules sont décrites dans le tableau 5

== RES



=== Évaluation des performances du modèle.

Nous avons évalué le succès du modèles à travers son *exactitude* sur les ensembles de données d'entraînement et de validation. L'*exactitude* du modèle sur les données d'entraînement et de validation a été documentée à chaque étape du processus d'apprentissage #cite("SetioTBBBC0DFGG16").

Le terme *exactitude* fait référence à la capacité du modèle à prévoir correctement les résultats sur les données d'entraînement, tandis que l'*exactitude de validation* signifie la capacité du modèle à généraliser ses prédictions à de nouvelles données inédites, c'est-à-dire les données de validation.


#images(
  filename:"images/class2.svg",
  caption:[
            Évolution des précisions d’entraînement et de validation au cours de l’apprentissage.
	  ],
  width: 100%
  // ref:
)


En examinant les valeurs d'*exactitude* et d'*exactitude de validation* tout au long des étapes d'apprentissage, il est indiqué que le modèle acquiert des connaissances, comme on peut le voir à travers l'amélioration progressive des exactitudes d'entraînement et de validation. Le modèle commence avec des exactitudes relativement plus faibles, autour de $64%$, avant d'augmenter à plus de 89% et de terminer avec un score de 87% à la fin de l'entraînement. Cela démontre la capacité raffinée du modèle à catégoriser correctement un ratio considérable de cas.

=== Métriques d'évaluation : Précision, Rappel et Score F1.

#block()[
#set text(9pt, style: "italic")
#grid(
  columns: (1fr, 2fr),
  rows: (auto),
  gutter: 3pt,
    figure(
      tablex(
        columns: 3,
        align: center + horizon,
        auto-vlines: false,
        repeat-header: false,

        [],         [*Positive*], [ *Négative*],


        [*Vrai*], [$652$], [$1286$], hlinex(stroke: 0.25pt),
        [*Faux*], [$90$], [$199$],
      )+text(size: 2pt," "),
      caption: [La matrice de confusion.],
      kind: "tabl",
      supplement: [#text(weight: "bold","Table")],

    ),
    /* -------------------------*/
    figure(
      tablex(
        columns: 4,
        align: center + horizon,
        auto-vlines: false,
        repeat-header: false,

        [],         [*Précision*], [ *Rappel \ (sensibilité)*], [*F1-score*],


        // [*Class 0*], [$86%$],      [$93%$], [$90%$], hlinex(stroke: 0.25pt),
        // [*Class 1*], [$88%$],      [$77%$], [$82%$], hlinex(stroke: 0.25pt),
        [*Total*],   [$87.8%$],    [$76.6%$], [$81.8%$],
      )+text(size: 8pt," "),
      caption: [Précision, rappel et F1-score du modèle pour les classes 0 et 1],
      kind: "tabl",
      supplement: [#text(weight: "bold","Table")],
    ),

  )
]


La performance du modèle a aussi été évaluée à partir de _la matrice de confusion_, qui permet de calculer des métriques comme la *précision*, le *rappel (sensibilité)* et le *score F1*, en plus de l’*exactitude*. Ces mesures fournissent un aperçu plus large des performances du modèle, notamment quand il y a un déséquilibre des classes #cite("lin2017focal").

// #linebreak()


#let VP="VP"
#let FP="FP"
#let FN="FN"


- La *précision* représente la fraction des prédictions positives correctes (plus précisément, lorsque le modèle identifie correctement un nodule) sur toutes les prévisions positives faites par le modèle. Une précision élevée indique un faible taux de faux positifs du modèle. Le modèle a atteint une précision de $87.8%$.

$ "précision" &= (VP) / (VP + FP) \
              &= 652/(652+90) \
              &= 87.8%
$

// #images(
//     filename:"images/pre_recall2.png",
//     caption:[
//     Précision et rappel (« recall »). La précision compte la proportion d'items pertinents parmi les items sélectionnés alors que le rappel compte la proportion d'items pertinents sélectionnés parmi tous les items pertinents sélectionnables.
//     ],
//     width: 60%
//     // ref:
// )


- Le *Rappel (Sensibilité)*, synonyme de sensibilité ou de taux de vrais positifs, est le rapport des prédictions positives correctes à tous les positifs réels. Un rappel élevé indique que le modèle a correctement identifié la majorité des cas positifs réels. Le modèle a atteint un rappel de $76.6%$.

$ "rappel" &= (VP) / (VP + FN)    \
           &= 652/(652+199) \
           &= 76.6%
$

- Le *F1-score* est la moyenne harmonique de la précision et du rappel, fournissant une seule mesure qui équilibre ces métriques. Le modèle a obtenu un _score F1_ de $81.8%$.
-
$ F_1 &= (2 VP)/(2VP + FP + FN)   \
      &= (2 times 252)/(2 times 256 + 90 + 199) \
      &= 81.8%
$






== DIS

Les résultats montrent (dans le tableau 5) que le modèle proposé a atteint une précision inférieure à celle des modèles existants. On remarque que l’utilisation des biomarqueurs cliniques en combinaison avec les techniques automatisées de détection et de classification des nodules pulmonaires permet de réduire les erreurs de diagnostic et d’augmenter la fiabilité de l’analyse CT.
