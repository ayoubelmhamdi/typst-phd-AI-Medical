// pour que tu manque les autres, est ce que mon invite besoin de changement

#import "../functions.typ": heading_center, images, italic
#import "../tablex.typ": tablex, cellx, rowspanx, colspanx, hlinex

#let finchapiter = text(fill:rgb("#1E045B"),[■])


= APERÇU SUR DEEP LEARNING.

== Introduction.

L'apprentissage profond est une branche de l'apprentissage
automatique#footnote[https://fr.wikipedia.org/wiki/Apprentissage_profond] <wikiDeeplearning>, qui est lui-même un domaine de l'intelligence
artificielle. L'apprentissage profond permet de prédire ou d'analyser des
données de haute dimension ou complexes, comme les images, les textes ou les
sons, d'une manière similaire au cerveau humain. L'apprentissage profond
utilise des réseaux de neurones artificiels multicouches#footnote[https://www.ibm.com/topics/deep-learning] <ibmDeeplearning> qui
peuvent extraire les sens et les motifs cachés dans les données sans avoir
besoin d'intervention humaine. Ainsi, l'apprentissage profond acquiert une
grande capacité d'adaptation et d'évolution avec le changement de
données#cite("Goodfellowetal2016").

#images(
  filename:"images/ais.png",
  caption:[
            Comment l'apprentissage en profondeur est un sous-ensemble de
	    l'apprentissage automatique et comment l'apprentissage automatique est un
	    sous-ensemble de l'intelligence artificielle (IA).
	  ],
  width: 30%
  // ref:
)

Par conséquent, l'apprentissage profond se distingue de l'apprentissage
traditionnel par le fait qu'il ne repose pas sur des règles ou des algorithmes
prédéfinis, mais qu'il peut générer ses propres règles et algorithmes par essai
et erreur. De plus, l'apprentissage profond peut surmonter certains des
problèmes rencontrés par l'apprentissage traditionnel, tels que le bruit, le
manque ou le changement des données.

Ainsi, nous voyons que l'apprentissage profond est un domaine récent et
prometteur en informatique qui mérite l'attention et la recherche, et qui peut
contribuer à résoudre de nombreux problèmes dans différents domaines tels que
la traduction, la reconnaissance d'images et de sons, etc.

== Fonctionnement de Deep Learning.

Pour comprendre le principe de l'apprentissage profond, on peut utiliser des
exemples de notre vie quotidienne. Lorsque nous voulons améliorer certains
résultats, on change certains facteurs influençant ces résultats de manière
cyclique, en se basant sur l'expérience et l'erreur. Par exemple, un vendeur de
fruits essaie d'augmenter son revenu en changeant la quantité et les types de
fruits offerts aux clients, en se référant aux ventes passées et actuelles. Il
n'y a pas de règle fixe qui détermine la quantité de chaque fruit que le
vendeur doit fournir, il doit donc expérimenter jusqu'à ce qu'il atteigne le
point d'équilibre entre l'offre et la demande.

En apprentissage profond, on utilise une fonction mathématique appelée
*fonction coût* pour mesurer la différence entre les résultats d'un modèle
d'apprentissage et les résultats souhaités ou corrects. Puis on utilise une
autre fonction appelée *fonction optimisation* pour ajuster la valeur de chaque
cellule neuronale dans le réseau d'apprentissage afin de réduire la valeur de
la *fonction coût*. Ces étapes sont répétées sur un grand ensemble de données
jusqu'à ce que le modèle d'apprentissage soit capable d'accomplir les tâches
demandées avec précision ou acceptabilité.

Cet exemple peut nous donner une idée qui nous aide à comprendre
l'apprentissage en profondeur, mais il résume des concepts fondamentaux de
l'apprentissage en profondeur tels que la fonction de coût ou la fonction de
régression graduelle et l'optimisation<wikideeplearning>, ce qui est clair pour
nous dans des applications telles que la traduction automatique ou la vision
par ordinateur.

== Applications.

Dans la traduction automatique, un système d'apprentissage en profondeur
utilise un réseau neuronal pour convertir une phrase d'une langue à une autre.
Ce système utilise une fonction de coût pour mesurer la différence entre la
traduction générée et la traduction cible. Ensuite, il utilise un algorithme
d'optimisation tel que la descente de gradient pour ajuster le poids de chaque
cellule neuronale dans le réseau afin de minimiser la valeur de la fonction de
coût. Ce processus est répété sur un grand ensemble de phrases à traduire
jusqu'à ce que le système soit capable de générer des traductions précises et
naturelles.

En vision par ordinateur, un système d'apprentissage en profondeur utilise des
réseaux neuronaux artificiels pour extraire des informations et des
perspectives à partir d'images et de vidéos. Certaines applications dans ce
domaine sont#footnote[https://machinelearningmastery.com/applications-of-deep-learning-for-computer-vision/] <brownlee2019>:

- La *classification d'images* consiste à attribuer une étiquette à une image ou une photographie entière.

Ce problème est également appelé "classification d'objets" et peut-être plus
généralement "reconnaissance d'images", bien que cette dernière tâche puisse
s'appliquer à un ensemble beaucoup plus large de tâches liées à la
classification du contenu des images.

#images(
  filename:"images/MNIST-Dataset.png",
  caption:[Un exemple de chiffres de en jeu de données MNIST.],
  width: 50%
  // ref:
)

Un exemple populaire de classification d'images utilisé est le jeu de données(dataset) MNIST.
- *Surveillance du contenu*: pour supprimer automatiquement le contenu non
  sécurisé ou inapproprié des archives d'images et de vidéos.

- *Reconnaissance faciale*: pour identifier l'identité des personnes ou
  extraire des caractéristiques de leur visage, telles que l'ouverture ou la
fermeture des yeux, le port de lunettes ou de moustaches.

- *Violation du droit d'auteur*: pour supprimer le contenu volé ou détourné
  d'images ou de vidéos protégées par des droits d'auteur.

Ces applications sont rendues possibles grâce à l'utilisation de réseaux
neuronaux profonds qui peuvent apprendre à partir d'un grand nombre d'exemples
et extraire des caractéristiques complexes à partir des données.



== Les réseaux de neurones artificiels.
Les réseaux de neurones artificiels sont des modèles d'intelligence
artificielle qui utilisent des cellules nerveuses artificielles pour convertir
les entrées en sorties. Chaque cellule nerveuse reçoit des signaux d'autres
cellules et envoie des signaux à d'autres cellules. Chaque signal est ajouté à
une valeur de poids qui détermine sa force et son importance. Chaque cellule
nerveuse calcule la somme des signaux reçus et applique une fonction
d'activation pour produire un signal de sortie.

#images(
  filename:"images/reseuxActicvation.png",
  caption:[Architecture de modèle multicouche.],
  width: 50%
  // ref:
)
=== Exemple de Deep learning dans la pratique.

Pour savoir la relation entre les réseaux de neurones artificiels et la
fonction linéaire, on utilise l'exemple de calcule de temperature  precedent.

La fonction linéaire est un type de fonctions mathématiques qui décrit une
relation simple entre deux variables, où un changement dans l'une entraîne un
changement proportionnel dans l'autre. Par exemple, si nous avons une fonction
qui convertit la température de Celsius en Fahrenheit, cette fonction sera
linéaire, car chaque augmentation d'un degré Celsius entraîne une augmentation
constante de la température en Fahrenheit.


La formule utilisée pour convertir la température de Celsius en Fahrenheit est#cite("conversionDeLatemperature") :

$ F = 9/5  C + 32 $

On peut le représenter par le schéma de réseau suivant:
#images(
  filename:"images/1-nerons.svg",
  caption:[Structure mono-neurone..],
  width: 60%
  // ref:
)


Dans cette formule, nous pouvons définir deux facteurs principaux : le poids
des entrées et l'ordonnée à l'origine. Le poids des entrées est un nombre qui
multiplie la valeur de la variable indépendante (°C) pour déterminer son effet
sur la valeur de la variable dépendante (°F). Dans ce cas, le poids des entrées
est 1.8. L'ordonnée à l'origine est un nombre qui est ajouté au produit du
poids des entrées par la valeur de la variable indépendante pour déterminer la
valeur de la variable dépendante lorsque la variable indépendante est égale à
zéro. Dans ce cas, l'ordonnée à l'origine est 32.


#images(
  filename:"images/celsius-fahrenheit.png",
  caption: [Relation enter deux échelles de température Celsius et Fahrenheit.],
  width: 50%
  // ref:
)

Ces exemples montrent comment utiliser une fonction linéaire pour convertir la
température de Celsius en Fahrenheit. Mais comment utiliser une fonction
linéaire pour comprendre le concept de coût et d'optimisation dans
l'apprentissage profond ?

Dans l'apprentissage profond, nous utilisons des fonctions linéaires pour
produire des résultats basés sur un ensemble d'entrées. Chaque entrée a un
poids qui ajuste la mesure de son impact sur le résultat produit. Ensuite, nous
utilisons une fonction de coût pour mesurer la différence entre les résultats
produits et les résultats cibles. Ensuite, nous utilisons un algorithme
d'optimisation#cite("Goodfellowetal2016","kingma2014adam") pour ajuster les poids des
entrées afin de réduire la valeur de la fonction de coût.


Comme première étape dans l'apprentissage profond, nous devons collecter un
ensemble de données qui forment des paires d'entrées et de résultats cibles.
Dans l'exemple de conversion de la température de Celsius en Fahrenheit, nous
utilisons un tableau avec des mesures différentes de température dans les deux
systèmes comme des paires d'entrées et de résultats cibles :

#figure(
  tablex(
    columns: 2,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: false,

    [*température en Celsius °C*],  [*température en Fahrenheit °F *],


    [-40 ],[ -40 ], hlinex(stroke: 0.25pt),
    [-20 ],[ -4  ], hlinex(stroke: 0.25pt),
    [ 0  ],[ 32  ], hlinex(stroke: 0.25pt),
    [ 20 ],[ 68  ], hlinex(stroke: 0.25pt),
    [ 40 ],[ 104 ], hlinex(stroke: 0.25pt),
    [ 60 ],[ 140 ], hlinex(stroke: 0.25pt),
    [ 80 ],[ 176 ], hlinex(stroke: 0.25pt),
    [ 100],[ 212 ],

  ),
  caption: [Conversion de températures entre Celsius et Fahrenheit],
  kind: "tabl",
  supplement: [#text(weight: "bold","Table")],
)



Ce tableau nous permet de comparer la valeur de la température en Celsius avec
sa valeur correspondante en Fahrenheit. Mais que se passe-t-il si nous voulons
convertir une valeur qui n'est pas dans le tableau ? Pouvons-nous trouver le
poids des entrées et la coupe de l'axe qui convient pour représenter ces
données ?

La réponse est oui, mais pas facilement. Si nous essayons de deviner le poids
des entrées et la coupe de l'axe au hasard, nous obtiendrons des résultats
différents des résultats cibles. Par exemple, si nous supposons que le poids
des entrées est de $2$ et que la coupe de l'axe est de $0$, notre fonction sera:

$ F = (C × 1) + 0 $

Cette fonction donne des résultats imprécis. Par exemple, si nous voulons
convertir $20°C$ en Fahrenheit, elle donne#cite("Activation"):

$ F = (20 × 1) + 0 = 20 $

Et c'est une erreur car la valeur correcte est $68°F$.

#images(
  filename:"images/temperaturesPrevuesReelles.svg",
  caption:[L'écart entre les températures prévues et réelles.],
  width: 50%
  // ref:
)
Alors, comment trouvons-nous le poids des entrées et la coupe de l'axe corrects
? C'est là que l'apprentissage en profondeur intervient. L'apprentissage en
profondeur utilise un algorithme appelé régression pour trouver les meilleures
valeurs pour ces deux facteurs afin de réduire l'écart entre les résultats
générés et les résultats cibles. Cet écart est appelé fonction de coût ou
fonction d'erreur.


=== Erreur quadratique moyenne $E$.

La fonction de coût est une fonction mathématique mesurée entre zéro et la
valeur maximale possible. Plus la valeur de la fonction de coût est proche de
zéro, plus les résultats générés sont proches des résultats cibles. Par
exemple, nous utilisons la fonction de coût appelée erreur quadratique moyenne
$E$, qui calcule la moyenne de toutes les mesures d'erreur quadratique entre
chaque résultat généré et chaque résultat cible.

$ E = 1/n sum (y - y_0)^2 $

Où $n$ est le nombre de paires d'entrées et de résultats cibles, $y$ (ou $°F$)
est la mesure du résultat généré et $y_0$ (ou $°F_0$) est la mesure du résultat
cible.

Ainsi, si nous utilisons la $E$ pour mesurer l'écart entre une fonction
linéaire et un tableau de conversion des températures Celsius en Fahrenheit, la
valeur de la $E$ sera :

$ E &= 1/n sum (y - y_0)^2\
      &= 1/n sum ((w x+b) - y_0)^2\
      &= 4480 $


Il s'agit d'une explication de l'algorithme de descente de
gradient#cite("Goodfellowetal2016") qui est utilisé pour trouver les meilleurs poids
d'entrée et les biais afin que la valeur de la fonction de coût soit réduite à
zéro. Cela se fait en commençant par des poids et des biais aléatoires, puis en
les mettant à jour fréquemment en se déplaçant dans la direction opposée du
gradient de la fonction de coût.

=== Algorithme de descente de gradient.

Le gradient est un vecteur qui indique la direction dans laquelle la fonction
de coût augmente. En se déplaçant dans la direction opposée, nous pouvons
trouver le point le plus bas de la fonction de coût, qui correspond aux
meilleures valeurs pour les poids et les biais. La règle de mise à jour pour
les poids et les biais est donnée par#cite("rumelhart1986learning"):

$ w_(n+1) = w_n - epsilon (∂E)/(∂w) $

$ b_(n+1) = b_n - epsilon (∂E)/(∂b) $

Où $epsilon$ est appelé taux d'apprentissage et est un petit nombre positif qui
contrôle la taille du pas que nous prenons à chaque itération pour réduire la
différence entre les résultats attendus et initiaux. $(∂E)/(∂w)$ et $(∂E)/(∂b)$
sont les dérivées partielles de la fonction de coût par rapport aux poids et
aux biais respectivement. Ces dérivées partielles nous disent dans quelle
mesure la fonction de coût change lorsque le poids ou le biais change
légèrement.

Pour calculer ces dérivées partielles, nous pouvons utiliser une technique
appelée règle de chaîne#cite("spivak1967calculus"), qui nous permet de décomposer une
fonction complexe en fonctions plus simples et de multiplier leurs dérivées.
Par exemple, si nous avons une fonction $f (x) = g (h (x))$, où g et h sont des
fonctions plus simples, nous pouvons écrire:

$ (∂f)/(∂x) = (∂g)/(∂h) * (∂h)/(∂x) $

En utilisant cette technique, nous pouvons trouver les dérivées partielles de
$E$ par rapport à $w$ et $b$ comme suit:

$ (∂E)/(∂w) &= 1/n  sum -2x (y - y_0) \
(∂E)/(∂b) &= 1/n sum -2  (y - y_0) $

Soit  $epsilon = 2epsilon/n$ car $epsilon$ est un nombre arbitraire. Cela
signifie que vous pouvez simplifier les formules en éliminant le facteur $2/n$,
ce qui ne change pas le sens de l'algorithme dans cette cas.

$ w_(n+1) &= w_n + α  sum x (y - y_0) \
          b_(n+1) &= b_n + α  sum (y - y_0)  $

Où $x$ est la valeur d'entrée $°C$, $y_0$ est la valeur cible de sortie $°F$ et
$y$ est la valeur de sortie obtenue en utilisant notre fonction linéaire.

En utilisant ces formules, on peut mettre à jour notre poids et notre biais à
chaque itération jusqu'à ce qu'on atteigne un point où la fonction de coût est
réduite au minimum#cite("rumelhart1986learning","lecun2015deep").

Et on peut programmer un code simple en langage $CC$ qui effectue cette tâche (voir Annexe).

Dans l'entraîner de ce modèle, on a utilisé un ensemble de données
d'entraînement (td) qui contient des paires de températures en Celsius et en
Fahrenheit, et qui cherche à apprendre la formule de conversion entre ces deux
unités. La formule exacte est $y =9/5 x + 32$, où $y$ est la température en
Fahrenheit et $x$ est la température en Celsius. On a initialisé les paramètres
du modèle à des valeurs aléatoires proches de zéro, et on a lancé la descente
de gradient pour $100 000$ itérations. A chaque $10 000$ itérations, on a
affiché l'évolution de la fonction de coût et des paramètres du modèle.

Après $100 000$ itérations, on a obtenu les résultats suivants :

- Fonction de coût : $0.009562$
- Poids : $1.801169$
- Biais : $31.883127$

On peut voir que les paramètres du modèle sont très proches des valeurs exactes
de la formule de conversion. Pour tester la performance du modèle, on a utilisé
une nouvelle température $50C$ qui n'est l'entrainner pas et on obient une
temperature de $121.94F$, On a calculé l'erreur moyenne absolue (E) entre les
prédictions du modèle et les valeurs réelles. On a obtenu un E de $0.029°C$, ce
qui montre que le modèle est très précis et qu'il a bien appris la formule de
conversion.

On peut visualiser les résultats du modèle sur un graphique qui montre la
relation entre les températures en Celsius et en Fahrenheit. On peut voir que
les points sont alignés sur une droite qui correspond à la formule $y = 1.8x + 32$.
On peut également comparer le modèle avec un modèle aléatoire qui prédit
des valeurs aléatoires entre $-40°C$ et $100°C$. On peut voir que le modèle
aléatoire a un E beaucoup plus élevé que le modèle entraîné.

On peut conclure que le modèle de régression
linéaire#footnote[https://en.wikipedia.org/wiki/Linear_regression]<wikipediaLinearRegression>, #footnote[https://fr.wikipedia.org/wiki/R%C3%A9gression_lin%C3%A9aire]<wikipediaLinearRegressionfr>, #footnote[https://fr.wikipedia.org/wiki/Algorithme_du_gradient]<wikipediaAlgorithmeDuGradient>
est capable de générer des prédictions très proches des valeurs réelles, et
qu'il a réussi à apprendre la formule de conversion entre les températures en
Celsius et en Fahrenheit. Ce modèle pourrait être utilisé pour convertir des
températures dans d'autres unités, comme les kelvins ou les degrés Rankine.


/*
 * = CONCLUSION.
 * Dans ce chapitre, on a vu ce qu'est le deep learning, comment il fonctionne. On
 * a appris que le deep learning est une branche de machine learning qui utilise
 * des réseaux de neurones artificiels multicouches pour apprendre à partir de
 * données complexes ou de haute dimension. On a vu que le deep learning se
 * distingue de l'apprentissage traditionnel par le fait qu'il ne repose pas sur
 * des règles ou des algorithmes prédéfinis, mais qu'il peut générer ses propres
 * règles et algorithmes par essai et erreur#cite("Goodfellowetal2016"). On a aussi vu
 * que le deep learning peut surmonter certains des problèmes rencontrés par
 * l'apprentissage traditionnel, tels que le bruit, le manque ou le changement des
 * données.
 *
 * On a également compris le principe de l'apprentissage profond en utilisant des
 * exemples de notre vie quotidienne. On a vu comment on peut utiliser une
 * fonction mathématique appelée *fonction coût* pour mesurer la différence entre
 * les résultats d'un modèle d'apprentissage et les résultats souhaités ou
 * corrects. Puis on a vu comment on peut utiliser une autre fonction appelée
 * *fonction optimisation* pour ajuster la valeur de chaque cellule neuronale dans
 * le réseau d'apprentissage afin de réduire la valeur de la *fonction coût*. Ces
 * étapes sont répétées sur un grand ensemble de données jusqu'à ce que le modèle
 * d'apprentissage soit capable d'accomplir les tâches demandées avec précision ou
 * acceptabilité.
 *
 * On a aussi exploré les réseaux de neurones artificiels, qui sont des modèles
 * d'intelligence artificielle qui utilisent des cellules nerveuses artificielles
 * pour convertir les entrées en sorties<wikiDeeplearning>. On a vu comment chaque
 * cellule nerveuse reçoit des signaux d'autres cellules et envoie des signaux à
 * d'autres cellules. Chaque signal est ajouté à une valeur de poids qui détermine
 * sa force et son importance. Chaque cellule nerveuse calcule la somme des
 * signaux reçus et applique une fonction d'activation pour produire un signal de
 * sortie.
 *
 * Enfin, on a donné un exemple de deep learning dans la pratique en utilisant un
 * code simple en langage C qui effectue une régression linéaire pour convertir la
 * température de Celsius en Fahrenheit. On a vu comment on peut collecter un
 * ensemble de données qui forment des paires d'entrées et de résultats cibles,
 * comment on peut initialiser les paramètres du modèle à des valeurs aléatoires
 * proches de zéro, comment on peut lancer la descente de gradient pour mettre à
 * jour les paramètres du modèle à chaque itération, et comment on peut tester la
 * performance du modèle sur une nouvelle température qui n'est pas dans
 * l'ensemble d'entraînement.
 *
 * On peut conclure que le deep learning est un domaine récent et prometteur en
 * informatique qui mérite l'attention et la recherche, et qui peut contribuer à
 * résoudre de nombreux problèmes dans différents domaines tels que la traduction,
 * la reconnaissance d'images et de sons, etc. Le deep learning permet aux
 * systèmes de regrouper les données et de faire des prédictions avec une
 * précision incroyable. Le deep learning s'inspire de la structure du cerveau
 * humain et tente de tirer des conclusions similaires à celles que les humains
 * feraient en analysant continuellement les données avec une structure logique
 * donnée. Le deep learning utilise des structures multicouches d'algorithmes
 * appelées réseaux neuronaux, qui peuvent extraire les sens et les motifs cachés
 * dans les données sans avoir besoin d'intervention humaine<wikiDeeplearning>.
 * #finchapiter
 *
 * = RÉFÉRENCES BIBLIOGRAPHIQUES.
 * // #counter(heading).step()
 */

== Images et Deep Learning.

Les images tridimensionnelles qui portent des informations vitales sur la santé
humaine sont connues sous le nom d'images scanner (CT scan) et sont utilisées
dans le diagnostic et le traitement de nombreuses maladies telles que le
cancer, les accidents vasculaires cérébraux et les
fractures#cite("aggarwal2018neural"). Ces images nécessitent un traitement spécial pour
éliminer les distorsions, améliorer la qualité et extraire les caractéristiques
importantes #cite("zhang2023dive"). C'est pourquoi on utilise des réseaux de neurones
artificiels avancés capables de traiter efficacement ces images. Les réseaux de
neurones artificiels sont un système inspiré du fonctionnement des cellules du
cerveau dans le traitement de l'information et se composent d'un ensemble de
cellules nerveuses qui reçoivent et envoient des signaux en utilisant des
fonctions d'activation, des poids et des biais.

Le réseau de neurones se compose de plusieurs couches, y compris la couche
d'entrée(input layer), la couche de sortie (output layer) et les couches
cachées (hidden layers). Chaque couche étant composée d'un ensemble de cellules
nerveuses. La première couche joue le rôle de récepteur des données et la
dernière joue le rôle de sortie des données du réseau, et entre elles il y a
plusieurs couches qui jouent le rôle de récepteur des signaux des couches
précédentes et de les envoyer aux couches suivantes.

Cette étude vise à passer en revue les principaux types de réseaux de neurones
utilisés dans le domaine de l'imagerie médicale, en particulier les images
scanner. Elle vise également à expliquer l'importance des matrices dans le
stockage et la mise à jour des paramètres dans un réseau de neurones, en
mettant en lumière un exemple d'un réseau de neurones écrit avec des matrices
et des vecteurs.

=== Fonctions d'activation.

Dans cette exemple, nous avons vu comment l'apprentissage profond prédit la température Fahrenheit en utilisant une seule cellule nerveuse basée sur les données initiales uniquement. La solution requise était une équation pour une ligne droite qui pouvait être représentée par une ligne droite. Mais dans certains cas, la distribution des données est courbe comme une fonction sinus ou autre, et ne peut pas être représentée par une ligne droite. Nous avons donc besoin d'ajouter des fonctions non linéaires appelées fonctions d'activation, qui aident à plier la courbe linéaire générée par les cellules nerveuses en utilisant la puissance de leur poids et de leur biais#cite("Goodfellowetal2016").

#images(
  filename:"images/activation.png",
  caption: [Graphique de la fonction Unité Linéaire Rectifiée *ReLU*],
  width: 70%
  // ref:
)

L'une des fonctions d'activation les plus simples est l'unité linéaire rectifiée, ou fonction *ReLU*, qui est une fonction linéaire par morceaux qui renvoie zéro si son entrée est négative et renvoie directement l'entrée sinon:

$ f(x) = max(0,x) $

La fonction *ReLU* est souvent utilisée dans les réseaux d'apprentissage en profondeur pour ajouter de la non-linéarité au modèle. Cette non-linéarité permet au réseau neuronal d'apprendre des relations complexes entre les entrées et les sorties et d'éviter le surajustement des données d'entraînement.

#images(
  filename:"images/relu.png",
  caption: [Graphique de la fonction Unité Linéaire Rectifiée *ReLU*],
  width: 70%
  // ref:
)


Il existe plusieurs d'autres fonctions d'activation populaires en deep learning. Les plus courantes sont:

- *Sigmoid* : $f(x)=1/(1+e^(-x))$
- *Tanh* : $f(x)=tanh(x)=(e^x-e^(-x))/(e^x+e^(-x))$


=== L'importance des matrices dans l'apprentissage profond.

Les matrices sont un moyen efficace de stocker et mettre à jour les paramètres
dans un réseau de neurones. Plus le nombre de cellules et de liens dans un
réseau de neurones est élevé, plus le nombre de paramètres à modifier pour
améliorer les performances du réseau est élevé. Nous utilisons donc des
matrices pour éviter d'écrire des lignes de code répétitives pour corriger
chaque paramètre individuellement. Au lieu de cela, nous utilisons des boucles
itératives et des opérations algébriques sur les matrices pour mettre à jour
les paramètres plus rapidement et plus simplement#cite("bishop2006pattern").

#images(
    filename:"images/4-nerons.svg",
    caption:[Un réseau de neurones simple.],
    width: 40%
    // ref:
)
Soit un réseau de neurones avec deux entrées, une sortie et une couche cachée.
Ce réseau contient 4 neurones et 12 paramètres. Si on ajoute des couches
cachées supplémentaires, on augmente le nombre de variables. Cela complexifie
les équations et les matrices. On utilise pas des fonctions d'activation pour
simplifier le calcul. Le but est de faciliter la traduction du réseau en
matrices, avant de le coder dans un langage de programmation.
// edit


L'euquation de prédication $y$ c'est comme suit:

$ y = a_1^((1))+a_2^((1))+a_3^((1))+a_4^((1)) $

Avec

$
  a_1^((1)) &=  w_11^((1)) x_1 + w_21^((1)) x_2 + b_1^((1)) \
  a_2^((1)) &=  w_12^((1)) x_1 + w_22^((1)) x_2 + b_2^((1)) \
  a_3^((1)) &=  w_13^((1)) x_1 + w_23^((1)) x_2 + b_3^((1)) \
  a_4^((1)) &=  w_14^((1)) x_1 + w_24^((1)) x_2 + b_4^((1))
$

et finalemet:

$ y =

  (
     mat(x_1, x_2)

     mat(
       w_11^((1)),   w_12^((1)) , w_13^((1)), w_14^((1));
       w_21^((1)),   w_22^((1)) , w_23^((1)), w_24^((1));
     )
     +
     mat( b_1^((1)) , b_2^((1)) , b_3^((1)) , b_4^((1)); )
  )
  vec(1, 1, 1, 1)
$

L'ajout de couches cachées dans les réseaux de neurones peut compliquer la fonction de prédiction $y$ en augmentant le nombre de matrices de dimensions différentes. Les couches cachées sont considérées comme des activations qui reçoivent des signaux des couches précédentes et les modifient. Cela peut donner lieu à des fonctions imbriquées
/*
 * , que l'on peut symboliser par l'équation suivante :
 * $ y = a_1(a_2(a_3(...(x)))) $.
 *
*/

== Types de réseaux de neurones.

// melonge ces lignes:
Les réseaux de neurones peuvent être classés en plusieurs types selon la
structure et les applications utilisées. Les réseaux de neurones peuvent être
multicouches (MLP), récurrents (RNN), convolutionnels (CNN), et d'autres types.
Le type de réseau de neurones est choisi en fonction du problème posé et des
données disponibles#cite("lecun2015deep").

== Conversion d'images en vecteurs pour l'analyse par réseaux neuronaux.

La détection des nodules pulmonaires à l'aide du deep learning repose sur le traitement d'images, spécifiquement des scans de poumons. Ces images, représentées en matrices de pixels, constituent la matière première de notre apprentissage automatique. Chaque pixel de l'image correspond à une valeur qui détermine son intensité ou sa couleur.

En exploitant les caractéristiques matricielles de l'image, nous effectuons des opérations comme la rotation ou le filtrage. Par exemple, une rotation de 90 degrés s'obtient en transposant la matrice. Pour filtrer, il suffit de multiplier la matrice de l'image par un masque, aussi appelé noyau, contenant des coefficients définissant l'effet recherché, tels qu'une amélioration de la netteté ou une détection de contours.

Nos réseaux neuronaux nécessitent des vecteurs en entrée et en sortie - des matrices en une dimension. Cette configuration simplifie les calculs et garantit la compatibilité entre les couches du réseau. Pour transformer notre image en un tel vecteur, nous la redimensionnons en fonction de la taille attendue par le réseau, ensuite nous l’aplatissons en une ligne ou une colonne, et enfin, nous la normalisons, pour que ses valeurs soient allant de 0 à 1. Ces étapes permettent de réduire le nombre de paramètres à prendre en compte et d'améliorer ainsi l'efficacité de notre réseau.

Représenter les images en tant que matrice, opérer sur elles grâce à ces caractéristiques matricielles et les transformer en vecteurs pour les intégrer à notre réseau neuronal, sont des étapes cruciales dans l'exploitation du Deep Learning pour la détection de nodules pulmonaires avec l'ensemble de données Luna16.

== Conclusion.
Après avoir exploré les principes fondamentaux du deep learning, la façon dont les réseaux neuronaux artificiels fonctionnent et le rôle des matrices dans cet apprentissage profond, nous avons pu comprendre l'importance de transformer les données d'images en vecteurs pour leur analyse par les réseaux de neurones. Ce processus s'avère d'une grande importance pour la détection des nodules pulmonaires sur l'ensemble de données Luna16.

Nous avons discuté en profondeur du fonctionnement des réseaux de neuronaux artificiels, moteurs du Deep Learning, capables d'extraire et d'interpréter des motifs complexes dans les données. Les matrices jouent un rôle central, stockant et mettant à jour les paramètres dans les réseaux neuronaux.

Le processus de transformation des images en vecteurs, pour leur analyse par les réseaux neuronaux, a également été souligné. Cette transformation facilite l'intégration des images dans le réseau et optimise son efficacité.

En plus de cela, nous avons également utilisé un autre modèle pour classer les nodules comme probablement normaux ou anormaux. Ce modèle a également été confronté à des défis similaires en termes de diversité des nodules et de distribution inégale dans l'ensemble de données.

En résumé, le Deep Learning, grâce à sa capacité à traiter et analyser des images et sa grande adaptabilité, s'impose comme un outil essentiel dans la détection des nodules pulmonaires. L'utilisation de l'ensemble de données _LIDC-IDRI_ présente un potentiel énorme pour améliorer la précision et la rapidité des diagnostics, contribuant de manière significative à la lutte contre le cancer du poumon. #finchapiter
