---
title: Chapitre 6. Exercices
description: 
---
# Chapitre 6 : Transmissions de puissances électromécaniques   
  
 
 
## 7.1.	Théorème des travaux virtuels : mécanisme à ciseaux


#### 1)	Donnez l’expression des longueurs $x=AB$ et $y=BJ$ en fonction de $\alpha$ et de $L$. 

$x = 2L.cos(\alpha)$    
$y = 4L.sin(\alpha)$     

#### 2)	En appliquant le théorème des travaux virtuels pour la configuration $AB$, établissez l’expression de l’effort $F_{AB}$ nécessaire pour soulever la plateforme en fonction de $\alpha$.
\begin{align} 
F_{AB} dx - mg dy&=0 \\\\\
F_{AB}&=mg\frac{dy}{dx} \\\\\
F_{AB} &=-\frac{2mg}{tan(\alpha)} \\\\\
\end{align} 

#### 3)	Procédez de même pour la configuration BH. 

$x = BH =L\sqrt{cos(\alpha)^2+9sin(\alpha)^2}=L\sqrt{1+8sin(\alpha)^2}$    
$y = 4L.sin(\alpha)$   

$dx = 8L\frac{sin(\alpha)cos(\alpha)}{\sqrt{1+8sin(\alpha)^2}}d\alpha$    
$dy = 4Lcos(\alpha)d\alpha$   


\begin{align} 
F_{BH}&=mg\frac{dy}{dx} \\\\\
F_{BH} &=mg\dfrac{\sqrt{1+8sin(\alpha)^2}}{2sin(\alpha)} \\\\\
\end{align} 


#### 4) Proposez un code Modelica pour ces deux configurations de mécanisme.

Fichier réponse à télecharger ici :  [Chap6_ScissorPlatform.mo](../files/Chap6_ScissorPlatform.mo)

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

Vous pouvez retrouver le modèle Modelica ici : [Chap6_PowerOffBrake.mo](../files/Chap6_PowerOffBrake.mo) 

#### 3)	Quel est le composant représentant l’effet du bobinage sur le schéma Figure 28b ? Donnez  les expressions des principales équations de ce composant.

L'effet du bobinage est modélisé par le transformateur electro-magnétique (encadré bleu/orange).
Dans le code Modelica de ce composant vous trouvez :    
```
  //converter equations:
  V_m = i*N;
  // Ampere's law
  N*der(Phi) = -v;
  // Faraday's law
```   
qui représentent un transformateur lian les variables de puissance :
- du circuit électrique : v (fem) et i (courant)
- circuit magnétique : V_m (fmm, force magnétomotrice NI) et Phi (flux)  

et représentant les équations: $v=-N\frac{d\varphi}{dt}$ et $\oint \frac{B}{\mu}dl=NI$


#### 4)	Donnez la forme de l’expression des reluctances b et f de la Figure 28b.

L'équation représentant le théorème d'Ampère $\oint \frac{B}{\mu}dl=NI$ peut se représenter sur la forme d'une loi des mailles avec des chutes de fmm (produit de Reluctance.Flux comme en électricité chute de tension produit de résistance.courant) :    
$\oint \frac{B}{\mu}dl=\varphi \sum R_k = NI$  
où les reluctuances se calculent avec $R = \int \frac{dl}{\mu S} $  
Pour les reluctances b et f la section est constante sur la longueur et on a donc :
$R = \frac{l}{\mu S} $  

que l'on trouve dans le code Modelica :
```
  A = pi*(r_o^2 - r_i^2);
  G_m = (mu_0*mu_r*A)/l;
  ```
  
où G_m est l'inverse de la reluctance magnétique $G_m = 1/R_m$

#### 5)	Donnez la forme de l’expression des reluctances a et d de la Figure 28b.

Pour les reluctances a et d la section n'est pas constante sur la longueur. Il faut donc intégrer l'expression précédente sur la géométrie radiale (de rayon interne $r_i$, rayon externe $r_o$, d'épaisseur l)  :
$R = \int_{r_i}^{r_o} \frac{dr}{\mu S} = \int_{r_i}^{r_o} \frac{dr}{\mu 2\pi r l} = \frac{ln(r_o/r_i)}{\mu 2\pi l}$  

que l'on trouve dans le code Modelica :
```
  A = l*pi*(r_o + r_i);
  // Area at arithmetic mean radius for calculation of average flux density
  G_m = 2*pi*mu_0*mu_r*l/Modelica.Math.log(r_o/r_i);
  ```
  
où G_m est l'inverse de la reluctance magnétique $G_m = 1/R_m$

#### 6)	Par un bilan d’énergie sur un actionneur de type électro-aimant, démontrez que l’effort électromagnétique peut se calculer par l’expression donnée.

Un actionneur électromégnétique constitué comme ici d'une bobine et d'une partie mobile mécanique :  
- récoit de l'énergie électrique depuis l'alimentation : $dW_{elec} = vidt$    
- stocke de l'énergie magnétique : $dV_{mag}$    
- dissipe des pertes Joules  (que l'on va négliger pour la suite de la démonstration)
- fournit un travail mécanique : $dW_{meca}=Fdx$   

Ce qui donne le bilan d'énergie suivant : 

$ dW_{elec} = dV_{mag} + dW_{meca}$  

Si on suppose la position de l'effecteur mécanique fixe, $dx=0$ et :

$ dV_{mag} = dW_{elec} = vidt = id\varphi$ soit $V_{mag}=\int id\varphi=\frac{1}{2}Li^2$


Si on suppose la flux dans la bobine fixe, $d\varphi=0$ et :

$ dW_{elec} = id\varphi = 0 = dV_{mag} + dW_{meca}$


d'où dW_{meca} = -dV_{mag} soit $F=-\frac{\partial V_{mag}}{\partial x}$ 

mais avoir un flux constant est difficile a vérifier en pratique.   

En introduisant la notion de coénergie magnétique : $V_{mag} + V_{comag} = i\varphi$  

soit  $dV_{mag} + dV_{comag} = di\varphi + id\varphi $  


On a alors en cas de courant constant :  

$ dW_{elec} = id\varphi = dV_{mag} + dW_{meca} = di\varphi + id\varphi - dV_{comag} + dW_{meca}$  

soit  $0 = \varphi di - dV_{comag} + dW_{meca}$ 

d'où  $F=\frac{\partial V_{comag}}{\partial x}$     où : $V_{comag}=\int \varphi di=\frac{1}{2}Li^2$    

soit :   $F=\frac{1}{2}\frac{\partial L}{\partial x} i^2$   

#### 7)	Montrez que cette expression peut se représenter directement au niveau du circuit magnétique.

$V_{comag}=\frac{1}{2}Li^2=\frac{1}{2} \varphi i $    

Au niveau d'une reluctance d'un circuit magnétique :  
$\frac{1}{2} \varphi i = \frac{1}{2} \varphi^2 R_m = \frac{1}{2} \varphi^2  / G_m = \frac{1}{2} G_m \varepsilon^2  $  
avec $G_m$ l'inverse de la reluctance et $\varepsilon$ la fmm. On a alors

$F=\frac{1}{2}\frac{\partial G_m}{\partial x} \varepsilon^2$   

Si on observe le model partiel 'PartialForce' de la MSL (Magnetic/FluxTube/Interfaces), on retrouve bien ces equations :
~~~
  V_m = Phi*R_m;
  R_m = 1/G_m;
  F_m = 0.5*V_m^2*dGmBydx;
~~~
qui se retrouve finalement dans le composant e de la figure 6.27.


## 7.3.	Equations de Lagrange : modélisation d'un gyropode


#### 1)	Calculez l'énergie cinétique et potentielle du système (tilisateur, support, réducteur, moteurs, roues). 

L'énergie cinétique du système est :  
$E_{c} = \frac{1}{2} M_{eq} \dot{x}^{2} + \frac{1}{2} M_u V_{g}^{2} + \frac{1}{2} J_{G} \dot{\theta}^{2}$

avec :  
$M_{eq} = M + 2 \frac{J_r + J_m N^2}{R^2}$  
$V_{eq}^2 = \dot{x}^{2} + 2 L_{G} \dot{\theta} \dot{x} \cos\left(\theta + \beta\right) + L_{G}^{2} \dot{\theta}^{2}$   

L'énergie potentielle du système est :  
$E_{p} = M_{u} g L_{G} \cos\left(\theta + \beta\right)$

#### 2)	Definissez le Lagrangien du système et calculez les deux equations mécaniques

Un Lagrangien s'écrit:
\begin{equation}
\mathcal{L} = E_{c} - E_{p}
\end{equation}

avec:
* $E_{c}$ l'énergie cinétique  
* $E_{p}$ l'énergie potentielle  

\begin{equation}
\mathcal{L} = \frac{1}{2} M_{eq} \dot{x}^{2} + \frac{1}{2} M_u \left( \dot{x}^{2} + 2 L_{G} \dot{\theta} \dot{x} \cos\left(\theta + \beta\right) + L_{G}^{2} \dot{\theta}^{2} \right) + \frac{1}{2} J_{G} \dot{\theta}^{2} - M_{u} g L_{G} \cos\left(\theta + \beta\right) 
\end{equation}

L'équation de Lagrange sur le degré de liberté x se définit comme :
\begin{equation}
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{x}}\right) - \frac{\partial \mathcal{L}}{\partial x} = F_{ext,x}
\end{equation}

avec:
\begin{align}
\frac{\partial \mathcal{L}}{\partial \dot{x}} & = M_{eq} \dot{x} + M_u \dot{x} + M_u L_G \dot{\theta} \cos\left(\theta\right) + M_{u} L_{G} \dot{\theta} \cos \left(\theta + \beta\right) \\
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{x}}\right) & = M_{eq} \ddot{x} + M_u \ddot{x} + M_u L_G \ddot{\theta} \cos\left(\theta +\beta\right) - M_{u} l_{G} \dot{\theta}^{2} \sin\left(\theta + \beta\right) \\
\frac{\partial \mathcal{L}}{\partial x} & = 0 \\
\end{align}

Soit:  
\begin{align}
\left(M_{eq}+M_{u}\right) \ddot{x} +  M_{u} L_{G} \cos\left(\theta + \beta \right) \ddot{\theta} - M_{u} L_{G} \sin\left(\theta + \beta\right) \dot{\theta}^{2} = F_{ext,x} 
\end{align}

L'équation de Lagrange selon $\theta$ donne:
\begin{equation}
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{\theta}}\right) - \frac{\partial \mathcal{L}}{\partial \theta} = F_{ext,\theta}
\end{equation}

Avec:
\begin{align}
\frac{\partial \mathcal{L}}{\partial \dot{\theta}} & = M_u L_G \dot{x} \cos\left(\theta + \beta\right) + M_u L_G^{2} \dot{\theta} + J_{G} \dot{\theta} \\
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{\theta}}\right) & = M_u L_G \ddot{x} \cos\left(\theta + \beta\right) - M_u L_G \dot{x} \dot{\theta} \sin \left(\theta + \beta\right) + M_u L_G^{2} \ddot{\theta} + J_{G} \ddot{\theta} \\
\frac{\partial \mathcal{L}}{\partial \theta} & = - M_u L_G \dot{\theta} \dot{x} \sin\left(\theta +\beta\right) + M_u g L_G \sin \left(\theta + \beta\right) \\
F_{ext,\theta} & = 0
\end{align}

Soit finalement:
\begin{align}
\left(J_{G} + M_{u} L_{G}^{2}\right) \ddot{\theta} + M_{u} L_{G} \cos\left(\theta + \beta\right) \ddot{x} & = M_{G} L_{G} g \sin\left(\theta + \beta\right) \\
\end{align}


#### 3)	Complétez l'ensemble des équations mécaniques avec les forces externes

Les actions exterieures sont (avec $C_m$ le couple moteur) :
\begin{align}
F_{ext,z} & = F_{m} - F_{rr} - F_{aero} 
F_{m} & = \frac{2 C_{m}}{R} \\
F_{rr} & = \left(M_{u}+M\right) g C_{rr} \\
F_{aero} & = \frac{1}{2} \rho C_{d} S \dot{x}^{2} \\
\end{align}

Vous trouverez ici un fichier Modelica avec l'implémentation et l'utilisation de ces équations:  [Chap6_Segway.mo](../files/Chap6_Segway.mo) 







## Suite : [Chapitre 6. Problèmes](Chapitre 6. Problemes.ipynb)
