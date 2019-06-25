within ;
package Chap6_ScissorPlatform
  model Mecanisme_Ciseau_1
    parameter Modelica.SIunits.Length L = 1.5 "Longueur du bras (complet)";
    parameter Modelica.SIunits.Angle alpha_0=5*3.14/180 "Agnle alpha initial";
      Modelica.SIunits.Angle alpha(start=alpha_0);
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_platform
      annotation (Placement(transformation(extent={{-10,90},{10,110}}),
          iconTransformation(extent={{-10,90},{10,110}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_actuator
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Blocks.Interfaces.RealOutput alpha_deg
      annotation (Placement(transformation(extent={{92,-40},{112,-20}}),
          iconTransformation(extent={{92,-40},{112,-20}})));
  equation
    flange_actuator.s = 2*L*cos(alpha);
    flange_platform.s = 4*L*sin(alpha);

    flange_actuator.f = 2*flange_platform.f/tan(alpha);
    alpha_deg=Modelica.SIunits.Conversions.to_deg(alpha);

    annotation(Icon(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
              -100},{100,100}}),                                                                        graphics={  Rectangle(extent = {{-68, 68}, {100, 52}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, 64}, {94, 56}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-66, -54}, {-54, -66}}, lineColor = {0, 0, 255}), Rectangle(extent = {{0, -52}, {100, -68}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, -56}, {94, -64}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points={{
                -60,-60},{58,0}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points={{
                -62,0},{56,-60}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1),                                                                                   Line(points={{0,
                70},{0,90}},                                                                                                    color = {0, 0, 0}, smooth = Smooth.None),
                                                                                                    Ellipse(extent={{
                -66,66},{-54,54}},                                                                                                    lineColor = {0, 0, 255}),                                                                                                    Line(points={{
                -62,0},{58,60}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points={{
                -60,60},{58,0}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1),
                                                                                                    Rectangle(extent={{
                -50,-58},{48,-62}},                                                                                                    lineColor=
                {0,255,128},                                                                                                    fillColor=
                {213,255,170},
              fillPattern=FillPattern.Solid),                                                                                                    Line(points={{0,
                -90},{0,-62}},                                                                                                    color = {0, 0, 0}, smooth = Smooth.None),
          Line(
            points={{50,-68},{50,-80}},
            smooth=Smooth.None,
            color={0,0,255}),
          Line(
            points={{20,-80},{80,-80},{76,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{72,-80},{68,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{64,-80},{60,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{56,-80},{52,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{48,-80},{44,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{40,-80},{36,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{32,-80},{28,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{24,-80},{20,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{92,-30},{48,-30},{-34,-54}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-28,-58},{-28,-54},{-32,-50},{-36,-48}},
            color={0,0,255},
            smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics));
  end Mecanisme_Ciseau_1;

  model Mecanisme_Ciseau_2
    parameter Modelica.SIunits.Length L = 1.5 "Longueur du bras (complet)";
    parameter Modelica.SIunits.Angle alpha_0=5*3.14/180 "Agnle alpha initial";
      Modelica.SIunits.Angle alpha(start=alpha_0);
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_platform
      annotation (Placement(transformation(extent={{-10,90},{10,110}}),
          iconTransformation(extent={{-10,90},{10,110}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_actuator
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Blocks.Interfaces.RealOutput alpha_deg
      annotation (Placement(transformation(extent={{92,-40},{112,-20}}),
          iconTransformation(extent={{92,-40},{112,-20}})));
  equation
    flange_actuator.s = L*sqrt((cos(alpha))^2+(3*sin(alpha))^2);
    flange_platform.s = 4*L*sin(alpha);

    flange_actuator.f = flange_platform.f/2*sqrt(1+8*sin(alpha)^2)/sin(alpha);
    alpha_deg=Modelica.SIunits.Conversions.to_deg(alpha);

    annotation(Icon(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
              -100},{100,100}}),                                                                        graphics={  Rectangle(extent = {{-68, 68}, {100, 52}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, 64}, {94, 56}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-66, -54}, {-54, -66}}, lineColor = {0, 0, 255}), Rectangle(extent = {{0, -52}, {100, -68}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, -56}, {94, -64}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points={{
                -60,-60},{58,0}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points={{
                -62,0},{56,-60}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1),                                                                                   Line(points={{0,
                70},{0,90}},                                                                                                    color = {0, 0, 0}, smooth = Smooth.None),
                                                                                                    Ellipse(extent={{
                -66,66},{-54,54}},                                                                                                    lineColor = {0, 0, 255}),                                                                                                    Line(points={{
                -62,0},{58,60}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points={{
                -60,60},{58,0}},                                                                                                    color = {0, 0, 255}, smooth = Smooth.None, thickness = 1),
                                                                                                    Line(points={{0,
                -90},{-56,-56}},                                                                                                  color = {0, 0, 0}, smooth = Smooth.None),
          Line(
            points={{50,-68},{50,-80}},
            smooth=Smooth.None,
            color={0,0,255}),
          Line(
            points={{20,-80},{80,-80},{76,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{72,-80},{68,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{64,-80},{60,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{56,-80},{52,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{48,-80},{44,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{40,-80},{36,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{32,-80},{28,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{24,-80},{20,-86}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{92,-30},{48,-30},{-34,-54}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-28,-58},{-28,-54},{-32,-50},{-36,-48}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-58,-60},{-2,30}},
            color={170,255,170},
            smooth=Smooth.None,
            thickness=1)}),        Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics));
  end Mecanisme_Ciseau_2;

  model Essai
    Mecanisme_Ciseau_1 mecanisme_Ciseau(alpha_0=0.087266462599716)
      annotation (Placement(transformation(extent={{-38,-8},{2,32}})));
    Modelica.Mechanics.Translational.Components.Mass mass(m=200) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-18,52})));
    Modelica.Mechanics.Translational.Sources.Speed speed(s(fixed=false))
      annotation (Placement(transformation(extent={{-56,-30},{-36,-10}})));
    Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(
        f_constant=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-18,80})));
    Modelica.Blocks.Sources.Step step(height=-1e-2)
      annotation (Placement(transformation(extent={{-92,-30},{-72,-10}})));
    Modelica.Mechanics.Translational.Components.Mass mass1(
                                                          m=200) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={54,52})));
    Modelica.Mechanics.Translational.Sources.Speed speed1(s(fixed=false))
      annotation (Placement(transformation(extent={{16,-30},{36,-10}})));
    Modelica.Mechanics.Translational.Sources.ConstantForce constantForce1(
        f_constant=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={54,80})));
    Mecanisme_Ciseau_2 mecanisme_Ciseau_2_1(alpha_0=0.087266462599716)
      annotation (Placement(transformation(extent={{38,-6},{70,30}})));
    Modelica.Blocks.Sources.Step step1(height=1e-2)
      annotation (Placement(transformation(extent={{-34,-58},{-14,-38}})));
  equation
    connect(mass.flange_b, constantForce.flange) annotation (Line(
        points={{-18,62},{-18,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(step.y, speed.v_ref) annotation (Line(
        points={{-71,-20},{-58,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(mass.flange_a, mecanisme_Ciseau.flange_platform) annotation (Line(
        points={{-18,42},{-18,32}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(speed.flange, mecanisme_Ciseau.flange_actuator) annotation (Line(
        points={{-36,-20},{-28,-20},{-28,-8},{-18,-8}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(mass1.flange_b, constantForce1.flange) annotation (Line(
        points={{54,62},{54,70}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(mecanisme_Ciseau_2_1.flange_platform, mass1.flange_a) annotation (
        Line(
        points={{54,30},{54,42}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(speed1.flange, mecanisme_Ciseau_2_1.flange_actuator) annotation (
        Line(
        points={{36,-20},{54,-20},{54,-6}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(step1.y, speed1.v_ref) annotation (Line(
        points={{-13,-48},{8,-48},{8,-20},{14,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end Essai;
  annotation (uses(Modelica(version="3.2.2")));
end Chap6_ScissorPlatform;
