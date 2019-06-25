within ;
package Chap6_PiezoActuators "Piezo Actuators example"
  package Components
    model PiezoIdeal

    parameter Chap6_PiezoActuators.Units.ForceFactor N=1 "Facteur d'effort";

      Modelica.SIunits.Voltage v "Voltage drop between the two pins";
      Modelica.SIunits.Current i
        "Current flowing from positive to negative pin";
      Modelica.SIunits.ElectricCharge q "Electric charge";

      Modelica.Electrical.Analog.Interfaces.PositivePin p annotation (Placement(
            transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
                {10,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}}),
                                                      iconTransformation(extent={{-10,
                -110},{10,-90}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (
          Placement(transformation(extent={{90,-10},{110,10}}),
                                                             iconTransformation(
              extent={{90,-10},{110,10}})));

    equation
      v = p.v - n.v;
      0 = p.i + n.i;
      i = p.i;
      i=der(q);

      flange_a.f=-N*v;
      q=N*flange_a.s;

     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                      graphics={
            Rectangle(
              extent={{-90,40},{90,-40}},
              lineColor={0,0,255},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,60},{-40,60},{80,60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-80,-60},{80,-60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{0,100},{0,60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{0,-60},{0,-100}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{-50,24},{56,-20}},
              lineColor={0,0,255},
              textString="PZT")}),   Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                             graphics));
    end PiezoIdeal;

    model PiezoReal

      Modelica.Electrical.Analog.Interfaces.PositivePin p annotation (Placement(
            transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
                {10,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}}),
                                                      iconTransformation(extent={{-10,
                -110},{10,-90}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (
          Placement(transformation(extent={{90,-10},{110,10}}),
                                                             iconTransformation(
              extent={{90,-10},{110,10}})));

      PiezoIdeal piezoIdeal(N=N)
        annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
      Modelica.Electrical.Analog.Basic.Capacitor C0(C=C_0) "Capcité bloquée"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-36,0})));
      Modelica.Mechanics.Translational.Components.Spring Kpzt(c=K_pzt)
        "Raideur équivalente "
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={34,-40})));
      parameter Modelica.SIunits.Capacitance C_0=1e-9 "Capacité bloquée";
      parameter Modelica.SIunits.TranslationalSpringConstant K_pzt=1e9
        "Raideur équivalente";
      parameter Units.ForceFactor N=1 "Facteur d'effort";
      Modelica.Mechanics.Translational.Components.Fixed fixed annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={8,-40})));
    equation
      connect(piezoIdeal.p, C0.p) annotation (Line(
          points={{4,10},{-36,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(piezoIdeal.n, C0.n) annotation (Line(
          points={{4,-10},{-36,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(flange_a, flange_a) annotation (Line(
          points={{100,0},{100,0}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(Kpzt.flange_a, piezoIdeal.flange_a) annotation (Line(
          points={{44,-40},{44,0},{14,0}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(piezoIdeal.flange_a, flange_a) annotation (Line(
          points={{14,0},{100,0}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(fixed.flange, Kpzt.flange_b) annotation (Line(
          points={{8,-40},{24,-40}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(C0.p, p) annotation (Line(
          points={{-36,10},{-36,56},{-36,100},{0,100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(n, C0.n) annotation (Line(
          points={{0,-100},{0,-54},{-36,-54},{-36,-10}},
          color={0,0,255},
          smooth=Smooth.None));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                      graphics={
            Rectangle(
              extent={{-90,40},{90,-40}},
              lineColor={0,0,255},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-80,60},{-40,60},{80,60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-80,-60},{80,-60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{0,100},{0,60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{0,-60},{0,-100}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{-50,24},{56,-20}},
              lineColor={0,0,255},
              textString="PZT"),
            Line(points={{-90,40},{-100,28}},color={0,0,0}),
            Line(points={{-90,22},{-100,10}},color={0,0,0}),
            Line(points={{-90,4},{-100,-8}}, color={0,0,0}),
            Line(points={{-90,-14},{-100,-26}},
                                             color={0,0,0}),
            Line(points={{-90,-32},{-100,-44}},
                                             color={0,0,0})}),
                                     Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                             graphics));
    end PiezoReal;

    model Amplifier "Ampflificateur mécanique"

      extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;

      parameter real ratio = 1
        "Rapport d'amplification (flange_b.s/flange_a.s)";

    equation
      flange_b.s=ratio*flange_a.s;
      flange_b.F=-flange_a.s/ratio;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics={Polygon(
              points={{-40,0},{-80,-60},{0,-60},{-40,0}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid), Line(
              points={{-100,0},{100,0}},
              color={0,0,0},
              smooth=Smooth.None)}));
    end Amplifier;

    model Langevin

      Modelica.Electrical.Analog.Interfaces.PositivePin p annotation (Placement(
            transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
                {10,110}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}}),
                                                      iconTransformation(extent={{-10,
                -110},{10,-90}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation (
          Placement(transformation(extent={{90,-10},{110,10}}),
                                                             iconTransformation(
              extent={{90,-10},{110,10}})));

      PiezoIdeal piezoIdeal(N=N)
        annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
      Modelica.Electrical.Analog.Basic.Capacitor C0(C=C_0) "Capcité bloquée"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-36,0})));
      parameter Modelica.SIunits.Capacitance C_0=1.15e-9 "Capacité bloquée";
      parameter Real Qm=100 "Coefficient de qualité";
      parameter Modelica.SIunits.TranslationalSpringConstant K_modal=0.69e9
        "Raideur modale";
      parameter Modelica.SIunits.Mass M_modal=5.95e-3 "Masse modale";

      parameter Units.ForceFactor N=0.3 "Facteur d'effort";
      Modelica.Mechanics.Translational.Components.Fixed fixed annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={8,-40})));
      Modelica.Mechanics.Translational.Components.Mass ModalM(m=M_modal)
        annotation (Placement(transformation(extent={{48,-50},{68,-30}})));
      Modelica.Mechanics.Translational.Components.SpringDamper ModalK(c=K_modal,
          d=sqrt(K_modal*M_modal)/Qm)
        annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
    equation
      connect(piezoIdeal.p, C0.p) annotation (Line(
          points={{4,10},{-36,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(piezoIdeal.n, C0.n) annotation (Line(
          points={{4,-10},{-36,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(flange_a, flange_a) annotation (Line(
          points={{100,0},{100,0}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(piezoIdeal.flange_a, flange_a) annotation (Line(
          points={{14,0},{100,0}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(C0.p, p) annotation (Line(
          points={{-36,10},{-36,56},{-36,100},{0,100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(n, C0.n) annotation (Line(
          points={{0,-100},{0,-100},{-36,-100},{-36,-98},{-36,-98},{-36,-10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(fixed.flange, ModalK.flange_a) annotation (Line(
          points={{8,-40},{20,-40}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(ModalK.flange_b, ModalM.flange_a) annotation (Line(
          points={{40,-40},{48,-40}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(ModalM.flange_b, flange_a) annotation (Line(
          points={{68,-40},{78,-40},{78,0},{100,0}},
          color={0,127,0},
          smooth=Smooth.None));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                      graphics={
            Rectangle(
              extent={{-32,36},{-2,-40}},
              lineColor={135,135,135},
              fillColor={255,255,170},
              fillPattern=FillPattern.HorizontalCylinder),
            Line(
              points={{-34,-60},{34,-60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{0,100},{0,-40}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{0,-60},{0,-100}},
              color={0,0,255},
              smooth=Smooth.None),
            Rectangle(
              extent={{2,36},{32,-40}},
              lineColor={135,135,135},
              fillColor={255,255,170},
              fillPattern=FillPattern.HorizontalCylinder),
            Line(
              points={{34,38},{34,-60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-34,38},{-34,-60}},
              color={0,0,255},
              smooth=Smooth.None),
            Rectangle(
              extent={{36,36},{90,-40}},
              lineColor={135,135,135},
              fillColor={215,215,215},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-90,36},{-36,-40}},
              lineColor={135,135,135},
              fillColor={215,215,215},
              fillPattern=FillPattern.HorizontalCylinder)}),
                                     Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                             graphics));
    end Langevin;
  end Components;

  package Units
    type ForceFactor =
                  Real (final quantity="Force Factor", final unit="N/V");
  end Units;

  model MultiLayer_Test
    Components.PiezoReal piezoReal
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=100)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,50})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
    Components.PiezoReal piezoReal1
      annotation (Placement(transformation(extent={{50,40},{70,60}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=100)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,50})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{10,10},{30,30}})));
    Components.PiezoReal piezoReal2
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage2(V=100)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-40})));
    Modelica.Electrical.Analog.Basic.Ground ground2
      annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
    Modelica.Mechanics.Translational.Components.Fixed fixed annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={76,50})));
    Modelica.Mechanics.Translational.Components.Spring spring
      annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
    Modelica.Mechanics.Translational.Components.Fixed fixed1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={48,-40})));
  equation
    connect(ground.p, constantVoltage.n) annotation (Line(
        points={{-80,30},{-80,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground1.p, constantVoltage1.n) annotation (Line(
        points={{20,30},{20,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground2.p, constantVoltage2.n) annotation (Line(
        points={{-40,-60},{-40,-50}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(fixed.flange, piezoReal1.flange_a) annotation (Line(
        points={{76,50},{70,50}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(spring.flange_a, piezoReal2.flange_a) annotation (Line(
        points={{20,-40},{10,-40}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(fixed1.flange, spring.flange_b) annotation (Line(
        points={{48,-40},{40,-40}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(constantVoltage.p, piezoReal.p) annotation (Line(
        points={{-80,60},{-40,60}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(piezoReal.n, constantVoltage.n) annotation (Line(
        points={{-40,40},{-80,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(piezoReal1.p, constantVoltage1.p) annotation (Line(
        points={{60,60},{20,60}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(piezoReal1.n, constantVoltage1.n) annotation (Line(
        points={{60,40},{20,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(piezoReal2.p, constantVoltage2.p) annotation (Line(
        points={{0,-30},{-40,-30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(piezoReal2.n, constantVoltage2.n) annotation (Line(
        points={{0,-50},{-40,-50}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end MultiLayer_Test;

  model PiezoAmplifier "Barreau multicouches avec mécanisme d'amplification"
    Components.PiezoReal piezoReal
      annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
    Components.Amplifier amplifier annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={8,20})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=100)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,10})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
    Modelica.Mechanics.Translational.Components.Spring spring
      annotation (Placement(transformation(extent={{18,20},{38,40}})));
    Modelica.Mechanics.Translational.Components.Fixed fixed1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={46,30})));
  equation
    connect(piezoReal.flange_a, amplifier.flange_a) annotation (Line(
        points={{-10,10},{8,10}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(ground.p,constantVoltage. n) annotation (Line(
        points={{-60,-10},{-60,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(constantVoltage.p, piezoReal.p) annotation (Line(
        points={{-60,20},{-20,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(piezoReal.n,constantVoltage. n) annotation (Line(
        points={{-20,0},{-60,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(fixed1.flange,spring. flange_b) annotation (Line(
        points={{46,30},{38,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(spring.flange_a, amplifier.flange_b) annotation (Line(
        points={{18,30},{8,30}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end PiezoAmplifier;

  model PiezoWelding "Barreau multicouches avec mécanisme d'amplification"
    Components.Langevin piezoReal
      annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=54e3, V=
          100) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,10})));
    Modelica.Mechanics.Translational.Components.Brake brake(fn_max=15)
      annotation (Placement(transformation(extent={{10,0},{30,20}})));
    Modelica.Blocks.Sources.Step step(
      offset=0,
      startTime=0.01,
      height=1)
      annotation (Placement(transformation(extent={{-10,34},{10,54}})));
  equation
    connect(piezoReal.n, ground.p) annotation (Line(
        points={{-20,0},{-20,-10},{-60,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground.p, sineVoltage.n) annotation (Line(
        points={{-60,-10},{-60,0}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(sineVoltage.p, piezoReal.p) annotation (Line(
        points={{-60,20},{-60,28},{-20,28},{-20,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(piezoReal.flange_a, brake.flange_a) annotation (Line(
        points={{-10,10},{10,10}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(step.y, brake.f_normalized) annotation (Line(
        points={{11,44},{20,44},{20,21}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end PiezoWelding;
  annotation (uses(Modelica(version="3.2.2")));
end Chap6_PiezoActuators;
