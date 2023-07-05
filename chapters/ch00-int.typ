#import "../tablex.typ": tablex, cellx, rowspanx, colspanx
#let finchapiter = text(fill:rgb("#1E045B"),[■])

= INTRODUCTION GÉNÉRALE.
== Étendue du problème.

#counter(figure.where(kind: image)).update(0)


Dans le monde entier, le cancer du poumon est la cause principale des décès liés au cancer #cite("Siegel2017Cancer2017"). Une découverte opportune grâce à des scanners thoraciques de dépistage peut augmenter considérablement les chances de survie #cite("Nationallungscreening"). Potentiellement, les nodules pulmonaires (des masses rondes ou ovales détectables dans les scanners thoraciques) peuvent indiquer un cancer du poumon #cite("Gould2007EvaluationEdition"). L'efficacité des soins de santé pourrait bénéficier significativement d'un système informatisé capable d'identifier automatiquement ces nodules, permettant d'économiser du temps et des ressources pour les prestataires de santé et les patients.

Les algorithmes de détection des nodules se composent généralement de deux parties #cite("Setio2016PulmonaryNetworks") :
- La première étape recherche une grande variété de nodules possibles avec une grande sensibilité; cependant, elle génère de nombreux faux positifs.
- L'étape suivante atténue ces faux positifs en utilisant des caractéristiques et des classificateurs améliorés, une tâche difficile en raison des variables englobant les formes, les tailles, les types de nodules et leur ressemblance potentielle avec d'autres composants thoraciques comme les vaisseaux sanguins ou les ganglions lymphatiques #cite("Gould2007EvaluationEdition","Roth2016ImprovingAggregation").

Dans nos recherches, nous avons appliqué un réseau neuronal convolutionnel sur l’ensemble de données public LUNA16, composé de scanners thoraciques de 888 patients évalués par quatre experts médicaux #cite("Setio2016PulmonaryNetworks").

Finalement, la résultat a montré une performance de classification de nodule. Cela signifie qu’elle peut identifier de manière un peu précise plus de nodules cancéreux et moins de nodules non cancéreux #cite("Lin2016FeatureDetection","Kamnitsas2017EfficientSegmentation").

== Travaux connexes.

Les premières tentatives d'automatisation des dépistages du cancer du poumon se sont appuyées sur des algorithmes pour extraire les caractéristiques uniques des nodules pulmonaires. Les chercheurs ont mis l'accent sur les données volumétriques des nodules et les zones proches, mais ces méthodes ont souvent eu du mal à différencier correctement la gamme de variations des nodules, nécessitant une personnification pour chaque type de nodule distinct#cite("Jacobs2014AutomaticImages","Okumura1998AutomaticFilter","Li2003SelectiveScans"). Avec le temps, grâce à l'avancée des réseaux neuronaux profonds, ces techniques ont été progressivement améliorées. Les innovations récentes, tout particulièrement les méthodes basées sur les réseaux neuronaux convolutionnels (Convolutional Neural Networks, CNN), ont montré qu'elles pourraient améliorer la classification des nodules#cite("Roth2016ImprovingAggregation","Setio2016PulmonaryNetworks","Ding2017AccurateNetworks").

Un changement significatif dans le paradigme de détection des nodules pulmonaires a été l'intégration d'informations contextuelles multi-échelles, en particulier avec l'ensemble de données Luna16. Cette approche tire profit des méthodologies d'apprentissage profond pour évaluer une vaste gamme de caractéristiques morphologiques et structurales à travers diverses échelles#cite("Shen2015","Dou2016Multi-levelDetection"). Plusieurs techniques ont démontré leur efficacité.


Des chercheurs ont également suggéré plusieurs stratégies prometteuses pour la détection des anomalies pulmonaires, comme l'utilisation de patches 3D pour une précision accrue avec les données volumétriques et la réduction des faux positifs#cite("Setio2016PulmonaryNetworks","Roth2016ImprovingAggregation"). L'extraction graduelle des caractéristiques, une méthode séquentielle qui fusionne l'information de contexte à différentes échelles, offre une alternative à la pratique conventionnelle de l'intégration radicale#cite("Shen2015","Shen2017Multi-cropClassification").

La combinaison holistique de ces approches a permis d'obtenir des modèles plus fiables et robustes pour la détection des nodules pulmonaires. Les régions entourant les nodules pulmonaires potentiels ont été minutieusement examinées et comparées à d'autres organes ou tissus pour améliorer la différenciation des nodules#cite("Shen2017Multi-cropClassification"). Les améliorations futures pourraient inclure l'intégration de données contextuelles provenant des zones adjacentes aux nodules, renforçant ainsi potentiellement les performances et l'exactitude des modèles#cite("Dou2016Multi-levelDetection","Shen2017Multi-cropClassification"). #finchapiter
