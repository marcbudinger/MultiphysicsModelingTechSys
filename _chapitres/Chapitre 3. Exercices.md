---
title: Chapitre 3. Exercices
description: 
---
# Chapitre 3 : Obtention des paramètres par approches énergétiques   
  
 
 
## 7.1.	Théorème des travaux virtuels : mécanisme à ciseaux


#### 1)	Donnez l’expression des longueurs $x=AB$ et $y=BJ$ en fonction de $\alpha$ et de $L$. 

$x = 2L.cos(\alpha)$    
$y = 4L.sin(\alpha)$     

#### 2)	En appliquant le théorème des travaux virtuels pour la configuration $AB$, établissez l’expression de l’effort $F_{AB}$ nécessaire pour soulever la plateforme en fonction de $\alpha$.
\begin{align} 
F_{AB}.v - C.\omega&=0 \\\\\
F_{AB}.dx-C.d\alpha&=0 \\\\\
F_{AB}&=\dfrac{C}{\frac{dx}{d\alpha}} \\\\\
F_{AB} &=-\dfrac{C}{2L.sin(\alpha)} \\\\\
\end{align} 

#### 3)	Procédez de même pour la configuration BH. 
\begin{align} 
F_{BH}.v - C.\omega&=0 \\\\\
F_{BH}.dy-C.d\alpha&=0 \\\\\
F_{BH}&=\dfrac{C}{\frac{dy}{d\alpha}} \\\\\
F_{BH} &=\dfrac{C}{4L.cos(\alpha)} \\\\\
\end{align} 


#### 4) Proposez un code Modelica pour ces deux configurations de mécanisme.



#### 5) La Figure 25 représente les résultats de simulation pour ces deux configurations avec une même charge de 200 kg. Qu’en concluez-vous ?

On remarque que l'efforts des actionneurs pour la configuration BH sont bien moins important que pour la configuration AB. Il est donc recommandé d'utiliser la configuration BH afin de minimiser les efforts sur les actionneurs.
 
 
 
## 7.2.	Energies et co-énergies : frein électromagnétique à manque de courant

#### 1) Donnez la valeur de la résistance R du bobinage.

$R = \rho\dfrac{L}{S} = 1,7e^{-8}\dfrac{350}{3,14.(\frac{0,23e^{-3}}{2})^2} \approx 143 \,\Omega$

#### 2)	Déterminez les équivalents des zones ABCDEF de la Figure 28a sur la Figure 28b. 

A : f   
B : a    
C : b    
D : c     
E : d    
F : e     

#### 3)	Quel est le composant représentant l’effet du bobinage sur le schéma Figure 28b ? Donnez  les expressions des principales équations de ce composant.

L'effet du bobinage est modélisé par le transformateur electro-magnétique (encadré bleu/orange).
#### 4)	Donnez la forme de l’expression des reluctances b et f de la Figure 28b.

#### 5)	Donnez la forme de l’expression des reluctances a et d de la Figure 28b.

#### 6)	Par un bilan d’énergie sur un actionneur de type électro-aimant, démontrez que l’effort électromagnétique peut se calculer par l’expression donnée.


## 7.3.	Equations de Lagrange : accéléromètre MEMS

#### 1)	Localisez les éléments $k$, $f$, $m$, $C_1$ et $C_2$ de la Figure 31 sur le schéma de la Figure 30. 

![Correction 7.3.1](pictures/chap3_correction_7.3.1.png)

#### 2)	Appliquez le principe fondamentale de la dynamique sur la masse $m$. Ecrivez l’équation différentielle à l’aide des variables  $x_b$ et $x$ ($x = x_m - x_b$) où $x_b$ représente la position du boitier du capteur et $x_m$ la position de la masse sismique.
Sur $\vec{u_x}$ : $\sum F_{x} = -k.(x_m − x_b) - f. (\dot x_m − \dot x_b) = − k.x - f.\dot x$     

D'après le PFD : 
\begin{align} 
\sum F_{x} &= m.\ddot x_m \\\\\
− k.x - f.\dot x  &= m(\ddot x + \ddot x_b) \\\\\
m.\ddot x + f.\dot x + k.x &= -m.\ddot x_b
\end{align}

#### 3) 	Retrouvez l’équation précédente à l’aide des équations de Lagrange.

#### 4)	Liez, en régime stabilisé, l’accélération du boitier $a_b=\dfrac{d^2x_b}{dt^2}$ avec la mesure $x$. Donnez le coefficient de proportionnalité entre ces deux grandeurs.

#### 5)	Démontrez que la densité d’énergie volumique est  $\dfrac{1}{2}\sigma\epsilon$.

#### 6) Démontrez que pour une déformation en flexion, comme illustrée Figure 33, l’énergie potentielle  élastique peut se calculer à l’aide de la relation donnée.

#### 7)	Proposez une fonction d’approximation par un polynôme d’ordre 3 de la déformation d’un bras (Longueur $L$, hauteur $h$, largeur $b$) des ressorts en $U$ des suspensions (cf. Figure 28). Le déplacement de la masse sismique par rapport à son support sera noté ici $U_0$.

#### 8)	Montrez comment inclure l’expression de l’énergie volumique de déformation élastique dans le potentiel du Lagrangien. 


#### 9)	Dérivez l’équation de Lagrange et donnez l’expression de la raideur $K$. Réalisez l’application numérique pour $L=120\, µm$, $h=2\,µm$,$b=2,5\,µm$.






## Suite : [Chapitre 3. Problèmes](Chapitre 3. Problemes.ipynb)
