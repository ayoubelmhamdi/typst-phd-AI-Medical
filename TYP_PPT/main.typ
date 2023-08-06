= PPT


== Intorduction.

Le cancer du poumon figure parmi les principales causes de mortalité liées au cancer dans le monde entier. La reconnaissance et le diagnostic précoces des nodules pulmonaires, petites masses de tissu dans les poumons, peuvent considérablement augmenter les taux de survie et le succès du traitement pour les individus atteints de cancer du poumon.

Cependant, la détection et la classification de ces nodules pulmonaires représentent un défi de taille en raison de leur taille, forme, emplacement et caractéristiques physiques variables. De plus, la majorité des nodules pulmonaires sont bénins ou non cancéreux, avec seulement un faible pourcentage classé comme malin ou cancéreux.

Ces conditions créent des complications pour la détection et la classification automatisées des nodules pulmonaires par le biais de modèles d'apprentissage automatique. Dans cette étude, nous mettons en œuvre une expérience d'apprentissage automatique utilisant un modèle CNN pour déterminer si les nodules pulmonaires sont bénins ou malins à partir d'images de scans. Nous avons utilisé l'ensemble de données LUNA16 accessible au public comprenant 888 scans CT de nodules annotés. Un total de 6692 nodules ont été isolés à partir de ces scans, dont seulement 2526 étaient malveillants et 4166 étaient bénins. Nous avons l'entraînement du modèle CNN en utilisant l'ensemble d'entraînement et avons évalué ses performances sur l'ensemble de validation.


== Méthode.

Notre étude comprenait trois étapes principales : le prétraitement des données, le développement de l'algorithme de détection des nodules et l'évaluation des performances.

=== Ressources.

Les ressources de notre étude étaient des scans CT et des annotations provenant de l'ensemble de données LUNA16. LUNA16, un ensemble de scans CT accessible au public du Lung Database Consortium (LIDC) et de l'Image Database Resource Initiative (IDRI), comprend 888 scans CT avec une épaisseur de tranche inférieure à 3 mm et un espacement de pixel inférieur à 0,7 mm. Cet ensemble propose également deux fichiers CSV distincts contenant les détails des candidats et des annotations.

Dans le fichier candidates_V2.csv, quatre colonnes sont illustrées : seriesuid, coordX, coordY, coordZ, et classe. Le fichier annotations.csv est composé de cinq colonnes : seriesuid, coordX, coordY, coordZ, et diamètre_mm, commandant l'identifiant unique du scanner, les coordonnées d'annotation spatiales en millimètres, et le diamètre de chaque annotation en millimètres, respectivement.

=== Scans CT avec Nodules Pulmonaires.

Pour lire, traiter et représenter visuellement les scans CT montrant des nodules pulmonaires, nous avons mis en œuvre deux bibliothèques Python : SimpleITK et matplotlib.

Avec SimpleITK, nous avons lu les fichiers de scan CT de l'ensemble de données LUNA16, convertissant ces images de leur format DICOM ou NIfTI en tableaux numériques multidimensionnels manipulables, appelés tableaux numpy. De plus, SimpleITK a été utilisé pour obtenir l'origine et l'espacement des images, définis comme les coordonnées de l'image et la taille du voxel, respectivement. Par la suite, nous avons rééchantillonné les images en utilisant SimpleITK, obtenant une taille de voxel uniforme de 1 mm x 1 mm x 1 mm, normalisé les valeurs de pixel à une plage de -1000 à 320 unités Hounsfield (HU), et appliqué un algorithme de segmentation pulmonaire pour isoler les régions pulmonaires des images.

Nous avons utilisé matplotlib pour tracer et afficher les tranches de scan CT contenant des nodules, complétant ces images par des lignes blanches marquant les limites autour de chaque nodule pour souligner leur emplacement et leurs dimensions.

==== Prétraitement des données.

Dans la phase de prétraitement des données, les scans CT ont été transformés du format DICOM en tableaux (tenseurs). Cela a été suivi par le rééchantillonnage des images pour obtenir des dimensions de voxel uniformes de 1 mm x 1 mm x 1 mm, la normalisation des valeurs de pixel pour répondre à une plage de -1000 à 320 unités Hounsfield (HU), et enfin l'utilisation d'un algorithme de segmentation pulmonaire pour extraire les régions pulmonaires des images.


Après avoir préparé les images de scans CT et les masques pulmonaires, l'ensemble de données a été divisé en ensembles d'entraînement et de test. L'ensemble d'entraînement comprenait 67% des données(4483 nodules), tandis que l'ensemble de test comprenait les 33% restants(2209 nodules).

==== Développement de l'algorithme de détection des nodules.

La construction de l'algorithme de détection des nodules a été divisée en plusieurs étapes impératives. À sa base, l'algorithme reposait sur un modèle de réseau neuronal convolutif (CNN), chargé d'identifier les nodules à partir d'images de scans CT.

== Resulat

Nous avons évalué le succès du modèle à travers sa précision sur les ensembles de données d'entraînement et de validation. Le terme précision fait référence à la capacité du modèle à prévoir avec précision les résultats sur les données d'entraînement, tandis que la précision de validation signifie la capacité du modèle à étendre ses prédictions à de nouvelles données inédites, c'est-à-dire les données de validation. En examinant les valeurs de précision et de précision de validation tout au long des étapes d'apprentissage, il est indiqué que le modèle acquiert des connaissances, comme on peut le voir à travers l'amélioration progressive des précisions d'entraînement et de validation. La performance du modèle a également été évaluée à l'aide de métriques telles que la précision, le Rappel (sensibilité) et le score F1 en plus de la précision.

== Disscusion

Les résultats illustrent que le modèle a performé de manière compétente dans l'identification des deux classes, avec une légère préférence pour l'identification de la classe 0 (pas de nodule) par rapport à la classe 1 (présence de nodule). En général, le modèle a performé de manière impressionnante en termes de précision, de rappel et de score F1. L'ensemble de données présente une disparité excessive entre les classes bénignes et malignes, la classe bénigne étant plus de 400 fois plus prévalente que la classe maligne. Cette disproportion entrave le processus d'apprentissage du modèle pour distinguer entre les classes, et il pourrait par défaut prédire la classe la plus fréquente. Un certain nombre de facteurs peuvent expliquer pourquoi le modèle montre une préférence pour identifier la classe 0 (pas de nodule) par rapport à la classe 1 (présence de nodule). Des caractéristiques différentes entre les classes peuvent également conduire à des taux de détection différents. Pour résoudre ce problème, il faut une stratégie raffinée pour entraîner notre modèle et un indicateur de performance amélioré mieux que la précision. Les solutions potentielles comprennent l'implémentation de techniques d'augmentation des données et l'utilisation de techniques de suréchantillonnage ou de sous-échantillonnage. Dans notre travail ultérieur, nous visons à incorporer certaines de ces solutions et nous nous attendons à améliorer les performances de notre modèle par rapport à la classification des nodules pulmonaires.

== Conclusion

Nous avons utilisé le Deep-Learning pour détecter et classifier les nodules pulmonaires dans l'ensemble de données LUNA16. Le modèle a affronté des défis liés à la diversité des nodules en termes de taille, de forme et d'emplacement, ainsi qu'à une distribution inégale dans l'ensemble de données. Malgré ces difficultés, il a performé de manière satisfaisante, produisant des scores précis, un bon rappel et un F1 score convaincant pour les nodules, qu'ils soient bénins ou malins.

Le modèle a montré un léger avantage dans l'identification des non-nodules, probablement à cause du déséquilibre de classes dans l'ensemble de données. Nous envisageons des techniques d'augmentation des données et de rééquilibrage des classes pour remédier à ce problème.

Les résultats de notre étude soulignent que le Deep-Learning est efficace pour la détection et la classification des nodules pulmonaires. Il a le potentiel pour faciliter le diagnostic précoce du cancer du poumon, ce qui peut améliorer les chances de survie et l'efficacité du traitement.

Nous cherchons à améliorer notre modèle pour perfectionner sa performance, en particulier dans la détection des sous-types de nodules pulmonaires. Pour cela, des recherches supplémentaires sont nécessaires.
