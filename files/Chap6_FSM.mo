within ;
package Chap6_FSM "Fast Steering Mirror"
  model FSM_1DDL "Fast Steering Mirror with 1DDL"

    // Blades
    parameter Modelica.SIunits.Length b=10e-3 "Width of blade";
    parameter Modelica.SIunits.Length h=0.4e-3
                                            "Thickness of blade";
    parameter Modelica.SIunits.Length L=26e-3 "Length of blade";
    parameter Modelica.SIunits.Pressure E=210e9 "Young Modulus";
    parameter Modelica.SIunits.Pressure G=80e9 "Coulomb Modulus";
    parameter Modelica.SIunits.Length d_bm=4e-3 "rotation axiss / blade anchorage distance";
    // Mirror

    parameter Modelica.SIunits.Mass m=18e-3 "Mirror mass";
    parameter Modelica.SIunits.Length r=25.4e-3 "Mirror radius";

   // Voice coil actuators
   parameter Modelica.SIunits.Mass Mcoil=13.9e-3 "Coil mass";
   parameter Modelica.SIunits.Resistance R = 11 "Coil resistance";
   parameter Modelica.SIunits.Inductance Lcoil=2.7e-3 "Inductance";
   parameter Modelica.SIunits.ElectricalForceConstant kcoil=5.6
      "Transformation coefficient";
   parameter Modelica.SIunits.Length dcoil=18e-3 "rotation axeis / actuator anchorage distance";

   // resonance
   parameter Real Qm=100 "Resonance factor";

    Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=1/
          dcoil)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={30,14})));
    Modelica.Mechanics.Translational.Components.Mass mass(m=Mcoil)
      annotation (Placement(transformation(extent={{-8,14},{12,34}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=R)
      annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=Lcoil)
      annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
    Modelica.Electrical.Analog.Basic.TranslationalEMF emf(k=kcoil)
      annotation (Placement(transformation(extent={{-34,14},{-14,34}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-10,-4})));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R=R)
      annotation (Placement(transformation(extent={{-64,-62},{-44,-42}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L=Lcoil)
      annotation (Placement(transformation(extent={{-44,-62},{-24,-42}})));
    Modelica.Electrical.Analog.Basic.TranslationalEMF emf1(k=kcoil)
      annotation (Placement(transformation(extent={{-34,-44},{-14,-24}})));
    Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T1(ratio=-1/
          dcoil)
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={30,-24})));
    Modelica.Mechanics.Translational.Components.Mass mass1(m=Mcoil)
      annotation (Placement(transformation(extent={{-8,-44},{12,-24}})));

    Modelica.Mechanics.Rotational.Components.Inertia inertiaMirror(J=m*r^2/4)
      annotation (Placement(transformation(extent={{46,-16},{66,4}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(
                                d=sqrt(springDamper.c*inertiaMirror.J)/Qm, c=2*(E*b
          *h^3/L^3*d_bm^2 + G*h^3*b/3/L))
      annotation (Placement(transformation(extent={{70,-16},{90,4}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={94,-6})));
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-92,-14})));
    Modelica.Electrical.Analog.Basic.Ground ground1
                                                   annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-92,-42})));
    Modelica.Blocks.Sources.Step step(height=10, startTime=0.01)
      annotation (Placement(transformation(extent={{-130,-24},{-110,-4}})));
  equation
    connect(resistor.n, inductor.p)
      annotation (Line(points={{-44,40},{-44,40}}, color={0,0,255}));
    connect(emf.p, inductor.n)
      annotation (Line(points={{-24,34},{-24,40}}, color={0,0,255}));
    connect(emf.flange, mass.flange_a)
      annotation (Line(points={{-14,24},{-8,24}}, color={0,127,0}));
    connect(mass.flange_b, idealGearR2T.flangeT)
      annotation (Line(points={{12,24},{30,24}}, color={0,127,0}));
    connect(emf.n, ground.p)
      annotation (Line(points={{-24,14},{-24,-4},{-20,-4}}, color={0,0,255}));
    connect(resistor1.n, inductor1.p)
      annotation (Line(points={{-44,-52},{-44,-52}}, color={0,0,255}));
    connect(emf1.p, ground.p)
      annotation (Line(points={{-24,-24},{-24,-4},{-20,-4}}, color={0,0,255}));
    connect(inductor1.n, emf1.n)
      annotation (Line(points={{-24,-52},{-24,-44}}, color={0,0,255}));
    connect(mass1.flange_b, idealGearR2T1.flangeT)
      annotation (Line(points={{12,-34},{30,-34}}, color={0,127,0}));
    connect(mass1.flange_a, emf1.flange)
      annotation (Line(points={{-8,-34},{-14,-34}}, color={0,127,0}));
    connect(idealGearR2T1.flangeR, idealGearR2T.flangeR)
      annotation (Line(points={{30,-14},{30,4}}, color={0,0,0}));
    connect(inertiaMirror.flange_a, idealGearR2T.flangeR)
      annotation (Line(points={{46,-6},{30,-6},{30,4}}, color={0,0,0}));
    connect(inertiaMirror.flange_b, springDamper.flange_a)
      annotation (Line(points={{66,-6},{70,-6}}, color={0,0,0}));
    connect(springDamper.flange_b, fixed.flange)
      annotation (Line(points={{90,-6},{94,-6}}, color={0,0,0}));
    connect(signalVoltage.p, resistor.p)
      annotation (Line(points={{-92,-4},{-66,-4},{-66,40},{-64,40}},
                                                           color={0,0,255}));
    connect(resistor1.p, signalVoltage.p) annotation (Line(points={{-64,-52},{-66,
            -52},{-66,-4},{-92,-4}},
                                   color={0,0,255}));
    connect(signalVoltage.n, ground1.p)
      annotation (Line(points={{-92,-24},{-92,-32}}, color={0,0,255}));
    connect(signalVoltage.v, step.y)
      annotation (Line(points={{-99,-14},{-109,-14}},
                                                    color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
              {120,100}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{120,100}})));
  end FSM_1DDL;

  model FSM_2DDL "Fast Steering Mirror with 2DDL"

    // Blades
    parameter Modelica.SIunits.Length b=10e-3 "Width of blade";
    parameter Modelica.SIunits.Length h=0.4e-3
                                            "Thickness of blade";
    parameter Modelica.SIunits.Length L=26e-3 "Length of blade";
    parameter Modelica.SIunits.Length d_bm=4e-3 "rotation axiss / blade anchorage distance";
    parameter Modelica.SIunits.Pressure E=210e9 "Young Modulus";
    parameter Modelica.SIunits.Pressure G=80e9 "Coulomb Modulus";

    // Flexible beam
    parameter Modelica.SIunits.Length  d_fb=0.5e-3 "Flexible beam diameter";
    parameter Modelica.SIunits.Length  L_fb=0.5e-3 "Flexible beam length";

    // Mirror
    parameter Modelica.SIunits.Length d=18e-3 "rotation axeis / actuoator anchorage distance";
    parameter Modelica.SIunits.Mass m=18e-3 "Mirror mass";
    parameter Modelica.SIunits.Length r=25.4e-3 "Mirror radius";

   // Voice coil actuators
   parameter Modelica.SIunits.Mass Mcoil=13.9e-3 "Coil mass";
   parameter Modelica.SIunits.Resistance R = 11 "Coil resistance";
   parameter Modelica.SIunits.Inductance Lcoil=2.7e-3 "Inductance";
   parameter Modelica.SIunits.ElectricalForceConstant kcoil=5.6
      "Transformation coefficient";

   // resonance
   parameter Real Qm=100 "Resonance factor";

    Modelica.Mechanics.Translational.Components.Mass mass(m=Mcoil)
      annotation (Placement(transformation(extent={{-8,14},{12,34}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=R)
      annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=Lcoil)
      annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
    Modelica.Electrical.Analog.Basic.TranslationalEMF emf(k=kcoil)
      annotation (Placement(transformation(extent={{-34,14},{-14,34}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-38,-4})));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R=R)
      annotation (Placement(transformation(extent={{-64,-62},{-44,-42}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L=Lcoil)
      annotation (Placement(transformation(extent={{-44,-62},{-24,-42}})));
    Modelica.Electrical.Analog.Basic.TranslationalEMF emf1(k=kcoil*0.9)
      annotation (Placement(transformation(extent={{-34,-44},{-14,-24}})));
    Modelica.Mechanics.Translational.Components.Mass mass1(m=Mcoil)
      annotation (Placement(transformation(extent={{-8,-44},{12,-24}})));

    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(d=sqrt(
          springDamper.c*mirror_2DDL.J)/Qm, c=2*(E*b*h^3/L^3*d_bm^2 + G*h^3*b/3/L))
      annotation (Placement(transformation(extent={{70,-14},{90,6}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={94,-6})));
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-92,-14})));
    Modelica.Electrical.Analog.Basic.Ground ground1
                                                   annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-92,-42})));
    Modelica.Blocks.Sources.Step step(height=10, startTime=0.01)
      annotation (Placement(transformation(extent={{-130,-24},{-110,-4}})));
    Mirror_2DDL mirror_2DDL
      annotation (Placement(transformation(extent={{24,-14},{44,6}})));
    Modelica.Mechanics.Translational.Components.Fixed fixed1
      annotation (Placement(transformation(extent={{-18,-14},{2,6}})));
    Modelica.Mechanics.Translational.Components.SpringDamper spring_flexiblebeam(c=E*3.14*
          (d_fb/2)^2/L_fb, d=sqrt(spring_flexiblebeam.c*mirror_2DDL.m)/Qm)
      annotation (Placement(transformation(extent={{-2,-14},{18,6}})));
  equation
    connect(resistor.n, inductor.p)
      annotation (Line(points={{-44,40},{-44,40}}, color={0,0,255}));
    connect(emf.p, inductor.n)
      annotation (Line(points={{-24,34},{-24,40}}, color={0,0,255}));
    connect(emf.flange, mass.flange_a)
      annotation (Line(points={{-14,24},{-8,24}}, color={0,127,0}));
    connect(emf.n, ground.p)
      annotation (Line(points={{-24,14},{-24,-4},{-28,-4}}, color={0,0,255}));
    connect(resistor1.n, inductor1.p)
      annotation (Line(points={{-44,-52},{-44,-52}}, color={0,0,255}));
    connect(emf1.p, ground.p)
      annotation (Line(points={{-24,-24},{-24,-4},{-28,-4}}, color={0,0,255}));
    connect(inductor1.n, emf1.n)
      annotation (Line(points={{-24,-52},{-24,-44}}, color={0,0,255}));
    connect(mass1.flange_a, emf1.flange)
      annotation (Line(points={{-8,-34},{-14,-34}}, color={0,127,0}));
    connect(springDamper.flange_b, fixed.flange)
      annotation (Line(points={{90,-4},{92,-4},{92,-6},{94,-6}},
                                                 color={0,0,0}));
    connect(signalVoltage.p, resistor.p)
      annotation (Line(points={{-92,-4},{-66,-4},{-66,40},{-64,40}},
                                                           color={0,0,255}));
    connect(resistor1.p, signalVoltage.p) annotation (Line(points={{-64,-52},{-66,
            -52},{-66,-4},{-92,-4}},
                                   color={0,0,255}));
    connect(signalVoltage.n, ground1.p)
      annotation (Line(points={{-92,-24},{-92,-32}}, color={0,0,255}));
    connect(signalVoltage.v, step.y)
      annotation (Line(points={{-99,-14},{-109,-14}},
                                                    color={0,0,127}));
    connect(mirror_2DDL.flange_T_b1, mass.flange_b)
      annotation (Line(points={{24,2},{24,24},{12,24}}, color={0,127,0}));
    connect(mirror_2DDL.flange_T_b2, mass1.flange_b)
      annotation (Line(points={{24,-10},{24,-34},{12,-34}}, color={0,127,0}));
    connect(springDamper.flange_a, mirror_2DDL.flange_R)
      annotation (Line(points={{70,-4},{44,-4}}, color={0,0,0}));
    connect(spring_flexiblebeam.flange_b, mirror_2DDL.flange_T_c)
      annotation (Line(points={{18,-4},{24,-4}}, color={0,127,0}));
    connect(spring_flexiblebeam.flange_a, fixed1.flange)
      annotation (Line(points={{-2,-4},{-8,-4}}, color={0,127,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
              {120,100}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{120,100}})));
  end FSM_2DDL;

  model Mirror_2DDL

      // Mirror
    parameter Modelica.SIunits.Length d=18e-3 "rotation axis / actuoator anchorage distance";
    parameter Modelica.SIunits.Mass m=18e-3 "Mirror mass";
    parameter Modelica.SIunits.Length r=25.4e-3 "Mirror radius";
    parameter Modelica.SIunits.Inertia J=m*r^2/4 "Rotational mirror inertia";

    // z
    Modelica.SIunits.Position s "Absolute postion of component";
    Modelica.SIunits.Velocity v "Absolute velocity of component";
    Modelica.SIunits.Acceleration a "Absolute acceleration of component";

    // theta
    Modelica.SIunits.Angle phi "Absolute postion of component";
    Modelica.SIunits.AngularVelocity w "Absolute velocity of component";
    Modelica.SIunits.AngularAcceleration dw "Absolute acceleration of component";

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_R
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_T_b1
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_T_b2
      annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_T_c
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-40,100},{40,-100}},
            lineColor={102,44,145},
            fillColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Line(points={{-90,60},{-40,60},{-40,58},{-40,60}}, color={102,44,145}),
          Line(points={{-90,0},{-40,0}}, color={102,44,145}),
          Line(points={{-90,-60},{-40,-60}}, color={102,44,145}),
          Line(points={{40,0},{90,0}}, color={102,44,145})}), Diagram(
          coordinateSystem(preserveAspectRatio=false)));

  equation

    // positions definitions

    flange_T_c.s =  s;
    flange_T_b1.s =  s + d*phi;
    flange_T_b2.s =  s - d*phi;
    flange_R.phi=phi;

    // speeds and accelerations definitions
    v = der(s);
    a = der(v);

    w = der(phi);
    dw = der(w);

    // Dynamics

    m*a = flange_T_b1.f + flange_T_c.f + flange_T_b2.f;
    J*dw = (flange_T_b1.f - flange_T_b2.f)*d + flange_R.tau;

  end Mirror_2DDL;
  annotation (uses(Modelica(version="3.2.2")));
end Chap6_FSM;
