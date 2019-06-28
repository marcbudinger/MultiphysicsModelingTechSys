---
title: Chapitre 4. Exercices
description: 
---
# Chapitre 4 : Simulation numérique de systèmes multi-physiques

  
 
 
## 5.1. Révision des différentes méthodes de modélisation

### 5.1.1. Le domaine électrique

#### 1)	Modéliser le système en utilisant le formalisme bond graph : 

<img src="../img/chap4_correction_5.1.1.1.png" alt="chap4_correction_5.1.1.1.png" width="25%">


#### 2) Déterminer le modèle schéma blocs du circuit : 

<img src="../img/chap4_correction_5.1.1.2.png" alt="chap4_correction_5.1.1.2.png" width="80%">

<img src="../img/chap4_correction_5.1.1.2_2.png" alt="chap4_correction_5.1.1.2_2.png" width="40%">


#### 3) Obtenir la représentation d’état du système : 


\begin{gather}
\begin{bmatrix} \dot U_C \\\\ \dot I_L \end{bmatrix} = 
\begin{bmatrix} -R_2^{-1}.C^{-1} & C^{-1}\\\\ L^{-1} & R.L^{-1} \end{bmatrix}
\begin{bmatrix} U_C \\\\ I_L \end{bmatrix} + 
\begin{bmatrix} 0 \\\\ -L^{-1} \end{bmatrix}.\Delta V
\end{gather}


### 5.1.2. Le domaine mécanique

Non corrigé.

## 5.2. Études de causalité et modifications associées

### 5.2.1. Deux condensateurs en parallèle

#### 1) Modéliser, en utilisant le formalisme bond graph, le système à l’étude – en ne considérant que l’effet capacitif des condensateurs.

<img src="../img/chap4_correction_5.2.1.1.png" alt="chap4_correction_5.2.1.1.png" width="30%">

#### 2) Attribuer les causalités du système modélisé. Est-il possible d’obtenir la causalité intégrale pour les deux condensateurs ?

Non c'est impossible. 

<img src="../img/chap4_correction_5.2.1.2.png" alt="chap4_correction_5.2.1.2.png" width="30%">


#### 3) Dans la pratique, un condensateur possède des résistance et inductance internes. Ces éléments sont à modéliser tous deux en série de l’effet capacitif. Mettre à jour le modèle bond graph en considérant ces phénomènes physiques et conclure sur le sens physique de cette modélisation en attribuant les causalités.

<img src="../img/chap4_correction_5.2.1.3.png" alt="chap4_correction_5.2.1.3.png" width="30%">

L'ajout de ces effets/phénomènes physiques permet l'obtention des causalités intégrales du modèle.

### 5.2.2. Les inerties de système de propulsion d’un sous-marin

#### 1) En considérant le moteur électrique comme une source de vitesse idéale, proposer une modélisation bond graph incluant les phénomènes physiques suivants : frottements du roulement et du joint d’étanchéité et les inerties de l’arbre et de l’hélice.

<img src="../img/chap4_correction_5.2.2.1.png" alt="chap4_correction_5.2.2.1.png" width="30%">


#### 2)  Attribuer les causalités au modèle bond graph et implémenter le modèle schéma bloc associé.

<img src="../img/chap4_correction_5.2.2.2.png" alt="chap4_correction_5.2.2.2.png" width="30%">

<img src="../img/chap4_correction_5.2.2.2_2.png" alt="chap4_correction_5.2.2.2_2.png" width="70%">

#### 4) Introduire la raideur de l’arbre, détaillée dans le tableau 3.8, entre les inerties et le moteur électrique. Combien d’inerties sont en causalité dérivée ?


<img src="../img/chap4_correction_5.2.2.4.png" alt="chap4_correction_5.2.2.4.png" width="30%">

Il reste une inertie en causalité dérivée.

#### 5) Remplacer les deux inerties par une unique inertie équivalente. Déterminer le schéma bloc du système modélisé. Conclure sur les causalités préférentielles du modèle.

<img src="../img/chap4_correction_5.2.2.5.png" alt="chap4_correction_5.2.2.5.png">

#### 6)	Proposer une autre méthode permettant l’élimination des causalités dérivées.

Il serait, par exemple, possible de considérer une raideur entre l'arbre et l'hélice.

### 5.2.3. Contrainte de causalité : le frottement sec

#### 1) Appliquer la causalité flux à l’élément R du bond graph 4.19.a et propager les causalités au modèle, en favorisant les causalités préférentielles autant que faire se peut. Discuter le comportement du modèle de friction autour d’une vitesse nulle.

<img src="../img/chap4_correction_5.2.3.2.png" alt="chap4_correction_5.2.3.2.png" width="30%">

L'élément C est en causalité dérivée.

#### 2) Afin d’obtenir une causalité intégrale sur l’élément C, proposer deux nouveaux modèles causaux :

1)  
<img src="../img/chap4_correction_5.2.3.2.png" alt="chap4_correction_5.2.3.2.png"  width="30%" >

2) Si la caractéristique de R est irréversible, il n'est plus nécessaire de l'avoir en causalité flux. On peut donc avoir le modèle suivant :  

<img src="../img/chap4_correction_5.2.3.3.png" alt="chap4_correction_5.2.3.3.png"  width="30%">

## Suite : [Chapitre 4. Problèmes](Chapitre 4. Problemes.ipynb)
