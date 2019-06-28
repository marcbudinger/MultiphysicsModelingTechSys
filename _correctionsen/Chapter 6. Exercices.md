---
title: Chapter 6. Exercices
description: 
---
# Chapter 6 : Mechanical and electrochemical power transmissions
  
 
 
## 7.1.	Virtual work theorem: scissor mechanism


#### 1) Give the expression of the lengths $x=AB$ and $y=BJ$ according to $\alpha$ and $L$.

$x = 2L.cos(\alpha)$    
$y = 4L.sin(\alpha)$     

#### 2)	Applying the virtual work theorem for the $AB$ configuration, establish the expression of the $F_{AB}$ effort required to lift the platform as a function of $\alpha$.
\begin{align} 
F_{AB} dx - mg dy&=0 \\\\\
F_{AB}&=mg\frac{dy}{dx} \\\\\
F_{AB} &=-\frac{2mg}{tan(\alpha)} \\\\\
\end{align} 

#### 3)	Do the same for the BH configuration.

$x = BH =L\sqrt{cos(\alpha)^2+9sin(\alpha)^2}=L\sqrt{1+8sin(\alpha)^2}$    
$y = 4L.sin(\alpha)$   

$dx = 8L\frac{sin(\alpha)cos(\alpha)}{\sqrt{1+8sin(\alpha)^2}}d\alpha$    
$dy = 4Lcos(\alpha)d\alpha$   


\begin{align} 
F_{BH}&=mg\frac{dy}{dx} \\\\\
F_{BH} &=mg\dfrac{\sqrt{1+8sin(\alpha)^2}}{2sin(\alpha)} \\\\\
\end{align} 


#### 4) Propose a Modelica code for these two mechanism configurations.

Response file to download here :  [Chap6_ScissorPlatform.mo](../files/Chap6_ScissorPlatform.mo)

#### 5) Figure 25 shows the simulation results for these two configurations with the same load of 200 kg. What do you conclude from this ?

It should be noted that the actuator forces for the BH configuration are much lower than for the AB configuration. It is therefore recommended to use the BH configuration to minimize the forces on the actuators.
 
 
 
## 7.2.	Energy and co-energy: electromagnetic brake with power shortage

#### 1) Give the value of the resistance R of the winding.

$R = \rho\dfrac{L}{S} = 1,7e^{-8}\dfrac{350}{3,14.(\frac{0,23e^{-3}}{2})^2} \approx 143 \,\Omega$

#### 2)	Determine the equivalents of the ABCDEF areas in Figure 28a on Figure 28b.  

A : f   
B : a    
C : b    
D : c     
E : d    
F : e     

You can find the Modelica model here : [Chap6_PowerOffBrake.mo](../files/Chap6_PowerOffBrake.mo) 

#### 3)	What is the component representing the effect of the winding on the diagram Figure 28b? Give the expressions of the main equations of this component.

The winding effect is modelled by the electromagnetic transformer (blue/orange box).
In the Modelica code of this component you will find :   

```
  //converter equations:
  V_m = i*N;
  // Ampere's law
  N*der(Phi) = -v;
  // Faraday's law
```   
which represent a transformer that binds the power variables :
- of the electrical circuit: v (fem) and i (current)
- magnetic circuit: V_m (fmm, magnetomotor force NI) and Phi (flux)  

and representing the equations : $v=-N\frac{d\varphi}{dt}$ et $\oint \frac{B}{\mu}dl=NI$


#### 4)	Give the shape of the expression of the reluctances b and f in Figure 28b.

The equation representing the Ampere theorem $\oint \frac{B}{\mu}dl=NI$ can be represented on the form of a mesh law with fmm drops (Prduct of Reluctance.Flux as in electricity voltage drop product of resistance.current) :    
$\oint \frac{B}{\mu}dl=\varphi \sum R_k = NI$  
where the reluctance is calculated with $R = \int \frac{dl}{\mu S} $  
For the reluctances b and f the section is constant over the length and so we have:
$R = \frac{l}{\mu S} $  

that is found in the Modelica code :
```
  A = pi*(r_o^2 - r_i^2);
  G_m = (mu_0*mu_r*A)/l;
  ```
  
where G_m is the inverse of the magnetic reluctance $G_m = 1/R_m$

#### 5) Shape the expression of reluctances a and d from Figure 28b.

For the reluctances a and d the section is not constant over the length. It is therefore necessary to integrate the previous expression on the radial geometry (of internal radius $r_i$, external radius $r_o$, thickness l) :
$R = \int_{r_i}^{r_o} \frac{dr}{\mu S} = \int_{r_i}^{r_o} \frac{dr}{\mu 2\pi r l} = \frac{ln(r_o/r_i)}{\mu 2\pi l}$  

that is found in the Modelica code : 
```
  A = l*pi*(r_o + r_i);
  // Area at arithmetic mean radius for calculation of average flux density
  G_m = 2*pi*mu_0*mu_r*l/Modelica.Math.log(r_o/r_i);
  ```
  
where G_m is the inverse of the magnetic reluctance $G_m = 1/R_m$

#### 6)	By an energy balance on an electromagnet type actuator, demonstrate that the electromagnetic effort can be calculated by the given expression.

An electro-magnetic actuator consisting as here of a coil and a mechanical moving part:  
- receives electrical energy from the power supply: $dW_{elec} = vidt$    
- stores magnetic energy: $dV_{mag}$
- dissipates Joules losses (which will be neglected for the rest of the demonstration)
- provides mechanical work: $dW_{meca}=Fdx$   

This gives the following energy balance : 

$ dW_{elec} = dV_{mag} + dW_{meca}$  

If we assume the position of the fixed mechanical effector, $dx=0$ and :

$ dV_{mag} = dW_{elec} = vidt = id\varphi$ or $V_{mag}=\int id\varphi=\frac{1}{2}Li^2$


If we assume the flow in the fixed coil, $d\varphi=0$ and :

$ dW_{elec} = id\varphi = 0 = dV_{mag} + dW_{meca}$


so dW_{meca} = -dV_{mag} or $F=-\frac{\partial V_{mag}}{\partial x}$ 

but having a constant flow is difficult to verify in practice.   

By introducing the notion of magnetic coenergy: $V_{mag} + V_{comag} = i\varphi$    

or  $dV_{mag} + dV_{comag} = di\varphi + id\varphi $  


In case of constant current, we then have :

$ dW_{elec} = id\varphi = dV_{mag} + dW_{meca} = di\varphi + id\varphi - dV_{comag} + dW_{meca}$  

or  $0 = \varphi di - dV_{comag} + dW_{meca}$ 

so  $F=\frac{\partial V_{comag}}{\partial x}$     where : $V_{comag}=\int \varphi di=\frac{1}{2}Li^2$    

so :   $F=\frac{1}{2}\frac{\partial L}{\partial x} i^2$   

#### 7)	Show that this expression can be represented directly at the magnetic circuit.

$V_{comag}=\frac{1}{2}Li^2=\frac{1}{2} \varphi i $    

At the level of a reluctance of a magnetic circuit : 
$\frac{1}{2} \varphi i = \frac{1}{2} \varphi^2 R_m = \frac{1}{2} \varphi^2  / G_m = \frac{1}{2} G_m \varepsilon^2  $  
with $G_m$ the opposite of reluctance and $varepsilon$ the fmm. We then have : 

$F=\frac{1}{2}\frac{\partial G_m}{\partial x} \varepsilon^2$   

f we observe the partial model "PartialForce" of the MSL (Magnetic/FluxTube/Interfaces), we find these equations :
~~~
  V_m = Phi*R_m;
  R_m = 1/G_m;
  F_m = 0.5*V_m^2*dGmBydx;
~~~
which is finally found in component e of Figure 6.27.


## 7.3.	Lagrange Equations: modeling a gyropod


#### 1)	Calculate the kinetic and potential energy of the system (user, support, reducer, motors, wheels).

The kinetic energy of the system is : 
$E_{c} = \frac{1}{2} M_{eq} \dot{x}^{2} + \frac{1}{2} M_u V_{g}^{2} + \frac{1}{2} J_{G} \dot{\theta}^{2}$

with :  
$M_{eq} = M + 2 \frac{J_r + J_m N^2}{R^2}$  
$V_{eq}^2 = \dot{x}^{2} + 2 L_{G} \dot{\theta} \dot{x} \cos\left(\theta + \beta\right) + L_{G}^{2} \dot{\theta}^{2}$   

The potential energy of the system is :
$E_{p} = M_{u} g L_{G} \cos\left(\theta + \beta\right)$

#### 2)	Define the Lagrangian of the system and calculate the two mechanical equations

A Lagrangian is being written :
\begin{equation}
\mathcal{L} = E_{c} - E_{p}
\end{equation}

with : 
* $E_{c}$ kinetic energy 
* $E_{p}$ potential energy 

\begin{equation}
\mathcal{L} = \frac{1}{2} M_{eq} \dot{x}^{2} + \frac{1}{2} M_u \left( \dot{x}^{2} + 2 L_{G} \dot{\theta} \dot{x} \cos\left(\theta + \beta\right) + L_{G}^{2} \dot{\theta}^{2} \right) + \frac{1}{2} J_{G} \dot{\theta}^{2} - M_{u} g L_{G} \cos\left(\theta + \beta\right) 
\end{equation}

The Lagrange equation on the degree of freedom x is defined as :
\begin{equation}
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{x}}\right) - \frac{\partial \mathcal{L}}{\partial x} = F_{ext,x}
\end{equation}

with :
\begin{align}
\frac{\partial \mathcal{L}}{\partial \dot{x}} & = M_{eq} \dot{x} + M_u \dot{x} + M_u L_G \dot{\theta} \cos\left(\theta\right) + M_{u} L_{G} \dot{\theta} \cos \left(\theta + \beta\right) \\
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{x}}\right) & = M_{eq} \ddot{x} + M_u \ddot{x} + M_u L_G \ddot{\theta} \cos\left(\theta +\beta\right) - M_{u} l_{G} \dot{\theta}^{2} \sin\left(\theta + \beta\right) \\
\frac{\partial \mathcal{L}}{\partial x} & = 0 \\
\end{align}

So :  
\begin{align}
\left(M_{eq}+M_{u}\right) \ddot{x} +  M_{u} L_{G} \cos\left(\theta + \beta \right) \ddot{\theta} - M_{u} L_{G} \sin\left(\theta + \beta\right) \dot{\theta}^{2} = F_{ext,x} 
\end{align}

The Lagrange equation according to $\theta$ gives :
\begin{equation}
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{\theta}}\right) - \frac{\partial \mathcal{L}}{\partial \theta} = F_{ext,\theta}
\end{equation}

With :
\begin{align}
\frac{\partial \mathcal{L}}{\partial \dot{\theta}} & = M_u L_G \dot{x} \cos\left(\theta + \beta\right) + M_u L_G^{2} \dot{\theta} + J_{G} \dot{\theta} \\
\frac{d}{dt} \left(\frac{\partial \mathcal{L}}{\partial \dot{\theta}}\right) & = M_u L_G \ddot{x} \cos\left(\theta + \beta\right) - M_u L_G \dot{x} \dot{\theta} \sin \left(\theta + \beta\right) + M_u L_G^{2} \ddot{\theta} + J_{G} \ddot{\theta} \\
\frac{\partial \mathcal{L}}{\partial \theta} & = - M_u L_G \dot{\theta} \dot{x} \sin\left(\theta +\beta\right) + M_u g L_G \sin \left(\theta + \beta\right) \\
F_{ext,\theta} & = 0
\end{align}

So finally :
\begin{align}
\left(J_{G} + M_{u} L_{G}^{2}\right) \ddot{\theta} + M_{u} L_{G} \cos\left(\theta + \beta\right) \ddot{x} & = M_{G} L_{G} g \sin\left(\theta + \beta\right) \\
\end{align}


#### 3) Complete all the mechanical equations with external forces

The external actions are (with $C_m$ the motor torque) :
\begin{align}
F_{ext,z} & = F_{m} - F_{rr} - F_{aero} 
F_{m} & = \frac{2 C_{m}}{R} \\
F_{rr} & = \left(M_{u}+M\right) g C_{rr} \\
F_{aero} & = \frac{1}{2} \rho C_{d} S \dot{x}^{2} \\
\end{align}

Here you will find a Modelica file with the implementation and use of these equations : [Chap6_Segway.mo](../files/Chap6_Segway.mo) 







## Next : [Chapter 6. Problemes](Chapter 6. Problemes.ipynb)
