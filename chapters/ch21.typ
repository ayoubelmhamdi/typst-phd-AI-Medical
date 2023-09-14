#import "../functions.typ": heading_center, images, italic,linkb, dots
#import "../tablex.typ": tablex, cellx, rowspanx, colspanx, hlinex

#let finchapiter = text(fill:rgb("#1E045B"),"■")

// #linebreak()
// #linebreak()
// #counter("tabl").update(n=>n+20)

= DETECTION ET CLASSIFICATION DES NODULES PULMONAIRES À L’AIDE DU DEEP LEARNING
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

Le plan de l'étude est le suivant : dans la section Méthode, nous présentons le dataset _LIDC-IDRI_, le dataset _LUNA16_, le dataset _TRPMLN_, les modèles de deep learning et les critères d'évaluation. Dans la section Résultats, nous montrons les résultats obtenus par nos modèles sur les datasets _LUNA16_ et _TRPMLN_. Dans la section Discussion, nous analysons les forces et les limites de notre approche. Dans la section Conclusion, nous résumons nos contributions et proposons des perspectives futures. #finchapiter


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
    filename:"images/3_nodules.png",
    caption:[
    // Exemples d'une tranche de scan CT avec un nodule mis en évidence par des lignes blanches.
    Catégories de nodules pulmonaires dans un scanner CT; bénigne, maligne primaire, et maligne métastatique (de gauche à droite)#cite("Nasrullah2019").
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
    [1.3.6...666836860], [68.42], [-74.48], [-288.7], [0], hlinex(stroke: 0.25pt),
    [1.3.6...666836860], [68.42], [-74.48], [-288.7], [0], hlinex(stroke: 0.25pt),
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

La création du jeu de données _*TRPMLN*_ implique plusieurs étapes. Initialement, un environnement virtuel Python est établi et activé, suivi par l'installation des packages Python nécessaires à partir d'un fichier _requirements.txt_. Un fichier de configuration pour _pylidc_ est ensuite généré, qui spécifie le chemin vers le jeu de données LIDC-IDRI.

Le jeu de données _LIDC-IDRI_ est par la suite interrogé en utilisant _pylidc_, en filtrant les scans avec une épaisseur de tranche supérieure à 3 mm et un espacement de pixels supérieur à 1 mm. Pour chaque scan dans le jeu de données filtré, les annotations sont regroupées en nodules. Un score moyen de malignité est calculé pour chaque nodule sur la base des scores fournis par différents experts. Si ce score moyen est de 3 ou plus, le nodule est classé comme cancéreux ; sinon, il est considéré comme normal.

Les données pour chaque nodule sont enregistrées, y compris le nom du nodule (qui indique s'il est cancéreux ou non) et l'objet d'annotation. Ces données sont utilisées pour créer un fichier CSV avec deux colonnes : "roi_name" (le nom du nodule) et "cancer" (indiquant s'il est cancéreux ou non).

Pour chaque ligne de données, une région d'intérêt (ROI) est extraite du volume du scan en fonction de la boîte englobante de l'annotation. La ROI est normalisée à une plage de 0 à 255 pour les images en 8 bits et sauvegardée en tant qu'image _TIFF_ dans un répertoire spécifié. Pour gérer l'utilisation de la mémoire, le _garbage collector_ de Python est invoqué toutes les 10 itérations pour nettoyer la mémoire inutilisée.

Le jeu de données _TRPMLN_ final comprend des images _TIFF_ de nodules et un fichier CSV contenant des informations sur ces nodules. Ce jeu de données peut être utilisé pour entraîner des modèles d'apprentissage profond pour classer les nodules malins.

Ces étapes sont démontrées dans l'ANNEXE 2.

=== Développement des l'algorithmes de détection des nodules.
// nombres de nodules de enteaitenment de test?

Après avoir préparé les images de scans CT, l'ensemble de données (_LUNA16_ ou _TRPMLN_) a été divisé en ensembles d'entraînement et de test. L'ensemble d'entraînement comprenait 67% des données, tandis que l'ensemble de test comprenait les 33% restants. 

Deux modèles ont été entraînés sur l'ensemble d'entraînement et évalués sur l'ensemble de test : un modèle _CNN_ et un modèle _ResNet50_. Les performances des modèles ont été mesurées en utilisant l'exactitude, la précision, la sensibilité et le "F1-score".

La construction des algorithmes de détection des nodules a été divisée en plusieurs étapes impératives. À leur base, les algorithmes reposaient sur un modèle de réseau neuronal convolutif (_CNN_) et un modèle _ResNet50_, chargés d'identifier les nodules à partir d'images de scans CT #cite("lin2017feature"). Le modèle _CNN_ était utilisé pour détecter la présence de nodules pulmonaires ou de lésions pulmonaires, tandis que le modèle _ResNet50_ était utilisé pour classification des nodules selon l'approximation du risque de cancer, malin ou non malin.

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
    [Conv2D],                 [(None, 64, 64, 64)],        [4160],      hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 64, 64, 64)],        [16448],     hlinex(stroke: 0.25pt),
    [MaxPooling2D],           [(None, 8, 8, 64)],          [0],         
    
    [Conv2D],                 [(None, 8, 8, 64)],          [16448],     hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 8, 8, 64)],          [16448],     hlinex(stroke: 0.25pt),
    [MaxPooling2D],           [(None, 4, 4, 64)],          [0],         
    
    [Conv2D],                 [(None, 4, 4, 64)],          [16448],     hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 4, 4, 64)],          [16448],     hlinex(stroke: 0.25pt),
    [Conv2D],                 [(None, 4, 4, 64)],          [262208],    hlinex(stroke: 0.25pt),
    [MaxPooling2D],           [(None, 2, 2, 64)],          [0],         
    
    [GlobalAveragePooling2],  [(None, 64)],                [0],         hlinex(stroke: 0.25pt),
    [Flatten],                [(None, 64)],                [0],         hlinex(stroke: 0.25pt),
    [Dense],                  [(None, 2)],                 [130],       
    colspanx(3)[*Total params: 348,738*]
  ),
  caption: [Architecture du modèle CNN.],
  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)

Pour entraîner le modèle, l'optimiseur _Adam_#cite("kingma2014adam") a été utilisé avec un taux d'apprentissage de $0,001$, et la fonction de perte _d'entropie croisée binaire_. Cette fonction de perte mesure la divergence entre la probabilité prédite par le modèle et la vérité terrain pour chaque image. Elle est adaptée aux problèmes de classification binaire, comme celui de détecter la présence ou l'absence de nodules. L'entropie croisée binaire pénalise les prédictions erronées plus fortement que les prédictions correctes, ce qui encourage le modèle à apprendre à distinguer les nodules des non-nodules avec une grande confiance. L'entraînement du modèle s'est étendu sur 100 époques, 6691 nodules ont été utilisés, dont 4165 de classe 0 et 2526 de classe 1. Les nodules recadrés détectés sont de taille 64 × 64 × 1.


==== Model 2: Détection de nodule à risque de cancer.

#images(
    filename:"images/structure_resnet.png",
    caption:[
   Un aperçu de ResNET. Notre approche extrait d’abord plusieurs patchs de nodules pour capturer le large éventail de variabilité des nodules à partir des images CT d’entrée. Enfin, notre approche applique un classificateur pour étiqueter la malignité du nodule d’entrée.
    ],
    width: 90%
    // ref:
)

Nous développons aussi un modèle pour _*approximer la probabilité de risque de malignité des nodules pulmonaires*_ à partir d'images CT scan, basé sur l'ensemble de données qui a été créé(_TRPMLN_) en se basant sur le dataset original *LIDC-IDRI* et en nous appuyant sur les annotations de quatre radiologues experts. Nous avons expérimenté différentes combinaisons de couches et de filtres pour trouver la meilleure architecture pour notre problème. Nous avons trouvé que le meilleur modèle pour nous était conçu comme suit :

#figure(
  tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [*Layer type*],                   [*Output Shape*],       [*Param*],
    [InputLayer],            [(None, 64, 64, 1)],    [0],        hlinex(stroke: 0.25pt),
    [Concatenate],           [(None, 64, 64, 3)],    [0],        hlinex(stroke: 0.25pt),
    [UpSampling2D],          [(None, 192, 192, 3)],  [0],        hlinex(stroke: 0.25pt),
    [ZeroPadding2D],         [(None, 198, 198, 3)],  [0],        hlinex(stroke: 0.25pt),
    [ResNet],                [-],                     [23587712], hlinex(stroke: 0.25pt),
    [GlobalAveragePooling2D],[(None, 2048)],         [0],        hlinex(stroke: 0.25pt),
    [Flatten],               [(None, 2048)],         [0],        hlinex(stroke: 0.25pt),
    [Dense],                 [(None, 2)],            [4098],     hlinex(stroke: 0.25pt),
    colspanx(3)[*Total params: $23591810$*]
  ),
  caption: [Architecture du modèle ResNET.],
  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)

Les performances de classification des nodules du système conçu ont été évaluées sur _TRPMLN_. Pour la formation à la classification, 1568 nodules ont été utilisés, dont 801 de classe 0 et 767 de classe 1. Les nodules recadrés détectés sont de taille 64 × 64 × 1. Entraînés sur 118 époques, un taux d'apprentissage de 0,001 a été utilisé, et comme optimiseur on a utilisé Adam et la fonction de perte d'entropie croisée binaire.

== Résultats.
=== Évaluation des performances du modèle.

Nous avons évalué le succès du modèles à travers son *exactitude*#footnote("exactitude: \"accuracy\" en Anglais.") sur les ensembles de données d'entraînement et de validation. L'*exactitude* du modèle sur les données d'entraînement et de validation a été documentée à chaque étape du processus d'apprentissage #cite("SetioTBBBC0DFGG16").

Le terme *exactitude* fait référence à la capacité du modèle à prévoir correctement les résultats sur les données d'entraînement, tandis que l'*exactitude de validation* signifie la capacité du modèle à généraliser ses prédictions à de nouvelles données inédites, c'est-à-dire les données de validation.



=== Métriques d'évaluation : Précision, Sensibilité et "F1-Score".

La performance du modèle peut a été évaluée à partir de _la matrice de confusion_, qui permet de calculer des métriques comme la *précision*, la *sensibilité (recall)* et le *F1-Score*, en plus de l’*exactitude*. Ces mesures fournissent un aperçu plus large des performances du modèle, notamment quand il y a un déséquilibre des classes.

// #linebreak()


#let VP="VP"
#let FP="FP"
#let FN="FN"


- La *précision* représente la fraction des prédictions positives correctes (plus précisément, lorsque le modèle identifie correctement un nodule) sur toutes les prévisions positives faites par le modèle. Une précision élevée indique un faible taux de faux positifs du modèle.

$ "précision" = (VP) / (VP + FP) $ 
              // &= 652/(652+90) \
              // &= 87.8%
// $

// #images(
//     filename:"images/pre_recall2.png",
//     caption:[
//     Précision et sensibilité (« recall »). La précision compte la proportion d'items pertinents parmi les items sélectionnés alors que la sensibilité compte la proportion d'items pertinents sélectionnés parmi tous les items pertinents sélectionnables.
//     ],
//     width: 60%
//     // ref:
// )


- La *Sensibilité (Recall)*, synonyme de sensibilité ou de taux de vrais positifs, est le rapport des prédictions positives correctes à tous les positifs réels. Une sensibilité élevée indique que le modèle a correctement identifié la majorité des cas positifs réels.

$ "sensibilité" = (VP) / (VP + FN) $
// $ \
//            &= 652/(652+199) \
//            &= 76.6%
// $

- Le *F1-score* est la moyenne harmonique de la précision et de la sensibilité, fournissant une seule mesure qui équilibre ces métriques.
-
$ F_1 &= (2 VP)/(2VP + FP + FN) $
// $ \
//       &= (2 times 252)/(2 times 256 + 90 + 199) \
//       &= 81.8%
// $



==== Performances du modèle 1 sur LUNA16 en utilisant CNN

#images(
  filename:"images/class2.svg",
  caption:[
            Évolution des précisions d’entraînement et de validation de model 1 au cours de l’apprentissage.
	  ],
  width: 100%
  // ref:
)


En examinant les valeurs d'*exactitude* et d'*exactitude de validation* tout au long des étapes d'apprentissage, il est indiqué que le modèle acquiert des connaissances, comme on peut le voir à travers l'amélioration progressive des exactitudes d'entraînement et de validation. Le modèle commence avec des exactitudes relativement plus faibles, autour de $64%$, avant d'augmenter à plus de 89% et de terminer avec un score de 87% à la fin de l'entraînement. Cela démontre la capacité raffinée du modèle à catégoriser correctement un ratio considérable de cas.

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

        [],            [*Prédiction\ négative*], [*Prédiction\ positive*], 

        // Model 1
        [*Réel\ Négatif*], [$771$ VN],              [ $51$ FP], hlinex(stroke: 0.25pt),
        [*Réel\ Positif*], [$113$ FN],              [$404$ VP],
      )+text(size: 2pt," "),
      caption: [La matrice de confusion.],
      kind: "tabl",
      supplement: [#text(weight: "bold","Table")],

    ),
    /* -------------------------*/
    figure(
    v(8mm)+
      tablex(
        columns: 4,
        align: center + horizon,
        auto-vlines: false,
        repeat-header: false,
        // MODEL 1
        [],                  [*Précision*], [ *Sensibilité \ (Recall)*], [*F1-score*],
        [*Model\ CNN*],   [$88.79%$],     [$75.23%$],                   [$81.14%$],
      )+text(size: 12pt," "),
      caption: [Précision, sensibilité et "F1-score" du modèle 1],
      kind: "tabl",
      supplement: [#text(weight: "bold","Table")],
    ),

  )
]



==== Performances du modèle 2 sur TRPMLN en utilisant RESNET.

#images(
  filename:"images/resnet_model6.png",
  caption:[
            Évolution des précisions d’entraînement et de validation de model 2 au cours de l’apprentissage.
	  ],
  // height: 50%,
  width: 80%
  // ref:
)

Le modèle commence avec une exactitude d'environ 68,66 % à la première époque et s'améliore progressivement. À la 60ème époque, le modèle atteint une précision d'entraînement de 100% et la maintient pendant plusieurs époques.

La exactitude de validation commence à environ 50,63 % et fluctue tout au long du processus de formation, atteignant un pic d'environ 69,43 % mais ne se rapprochant jamais de la précision d'entraînement.

Cela suggère que le modèle a très bien appris les données d'entraînement, mais qu'il présente un surapprentissage.




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

        [],            [*Prédiction\ négative*], [*Prédiction\ positive*], 

        // Model 2
        [*Réel\ Négatif*], [$119$ VN],              [ $40$ FP], hlinex(stroke: 0.25pt),
        [*Réel\ Positif*], [$70$ FN],              [$85$ VP],
      )+text(size: 2pt," "),
      caption: [La matrice de confusion.],
      kind: "tabl",
      supplement: [#text(weight: "bold","Table")],

    ),
    /* -------------------------*/
    figure(
    v(8mm)+
      tablex(
        columns: 4,
        align: center + horizon,
        auto-vlines: false,
        repeat-header: false,
        
        // MODEL 2
        [],                  [*Précision*], [ *Sensibilité \ (Recall)*], [*F1-score*],
        [*Model\ ResNET*],   [68.00$%$],     [$54.83%$],                   [$60.71%$],
      )+text(size: 12pt," "),
      caption: [Précision, sensibilité et "F1-score" du modèle 2],
      kind: "tabl",
      supplement: [#text(weight: "bold","Table")],
    ),

  )
]




== Discussion.
Dans les deux modèles, nous avons un overfitting et des fluctuations de précision.

- *Overfitting* : la exactitude de l'entraînement atteint 100 %, ce qui est un signe clair de surajustement, surtout par rapport à la exactitude de validation qui est bien inférieure. Le surajustement signifie que le modèle a trop bien appris les données d'entraînement, y compris leur bruit et leurs valeurs aberrantes, ce qui le rend peu performant sur les données invisibles.

- *Fluctuations de la exactitude de la validation* : la exactitude de la validation fluctue beaucoup, ce qui peut suggérer que le modèle est instable ou que l'ensemble de validation n'est peut-être pas suffisamment représentatif.

#figure(
  tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [],                [*Précision*],     [ *Sensibilité (Recall)*],
    [*Song et al.* #cite("Song2017")],    [$82%$],       [$83%$], hlinex(stroke: 0.25pt),
    [*Nibali et al.* #cite("Nibali2017")],[$89%$],       [$91%$], hlinex(stroke: 0.25pt),
    [*Zhao et al.* #cite("Zhao2018")],    [$82%$],       [$$], hlinex(stroke: 0.25pt),
    [*Nos modèles*],                      [$88.79%$],    [$75.25%$],

  ),
  caption: [Comparaison avec d'autres études dans la tâche de classification des nodules ou des lésions.],

  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)

Comparaison avec nos résultats, notre modèle de classification de nodule ou lésion est performant de manière compétente dans l'identification des deux classes. En général, le modèle a performé de manière impressionnante en termes de précision, de sensibilité et de "F1-score".

#figure(
  tablex(
    columns: 3,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [*Models*],                [*Accuracy (%)*], [ *Year*],

    [*Multi-scale CNN* #cite("Shen2015")],     [86.84], [2015], hlinex(stroke: 0.25pt),
    [*Nodule level 2D CNN* #cite("Lai2016")], [87.30], [2016], hlinex(stroke: 0.25pt),
    [*Slice level 2D CNN* #cite("Lai2016")],  [86.70], [2016], hlinex(stroke: 0.25pt),
    [*Multi-crop CNN* #cite("Shen2017")],      [87.14], [2017], hlinex(stroke: 0.25pt),
    [*Vanilla 3D CNN* #cite("Lai2016")],      [87.40], [2016], hlinex(stroke: 0.25pt),
    [*Deep 3D DPN* #cite("Zhu2016")],         [88.74], [2017], hlinex(stroke: 0.25pt),
    [*Deep 3D DPN + GBM* #cite("Zhu2016")],   [90.44], [2017], hlinex(stroke: 0.25pt),
    [*3D MixNet* #cite("Nasrullah2019I")],           [88.83], [2019], hlinex(stroke: 0.25pt),
    [*3D MixNet + GBM* #cite("Nasrullah2019I")],     [90.57], [2019], hlinex(stroke: 0.25pt),
    [*3D CMixNet + GBM* #cite("Nasrullah2019")],     [91.13], [2019], hlinex(stroke: 0.25pt),
    [*3D CMixNet + GBM + Biomarkers* #cite("Nasrullah2019")],[94.17], [2019], hlinex(stroke: 0.25pt),
    [*Our Model ResNET*],                       [69,43], [2023]


  ),
      // Accuracy comparison of nodule classification on public dataset.
  caption: [Comparaison avec d'autres études dans le cadre de la classification des nodules malins ou bénins #cite("Song2017", "Nibali2017", "Zhao2018").],

  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)

Mais la comparaison de notre modèle de classification de nodule ou de lésion avec d'autres modèles n'est pas performante de manière compétitive, lorsque l'on veut approximer la détection des nodules malins.

Plusieurs facteurs peuvent expliquer pourquoi le modèle a tendance à identifier la classe 0 plutôt que la classe 1. L'une des stratégies pourrait être de renforcer la présence de la classe 1, ce qui pourrait aider le modèle à mieux distinguer la classe dominante et à améliorer légèrement sa performance pour cette classe.

De plus, la détection des nodules peut être une tâche plus complexe que celle des non-nodules. Les nodules sont souvent de petite taille, flous ou masqués par d'autres structures pulmonaires, ce qui peut compliquer leur détection. Ainsi, l'exploration d'autres techniques d'optimisation du modèle pourrait être bénéfique pour atténuer le biais du modèle en faveur de la classe 0.

En outre, les variations de caractéristiques entre les classes peuvent également entraîner des taux de détection différents. Des analyses plus approfondies, comme un examen détaillé des caractéristiques des données d'entrée, pourraient aider à comprendre précisément pourquoi ces différences de performances sont observées. L'utilisation de techniques de prétraitement des images, comme la normalisation, pourrait améliorer la qualité et la diversité des données d'entrée.

Pour résoudre ce problème, une stratégie d'entraînement raffinée pour notre modèle est nécessaire, ainsi qu'un indicateur de performance plus robuste que la simple précision. Les solutions potentielles pourraient inclure :

- L'application de techniques spécifiques pour accroître le nombre d'échantillons malins dans notre ensemble de données.
- L'utilisation de techniques d'équilibrage des classes pour obtenir une distribution équilibrée des classes dans notre ensemble de données.


Dans notre travail ultérieur, nous visons à incorporer certaines de ces solutions et nous nous attendons à améliorer les performances de notre modèle par rapport à la classification des nodules pulmonaires, pour maîtriser la classification des sous-types de nodules, tels que solides, non-solides, partiellement solides, pérfissuraux, calcifiés et spiculés. Différents traitements sont nécessaires pour différents types de nodules, ce qui rend leur détection précise encore plus pertinente pour un traitement réussi.


== Conclusion.

Nous avons utilisé le Deep-Learning pour détecter et classifier les nodules pulmonaires dans l'ensemble de données _LUNA16_ et _TRPMLN_. Les modèles ont affronté des défis liés à la diversité des nodules en termes de taille, de forme et d'emplacement, ainsi qu'à une distribution inégale dans l'ensemble de données. Malgré ces difficultés, ils ont performé de manière satisfaisante, produisant des scores élevés, un bon sensibilité et un _F1-score_ convaincant pour les nodules, qu'ils soient nodule ou lesion. Ils ont également performé de manière passable, produisant des scores passables pour la sensibilité et un _F1-score_ convaincant pour les nodules, qu'ils soient bénins ou malins.

En plus de cela, nous avons également formé un modèle pour classer les nodules comme probablement normaux ou anormaux. Ce modèle a également été confronté à des défis similaires en termes de diversité des nodules et de distribution inégale dans l'ensemble de données.

Les modèles ont montré un léger avantage dans l'identification des non-nodules, probablement en raison de la limitation du nombre de classe 1 dans l'ensemble de données.

Les résultats de notre étude soulignent que le Deep-Learning est efficace pour la détection et la classification des nodules pulmonaires. Il a le potentiel pour faciliter le diagnostic précoce du cancer du poumon, ce qui peut améliorer les chances de survie et l'efficacité du traitement.

Nous cherchons à améliorer nos modèles pour perfectionner leur performance, en particulier dans la détection des malignités des nodules pulmonaires. Pour cela, des recherches supplémentaires sont nécessaires. #finchapiter
