#import "../functions.typ": heading_center, images, italic,linkb

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])
#let S1 = "S1"
#let S2 = "S2"
#let S3 = "S3"

= DÉTECTION DES NODULES PULMONAIRES DU CANCER.
== Introduction

Dans le monde entier, le cancer du poumon est la cause principale des décès liés au cancer @Siegel2017Cancer2017. Une découverte opportune grâce à des scanners thoraciques de dépistage peut augmenter considérablement les chances de survie @Nationallungscreening. Potentiellement, les nodules pulmonaires - des masses rondes ou ovales détectables dans les scanners thoraciques - peuvent indiquer un cancer du poumon @Gould2007EvaluationEdition. L'efficacité des soins de santé pourrait bénéficier significativement d'un système informatisé capable d'identifier automatiquement ces nodules, permettant d'économiser du temps et des ressources pour les prestataires de santé et les patients.

Les algorithmes de détection des nodules se composent généralement de deux parties @Setio2016PulmonaryNetworks :
- La première étape recherche une grande variété de nodules possibles avec une grande sensibilité; cependant, elle génère de nombreux faux positifs.
- L'étape suivante atténue ces faux positifs en utilisant des caractéristiques et des classificateurs améliorés - une tâche difficile en raison des variables englobant les formes, les tailles, les types de nodules et leur ressemblance potentielle avec d'autres composants thoraciques comme les vaisseaux sanguins ou les ganglions lymphatiques @Gould2007EvaluationEdition@Roth2016ImprovingAggregation.

Dans nos recherches, nous adoptons le réseau neuronal convolutionnel à intégration graduelle multi-échelle (mgi-cnn) comme méthode pour diminuer les faux positifs. Cette méthode présente trois caractéristiques notables :
1. Elle utilise des patchs de tailles différentes à partir des entrées de scanner thoracique; chaque taille contribue des informations variantes sur le nodule et sa zone environnante.
2. Cette méthode combine progressivement les patchs à travers différentes couches de réseau au lieu d'une intégration simultanée, ce qui conduit à un apprentissage approfondi des caractéristiques à différentes échelles.
3. Deux stratégies sont responsables de la combinaison des patchs : l'une allant du petit au grand (zoom in), et l'autre du grand au petit (zoom out), fournissant des informations de perspective variées @Karpathy2014Large-ScaleNetworks@Shen2015@Shen2017Multi-cropClassification@Dou2016Multi-levelDetection.

Nous avons examiné cette méthode à travers l'ensemble de données public LUNA16, composé de scanners thoraciques de 888 patients évalués par quatre experts médicaux @Setio2016PulmonaryNetworks.

Finalement, la méthode a affiché une performance supérieure dans la limitation des faux positifs, principalement à des taux plus faibles. Cela suppose qu'elle peut identifier de manière précise plus de nodules cancéreux et moins de nodules non cancéreux @Lin2016FeatureDetection@Kamnitsas2017EfficientSegmentation.

== Contexte relié
=== Informations volumétriques contextuelles

Les premières tentatives d'automatisation des dépistages du cancer du poumon se sont appuyées sur des algorithmes pour extraire les caractéristiques uniques des nodules pulmonaires. Les chercheurs ont mis l'accent sur les données volumétriques des nodules et les zones proches, mais ces méthodes ont souvent eu du mal à différencier correctement la gamme de variations des nodules, nécessitant une personnification pour chaque type de nodule distinct@Jacobs2014AutomaticImages@Okumura1998AutomaticFilter@Li2003SelectiveScans. Avec le temps, grâce à l'avancée des réseaux neuronaux profonds, ces techniques ont été progressivement améliorées. Les innovations récentes, tout particulièrement les méthodes basées sur les réseaux neuronaux convolutionnels (Convolutional Neural Networks, CNN), ont montré qu'elles pourraient améliorer la classification des nodules@Roth2016ImprovingAggregation@Setio2016PulmonaryNetworks@Ding2017AccurateNetworks.

=== Informations contextuelles multi-échelles

Un changement significatif dans le paradigme de détection des nodules pulmonaires a été l'intégration d'informations contextuelles multi-échelles, en particulier avec l'ensemble de données Luna16. Cette approche tire profit des méthodologies d'apprentissage profond pour évaluer une vaste gamme de caractéristiques morphologiques et structurales à travers diverses échelles@Shen2015@Dou2016Multi-levelDetection. Plusieurs techniques ont démontré leur efficacité, dont :

- L'approche Multi-scale CNN (MCNN) qui exploite l'extraction de caractéristiques à partir d'images à différentes échelles pour informer la formation du classificateur de différenciation des nodules@Shen2015.
- La technique Multi-Crop CNN qui utilise une combinaison d'approches de rognage et de poolage pour extraire des données notables de différentes régions de la carte de caractéristiques de convolution, affinant ainsi la précision de la détection@Shen2017Multi-cropClassification.

Des chercheurs ont également suggéré plusieurs stratégies prometteuses pour la détection des anomalies pulmonaires, comme l'utilisation de patches 3D pour une précision accrue avec les données volumétriques et la réduction des faux positifs@Setio2016PulmonaryNetworks@Roth2016ImprovingAggregation. L'extraction graduelle des caractéristiques, une méthode séquentielle qui fusionne l'information de contexte à différentes échelles, offre une alternative à la pratique conventionnelle de l'intégration radicale@Shen2015@Shen2017Multi-cropClassification.

La combinaison holistique de ces approches a permis d'obtenir des modèles plus fiables et robustes pour la détection des nodules pulmonaires. Les régions entourant les nodules pulmonaires potentiels ont été minutieusement examinées et comparées à d'autres organes ou tissus pour améliorer la différenciation des nodules@Shen2017Multi-cropClassification. Les améliorations futures pourraient inclure l'intégration de données contextuelles provenant des zones adjacentes aux nodules, renforçant ainsi potentiellement les performances et l'exactitude des modèles@Dou2016Multi-levelDetection@Shen2017Multi-cropClassification.

== Méthode.

Le Réseau Neuronal Convolutionnel d'Intégration Graduelle à Plusieurs Échelles, ou MGI-CNN, s'applique à l'identification des nodules pulmonaires. Il intègre deux composants principaux : l'Extraction Graduelle de Caractéristiques (GFE) et l'Intégration de Caractéristiques en Multi-Flux (MSFI) @Dou2016Multi-levelDetection@Nair2010RectifiedMachines.

=== Processus d'Extraction Graduelle de Caractéristiques

Avec GFE, le réseau fusionne les détails contextuels de patches à différentes échelles étape par étape. Il fonctionne dans deux scénarios : Zoom-In et Zoom-Out @Zhang2014ScaleAnalysis@Shen2015@Shen2017Multi-cropClassification.

Dans le scénario Zoom-In, les patches à des échelles croissantes subissent une filtration à l'aide de noyaux convolutionnels locaux. Le réseau concatène les cartes de caractéristiques obtenues à chaque échelle avec le patch qui suit et les entre dans les couches de convolution. Ce processus continue jusqu'à ce que le réseau intègre tous les détails contextuels de toutes les échelles. D'autre part, le scénario Zoom-Out suit la même procédure mais inverse l'ordre des patches.

Cette approche permet au réseau de combiner progressivement les caractéristiques contextuelles, capturant à la fois les informations locales et globales. Ainsi, le réseau peut cibler des zones nodulaires spécifiques ou des régions environnantes, distinguant ainsi efficacement les nodules d'autres structures dans le poumon.

=== Le Rôle de l'Intégration de Caractéristiques en Multi-Flux

MSFI, l'autre composant du réseau, utilise une combinaison de flux d'informations 'zoom-in' et 'zoom-out' qui reflètent différentes échelles de forme et de contexte du nodule @Nair2010RectifiedMachines. Ces caractéristiques variées et complémentaires améliorent la détection des nodules.

Faisant partie du MGI-CNN, MSFI combine des caractéristiques de différentes échelles et perspectives. Cette application vise à améliorer la réduction des faux positifs dans la détection des nodules pulmonaires, en utilisant l'ensemble de données Luna16.

Pour illustrer, prenons un patch 3D d'une image pulmonaire présentant un nodule. L'objectif est de détecter le nodule et de minimiser les faux positifs. Pour y parvenir, MSFI fusionne des caractéristiques de différentes échelles et perspectives.

Le réseau utilise deux flux de patches d'entrée à partir du patch original : un flux 'zoom-in', se concentrant sur la région du nodule, et un flux 'zoom-out', couvrant un contexte environnant plus large. Des échelles séparées, $S1$, $S2$ et $S3$, peuvent être mises en œuvre pour chaque flux.

Ensuite, le CNN extrait des caractéristiques de ces patches et génère une carte de caractéristiques qui encapsule les caractéristiques du patch. La sortie finale de MSFI est une carte de caractéristiques combinée contenant des informations provenant des deux flux.

Enfin, le réseau classe le patch comme un nodule ou non-nodule en utilisant cette carte de caractéristiques combinée. Il utilise un classificateur comme une couche softmax, qui attribue une probabilité à chaque classe. Plus la probabilité est élevée, plus la prédiction est sûre.

De cette façon, MSFI améliore les performances de détection des nodules pulmonaires en exploitant des caractéristiques de différentes échelles et perspectives. Ces caractéristiques capturent à la fois les propriétés morphologiques et contextuelles du nodule, réduisant ainsi les faux positifs.

== Procédure expérimentale et résultats
=== L'ensemble de données Luna16

Dans l'exploration du Deep-Learning pour la détection des nodules pulmonaires, les ensembles de données du défi LUNA16 sont devenus un facteur crucial. Ces données, qui comprennent 888 patients présentant des nodules pulmonaires examinés par quatre radiologues experts, ont constitué la base de notre évaluation@Setio2017validation. Nous avons omis les patients avec une épaisseur de coupe supérieure à 2.5mm. Lorsque trois radiologues étaient d'accord sur un nodule, nous le classions comme Vérité Terrain (VT). Ce processus a abouti à un total de 1186 nodules confirmés par VT.

Dans l'ensemble de données LUNA16, pour la tâche de réduction des faux positifs (FP), nous avons reçu des coordonnées du nodule potentiel, les identifiants des patients et les labels respectifs.

Pour traiter l'information provenant des scans CT, nous avons utilisé l'extraction de patchs 3D @Dou2016Multi-levelDetection. Cela a impliqué trois types d'échelles: 40x40x26, 30x30x10, et 20x20x6, ce qui a assuré une couverture complète du nodule. La redimension plus tard à 20x20x6 a été faite par interpolation du plus proche voisin, et la normalisation entre la plage de [-1000, 400] HU @Hounsfield1980ComputedImaging.

La formation du réseau a été facilitée par l'initialisation de Xavier@glorot2010understanding et un taux d'apprentissage de 0.003, englobant 40 époques. L'activation ReLU et un taux d'abandon de 0.5 ont été choisis pour les couches complètement connectées, et l'utilisation de la descente de gradient stochastique a permis une taille de lot de 128.

Nous avons mesuré la performance du DNN sur les données de test en utilisant la Metric de Performance Compétitive (CPM) @Niemeijer2011OnSystems.

==== Le calcul de CPM.

Illustrativement, utilisons un exemple. Supposons un ensemble de données de 100 scans CT donnant les résultats de modèle suivants:

- Total de nodules pulmonaires: 200
- Vrais positifs (VP): 150
- FPs: 800
- Faux négatifs (FN): 50

Les FPs sont calculés comme FP divisé par le nombre total de scans, nous donnant dans ce cas 8 FPs par niveau de scan, ce qui répond à notre objectif. Ensuite, nous calculons la sensibilité par la formule VP / (VP + FN), donnant 75%. Cela signifie que le modèle identifie avec précision 75% des nodules pulmonaires, permettant 8 FPs par scan.

==== Rapport Nodules à Non-nodules.

Les données suggèrent un rapport nodule à non-nodule d'environ 1:6. En pratique, cela signifie que pour chaque nodule dans l'ensemble de données, il y a environ six échantillons non-nodule. Il est important que l'équilibrage de la représentation des nodules par rapport aux non-nodules aide le modèle d'apprentissage automatique à apprendre à partir d'un ensemble de données diversifié.

Nous avons atteint ce ratio 1:6 par augmentation. À l'origine, à un ratio de 1:5, nous avons créé de nouveaux échantillons de nodules en les déplaçant et en les faisant pivoter sur divers axes. Cela a fourni un ensemble de données équilibré, améliorant la performance du modèle dans la détection des nodules.

=== Résultat CPM

L'évaluation de la performance du modèle a utilisé le score CPM comme une sensibilité moyenne sur sept niveaux FP/scan (à savoir 0.125, 0.25, 0.5, 1, 2, 4, and 8) @Niemeijer2011OnSystems. En utilisant une validation croisée en 7 unités, nous avons obtenu un équilibre grâce à l'augmentation des échantillons de nodules.

=== Evaluation du modèle

Pour déterminer l'efficacité du modèle, nous l'avons comparé aux méthodes existantes de pointe @Setio2016PulmonaryNetworks@Dou2016Multi-levelDetection. Notre méthode a surpassé les autres, affichage des scores CPM supérieurs pour sept valeurs FP/scan différentes.

=== L'avantage des techniques choisies

En examinant l'avantage de notre méthode unique, nous avons expérimenté divers CNN multi-échelles. Notre méthode a clairement surclassé les autres, aboutissant au meilleur CPM et à la réduction moyenne de FP. Cela souligne l'efficacité des stratégies GFE et MSFI que nous avons incorporées dans notre méthode.

== Discussions

L'utilisation de techniques d'apprentissage en profondeur, notamment l'ensemble de données LUNA16, pour la détection des nodules pulmonaires contribue grandement au diagnostic précoce du cancer du poumon. La structure MGI-CNN, spécialement conçue à cet effet, présente deux principales forces :

- Elle permet l'extraction de caractéristiques morphologiques et contextuelles à différentes échelles à partir des patchs d'entrée. L'information morphologique et contextuelle est progressivement incorporée par le réseau de zoom-in, tandis que le processus inverse a lieu dans le réseau de zoom-out. L'exploitation de l'information multi-échelle de cette manière fournit des caractéristiques complémentaires, ce qui booste les performances.
- La structure permet l'intégration de caractéristiques plus abstraites à partir des deux flux dans le MSFI, maximisant ainsi la réduction des faux positifs (FP) en fusionnant des caractéristiques à un niveau plus abstrait où l'information morphologique et contextuelle reste intacte.

Trois différentes méthodes : la concaténation, la somme élément par élément, et la convolution 1x1, ont été testées dans une tentative de fusionner les cartes de caractéristiques des deux flux dans le MSFI @Lin2013network. La somme élément par élément s'est avérée la plus efficace pour réduire les FP, même si aucune variance significative du CPM moyen n'a été observée entre les trois techniques.

Les patchs 3D originaux ont été modifiés en 20x20x6 pour s'aligner avec la taille du champ réceptif du réseau, risquant une éventuelle perte ou distortion d'information. Cependant, l'information essentielle du nodule a été préservée car le nodule occupait la majorité du patch. Ainsi, l'opération de redimensionnement n'a pas eu d'impact majeur sur les performances.

Une analyse approfondie a été réalisée sur les 232 FP que la MGI-CNN n'a pas pris en compte, les classant en trois groupes distincts formés sur la base de leurs probabilités de nodule : Faible Confiance (p variant de 0,5 à < 0,7) ; Confiance Modérée (p variant de 0,7 à < 0,9) ; et Haute Confiance (p > 0,9). La majorité des FP étaient essentiellement des composantes de grands tissus ou organes que le réseau n'a pas réussi à différencier des nodules.

Les FPs du groupe Confiance Moderée ont montré un faible contraste, potentiellement ancré dans le processus de normalisation lors de la prétraitement. Cette observation suggère une amélioration des performances si nous utilisons plus de patchs de différentes échelles et employons différentes méthodologies de normalisation.

Notre approche vise à améliorer le segment de réduction des FP d'un système typique de détection de nodules pulmonaires qui se compose de deux principales composantes : un segment de détection de candidats et un segment de réduction des FP. Le réseau peut fonctionner en tandem avec n'importe quelle technique de détection de candidats car il fonctionne indépendamment. La fusion du réseau avec des techniques de détection de candidats avancées devrait normalement produire de meilleurs résultats.

= CONCLUSION GÉNÉRALE.

La MGI-CNN, notre architecture, est spécifiquement conçue pour minimiser les FP dans la détection des nodules pulmonaires via les scans CT. Cela est réalisé grâce à trois stratégies majeures : des entrées multi-échelles avec différents niveaux d'information contextuelle, l'intégration progressive des données provenant de différentes échelles d'entrée, et l'intégration des caractéristiques multi-flux grâce à l'apprentissage de bout en bout.

En utilisant ces techniques, nous pouvons extraire des caractéristiques morphologiques et intégrer progressivement des informations contextuelles en multi-échelle, ce qui réduit le nombre de FP et extrait des caractéristiques morphologiques et contextuelles de la région du nodule.

L'analyse des performances du MGI-CNN sur les jeux de données du défi LUNA16 a donné un CPM moyen très impressionnant de 0.942, surpassant significativement les techniques de pointe. Notre méthodologie a démontré une efficacité exceptionnelle, notamment dans des conditions de faibles FP/scan.

En apportant de légères modifications, comme le remplacement des couches entièrement connectées par des couches de convolution $1 times 1$, notre réseau pourrait détecter directement les nodules à partir des scans CT, repoussant ainsi les limites de la détection du cancer.

Avançant, notre recherche vise à maîtriser la classification des sous-types de nodules, tels que solides, non-solides, partiellement solides, pérfissuraux, calcifiés et spiculés. Différents traitements sont nécessaires pour différents types de nodules, ce qui rend leur détection précise encore plus pertinente pour un traitement réussi.
