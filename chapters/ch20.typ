#import "../functions.typ": heading_center, images, italic,linkb, dots
#import "../tablex.typ": tablex, cellx, rowspanx, colspanx, hlinex

#let finchapiter = text(fill:rgb("#1E045B"),"■")

// #linebreak()
// #linebreak()
// #counter("tabl").update(n=>n+20)

= DÉTECTION DES NODULES PULMONAIRES DU CANCER.
== Introduction.

Le cancer du poumon figure parmi les principales causes de mortalité liées au cancer dans le monde entier #cite("national2011reduced"). La reconnaissance et le diagnostic précoces des nodules pulmonaires, petites masses de tissu dans les poumons, peuvent considérablement augmenter les taux de survie et le succès du traitement pour les individus atteints de cancer du poumon. Cependant, la détection et la classification de ces nodules pulmonaires représentent un défi de taille en raison de leur taille, forme, emplacement et caractéristiques physiques variables #cite("SetioTBBBC0DFGG16"). De plus, la majorité des nodules pulmonaires sont bénins ou non cancéreux, avec seulement un faible pourcentage classé comme malin ou cancéreux #cite("dou2017automated"). Ces conditions créent des complications pour la détection et la classification automatisées des nodules pulmonaires par le biais de modèles d'apprentissage automatique.

Dans cette étude, nous mettons en œuvre une expérience d'apprentissage automatique utilisant un modèle CNN pour déterminer si les nodules pulmonaires sont bénins ou malins à partir d'images de scans. Nous avons utilisé l'ensemble de données LUNA16 accessible au public #cite("SetioTBBBC0DFGG16") comprenant 888 scans CT de nodules annotés.

#figure(
  tablex(
    columns: 4,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [*CT Scans*],[*Nodules*],   [*Malins*], [ *Bénins*],


    [$888$],[$6692$], [$2526$], [$4166$],
  ),
  caption: [
    Le nombre total de nodules malin et non bénin.
  ],
  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)


Un total de 6692 nodules ont été isolés à partir de ces scans, dont seulement 2526 étaient malveillants et 4166 étaient bénins. Nous avons l'entraînement du modèle CNN en utilisant l'ensemble d'entraînement et avons évalué ses performances sur l'ensemble de validation.

== Méthode.

Notre étude comprenait trois étapes principales : le prétraitement des données, le développement de l'algorithme de détection des nodules et l'évaluation des performances #cite("dou2017automated","ding2017accurate","armato2011lidc").


=== Ressources.

Les ressources de notre étude étaient des scans CT et des annotations provenant de l'ensemble de données LUNA16 #cite("SetioTBBBC0DFGG16"). LUNA16, un ensemble de scans CT accessible au public du Lung Database Consortium (LIDC) et de l'Image Database Resource Initiative (IDRI), comprend 888 scans CT avec une épaisseur de tranche inférieure à 3 mm et un espacement de pixel inférieur à 0,7 mm. Cet ensemble propose également deux fichiers CSV distincts contenant les détails des candidats et des annotations.


Dans le fichier candidates_V2.csv, quatre colonnes sont illustrées : seriesuid, coordX, coordY, coordZ, et classe. Ici, le seriesuid fonctionne comme un identifiant unique pour chaque balayage ; coordX, coordY, et coordZ représentent les coordonnées spatiales pour chaque candidat en millimètres, et 'classe' fournit une catégorisation binaire, dépeignant si le candidat est un nodule (1) ou non (0).

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


Le fichier annotations.csv est composé de cinq colonnes : seriesuid, coordX, coordY, coordZ, et diamètre_mm, commandant l'identifiant unique du scanner, les coordonnées d'annotation spatiales en millimètres, et le diamètre de chaque annotation en millimètres, respectivement. Ces annotations ont été marquées manuellement en se basant sur l'identification des nodules de plus de 3 mm de diamètre par quatre radiologistes indépendants #cite("dou2017automated") #cite("ding2017accurate","armato2011lidc").


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



=== Scans CT avec Nodules Pulmonaires.

Pour lire, traiter et représenter visuellement les scans CT montrant des nodules pulmonaires, nous avons mis en œuvre deux bibliothèques Python : SimpleITK#footnote("sous licence «Apache License 2.0.».") et matplotlib#footnote("sous licence «PSF License.»."). 
- SimpleITK#cite("Beare2018", "Yaniv2017", "Lowekamp2013") offre un point d'accès simplifié à l'Insight Segmentation and Registration Toolkit (ITK), un cadre construit pour l'analyse et le traitement d'images. 
- Matplotlib#cite("Hunter2007"), en revanche, offre des fonctionnalités pour la visualisation et l'amélioration des images.

Avec SimpleITK, nous avons lu les fichiers de scan CT de l'ensemble de données LUNA16, convertissant ces images de leur format DICOM ou NIfTI en tableaux numériques multidimensionnels manipulables, appelés tableaux numpy. De plus, SimpleITK a été utilisé pour obtenir l'origine et l'espacement des images, définis comme les coordonnées de l'image et la taille du voxel, respectivement. Par la suite, nous avons rééchantillonné les images en utilisant SimpleITK, obtenant une taille de voxel uniforme de 1 mm x 1 mm x 1 mm, normalisé les valeurs de pixel à une plage de -1000 à 320 unités Hounsfield (HU), et appliqué un algorithme de segmentation pulmonaire pour isoler les régions pulmonaires des images.

Nous avons utilisé matplotlib pour tracer et afficher les tranches de scan CT contenant des nodules, complétant ces images par des lignes blanches marquant les limites autour de chaque nodule pour souligner leur emplacement et leurs dimensions #cite("SetioTBBBC0DFGG16","dou2017automated","ding2017accurate"). Une fonction a été développée, acceptant en entrée un tableau de scan CT, un tableau numpy composé de coordonnées et de diamètres de nodules, l'origine et l'espacement de l'image, et quelques paramètres optionnels. Cette fonction itère sur le tableau de nodules, calculant les coordonnées de voxel pour chaque nodule en fonction des coordonnées physiques de l'image, de son origine et de son espacement. Par la suite, elle modifie le tableau de scan CT, incorporant les lignes blanches autour de chaque nodule, et conclut en créant un tracé pour afficher les tranches de scan CT contenant les nodules en utilisant matplotlib.

La @Fig1 offre un exemple d'une tranche de scan CT, où le nodule est mis en évidence par des lignes blanches.

#images(
    filename:"images/seg4.png",
    caption:[
    Exemples d'une tranche de scan CT avec un nodule mis en évidence par des lignes blanches.
    ],
    width: 90%
    // ref:
) <Fig1>


==== Prétraitement des données.

Dans la phase de prétraitement des données, les scans CT ont été transformés du format DICOM en tableaux (tenseurs). Cela a été suivi par le rééchantillonnage des images pour obtenir des dimensions de voxel uniformes de 1 mm x 1 mm x 1 mm, la normalisation des valeurs de pixel pour répondre à une plage de -1000 à 320 unités Hounsfield (HU), et enfin l'utilisation d'un algorithme de segmentation pulmonaire pour extraire les régions pulmonaires des images. #cite("dou2017automated","ding2017accurate","armato2011lidc").


#figure(
  tablex(
    columns: 4,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [],              [*Train*], [*Test*], [*ALL*],

    [*Total Nodules*],[$4483$], [$2209$], [*6692*],
  ),
  caption: [
    Le nombre total de nodules d'entraînement et de tests.
  ],

  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],

)

Après avoir préparé les images de scans CT, l'ensemble de données a été divisé en ensembles d'entraînement et de test. L'ensemble d'entraînement comprenait 67% des données(4483 nodules), tandis que l'ensemble de test comprenait les 33% restants(2209 nodules). La division a été effectuée en utilisant la fonction train_test_split de la bibliothèque sklearn, avec un paramètre random_state fixé à 42 pour assurer la reproductibilité. Le modèle a été entraîné sur l'ensemble d'entraînement et évalué sur l'ensemble de test. Les performances du modèle ont été mesurées en utilisant l'exactitude, le rappel et le score F1.


==== Développement de l'algorithme de détection des nodules.

La construction de l'algorithme de détection des nodules a été divisée en plusieurs étapes impératives. À sa base, l'algorithme reposait sur un modèle de réseau neuronal convolutif (CNN), chargé d'identifier les nodules à partir d'images de scans CT #cite("lin2017feature").

#images(
    filename:"images/model2.png",
    caption:[
    La structure du modèle.
    ],
    width: 90%
    // ref:
)

Le modèle conçu comprenait :

- Une _couche d'entrée_ pour recevoir une image 2D avec une seule couleur de canal.
- Deux couches convolutives (Couche convolutive 1 et 2) sont définies avec 32 filtres et une taille de noyau de 3x3. Les deux couches utilisent un padding 'same' pour préserver les dimensions spatiales de l'image.
- Après chaque couche convolutive, une _Fonction d'activation ReLU_ est appliquée.
- Après ces deux couches convolutives, une opération de MaxPooling2D est effectuée pour réduire les dimensions spatiales de moitié.
- Un autre ensemble de deux couches convolutives (Couche convolutive 3 et 4) est défini, cette fois avec 64 filtres. Chaque couche est suivie d'une fonction d'activation ReLU.
- Ceci est suivi d'une autre opération de MaxPooling2D.
- Ensuite, un _GlobalAveragePooling2D_ est appliqué, agrégeant globalement par moyenne, permettant de réduire considérablement le nombre de paramètres du modèle.
- Ensuite, une opération _Flatten_ est effectuée pour convertir le tenseur multidimensionnel en un vecteur 1D.
- Ensuite, une _couche entièrement connectée_ (ou Dense) est appliquée avec deux neurones de sortie, correspondant aux deux classes cibles : la présence ou l'absence de nodules pulmonaires.
- Enfin, une fonction softmax est utilisée comme fonction d'activation de la dernière couche pour effectuer une classification binaire, fournissant une distribution de probabilité sur les deux classes.

Pour entraîner le modèle, l'optimiseur Adam a été utilisé avec un taux d'apprentissage de 0,001, une taille de lot de 40, et la fonction de perte d'entropie croisée binaire. Cette fonction de perte mesure la divergence entre la probabilité prédite par le modèle et la vérité terrain pour chaque image. Elle est adaptée aux problèmes de classification binaire, comme celui de détecter la présence ou l'absence de nodules. L'entropie croisée binaire pénalise les prédictions erronées plus fortement que les prédictions correctes, ce qui encourage le modèle à apprendre à distinguer les nodules des non-nodules avec une grande confiance #cite("Goodfellowetal2016"). L'entraînement du modèle s'est étendu sur 100 époques #cite("SetioTBBBC0DFGG16").

== Résultats.
=== Évaluation des performances du modèle.

Nous avons évalué le succès du modèle à travers son *exactitude* sur les ensembles de données d'entraînement et de validation. L'*exactitude* du modèle sur les données d'entraînement et de validation a été documentée à chaque étape du processus d'apprentissage #cite("SetioTBBBC0DFGG16").

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





== Discussion.

Les résultats illustrent que le modèle a performé de manière compétente dans l'identification des deux classes. En général, le modèle a performé de manière impressionnante en termes de précision, de rappel et de _score F1_.





Un certain nombre de facteurs peuvent expliquer pourquoi le modèle montre une préférence pour identifier la classe 0 (pas de nodule) par rapport à la classe 1 (présence de nodule). L'une des principales explications pourrait résider dans la composition de l'ensemble de données. Si l'ensemble de données comprend un plus grand nombre d'exemples de la classe 0 que de la classe 1, le modèle pourrait devenir plus apte à identifier la classe dominante, entraînant une performance légèrement supérieure pour cette classe.

Une autre explication possible pourrait être que la détection des nodules est une tâche plus difficile que la détection des non-nodules, car les nodules sont souvent petits, flous ou cachés par d’autres structures pulmonaires. Pour réduire le biais du modèle en faveur de la classe 0, il serait possible d’utiliser des techniques de rééquilibrage des classes, comme le suréchantillonnage ou le sous-échantillonnage, ou d’appliquer une focal loss, qui pénalise davantage les erreurs sur la classe minoritaire.

De plus, des caractéristiques différentes entre les classes peuvent également conduire à des taux de détection différents. Des analyses ultérieures, telles que des examens approfondis des caractéristiques des données d’entrée, pourraient aider à clarifier exactement pourquoi ces différences de performances sont observées. Les solutions pourraient impliquer l'utilisation de techniques de prétraitement des images, comme la normalisation ou l’augmentation des données, pour améliorer la qualité et la diversité des données d’entrée.

Pour résoudre ce problème, il faut une stratégie raffinée pour entraîner notre modèle et un indicateur de performance amélioré mieux que la précision. Les solutions potentielles comprennent :

- La mise en œuvre de techniques d'augmentation des données pour augmenter le nombre d'échantillons malins dans notre ensemble de données #cite("SetioTBBBC0DFGG16").
- L'utilisation de techniques de suréchantillonnage ou de sous-échantillonnage pour obtenir un équilibre des classes dans notre ensemble de données #cite("lin2017focal").

#figure(
  tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [],                [*Précision*], [ *Rappel (sensibilité)*],
    [*Song et al.*],   [$82%$],       [$83%$], hlinex(stroke: 0.25pt),
    [*Nibali et al.*], [$89%$],       [$91%$], hlinex(stroke: 0.25pt),
    [*Zhao et al.*],   [$82%$],       [$$], hlinex(stroke: 0.25pt),
    [*Nos modèles*],   [$87%$],       [$90%$],

  ),
  caption: [Comparaison avec d'autres études dans la tâche de classification des nodules#cite("Song2017", "Nibali2017", "Zhao2018").],

  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],

)

Dans notre travail ultérieur, nous visons à incorporer certaines de ces solutions et nous nous attendons à améliorer les performances de notre modèle par rapport à la classification des nodules pulmonaires, pour maîtriser la classification des sous-types de nodules, tels que solides, non-solides, partiellement solides, pérfissuraux, calcifiés et spiculés. Différents traitements sont nécessaires pour différents types de nodules, ce qui rend leur détection précise encore plus pertinente pour un traitement réussi.

== Conclusion.

Nous avons utilisé le Deep-Learning pour détecter et classifier les nodules pulmonaires dans l'ensemble de données LUNA16. Le modèle a affronté des défis liés à la diversité des nodules en termes de taille, de forme et d'emplacement, ainsi qu'à une distribution inégale dans l'ensemble de données. Malgré ces difficultés, il a performé de manière satisfaisante, produisant des scores élevés, un bon rappel et un F1 score convaincant pour les nodules, qu'ils soient bénins ou malins.

Le modèle a montré un léger avantage dans l'identification des non-nodules, probablement à cause du déséquilibre de classes dans l'ensemble de données. Nous envisageons des techniques d'augmentation des données et de rééquilibrage des classes pour remédier à ce problème.

Les résultats de notre étude soulignent que le Deep-Learning est efficace pour la détection et la classification des nodules pulmonaires. Il a le potentiel pour faciliter le diagnostic précoce du cancer du poumon, ce qui peut améliorer les chances de survie et l'efficacité du traitement.

Nous cherchons à améliorer notre modèle pour perfectionner sa performance, en particulier dans la détection des sous-types de nodules pulmonaires. Pour cela, des recherches supplémentaires sont nécessaires. #finchapiter
