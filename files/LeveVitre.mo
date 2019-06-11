within ;
package LeveVitre
  model Vitre_simple
    parameter Modelica.SIunits.Mass Mass_Vitre = 3 "Masse de la vitre";
    parameter Modelica.SIunits.Force F_friction = 50
      "Force de frottement de la vitre";
    parameter Modelica.SIunits.Position Xmax = 0.2 "Position haute";
    parameter Modelica.SIunits.Position Xmin = -0.2 "Position basse";
    parameter Modelica.SIunits.Position Xinit = 0 "Position initiale";
    constant Modelica.SIunits.Acceleration g = 9.81
      "Acceleration de la gravite";
    Modelica.Mechanics.Translational.Components.Mass mass_vitre(L = 0, m = Mass_Vitre, s(fixed = true, start = Xinit)) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 0})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a1
      "Left flange of translational component"                                                              annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
    Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(f_constant = -Mass_Vitre * g) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 56})));
    Modelica.Mechanics.Translational.Components.SupportFriction supportFriction(f_pos = [0, F_friction]) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, -44})));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap_Haut(d = 100, c = 100e3, s_rel0 = 0) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, 30})));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap_Bas(c = 100e3, d = 100, s_rel0 = 0) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, -30})));
    Modelica.Mechanics.Translational.Components.Fixed fixed(s0 = Xmin) annotation(Placement(transformation(extent = {{-70, -64}, {-50, -44}})));
    Modelica.Mechanics.Translational.Components.Fixed fixed1(s0 = Xmax) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-60, 56})));
  equation
    connect(constantForce.flange, mass_vitre.flange_b) annotation(Line(points = {{-1.77636e-015, 46}, {6.66134e-016, 46}, {6.66134e-016, 10}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(supportFriction.flange_b, mass_vitre.flange_a) annotation(Line(points = {{4.44089e-016, -34}, {4.44089e-016, -23}, {0, -23}, {0, -10}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(supportFriction.flange_a, flange_a1) annotation(Line(points = {{0, -54}, {0, -100}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(elastoGap_Haut.flange_b, fixed1.flange) annotation(Line(points = {{-60, 40}, {-60, 56}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(elastoGap_Haut.flange_a, mass_vitre.flange_b) annotation(Line(points = {{-60, 20}, {-60, 10}, {6.66134e-016, 10}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(elastoGap_Bas.flange_b, mass_vitre.flange_a) annotation(Line(points = {{-60, -20}, {-60, -10}, {0, -10}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(elastoGap_Bas.flange_a, fixed.flange) annotation(Line(points = {{-60, -40}, {-60, -54}}, color = {0, 127, 0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(points = {{-80, -60}, {-80, -60}}, lineColor = {0, 0, 255}, smooth = Smooth.None), Polygon(points = {{78, -60}, {-82, -60}, {-94, -50}, {-96, -40}, {-96, 0}, {-94, 10}, {-86, 24}, {16, 82}, {28, 84}, {86, 88}, {94, 84}, {98, 76}, {92, -50}, {88, -56}, {78, -60}}, lineColor = {0, 0, 255}, smooth = Smooth.None, fillColor = {85, 170, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{0, -90}, {0, -60}}, color = {0, 0, 255}, smooth = Smooth.None)}));
  end Vitre_simple;

  model Mecanisme_Ciseau_Simple
    parameter Modelica.SIunits.Length Length_arm = 0.36
      "Longueur du bras (complet)";
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{-10, 88}, {10, 108}}), iconTransformation(extent = {{-10, 88}, {10, 108}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110, -70}, {-90, -50}}), iconTransformation(extent = {{-110, -70}, {-90, -50}})));
    Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio = 1 / Length_arm) annotation(Placement(transformation(extent = {{-46, -70}, {-26, -50}})));
  equation
    connect(flange_a, idealGearR2T.flangeR) annotation(Line(points = {{-100, -60}, {-46, -60}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(idealGearR2T.flangeT, flange_b) annotation(Line(points = {{-26, -60}, {0, -60}, {0, 98}}, color = {0, 127, 0}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-68, 68}, {100, 52}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, 64}, {94, 56}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-66, -54}, {-54, -66}}, lineColor = {0, 0, 255}), Rectangle(extent = {{0, -52}, {100, -68}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, -56}, {94, -64}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-60, -60}, {60, 60}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points = {{-60, 60}, {58, -60}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points = {{-92, -60}, {-66, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 68}, {0, 88}}, color = {0, 0, 0}, smooth = Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end Mecanisme_Ciseau_Simple;

  model Mecanisme_Ciseau
    parameter Modelica.SIunits.Length Length_arm = 0.36
      "Longueur du bras (complet)";

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{-10, 88}, {10, 108}}), iconTransformation(extent = {{-10, 88}, {10, 108}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110, -70}, {-90, -50}}), iconTransformation(extent = {{-110, -70}, {-90, -50}})));
  equation
    flange_a.tau = -flange_b.f * Length_arm * cos(flange_a.phi);
// lien effort lineaire / Couple
// obtenu par travaux virtuels
    flange_b.s = Length_arm * sin(flange_a.phi);
    // lien positons lineaire / angle
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-68, 68}, {100, 52}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, 64}, {94, 56}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-66, -54}, {-54, -66}}, lineColor = {0, 0, 255}), Rectangle(extent = {{0, -52}, {100, -68}}, lineColor = {0, 0, 255}), Rectangle(extent = {{10, -56}, {94, -64}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-60, -60}, {60, 60}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points = {{-60, 60}, {58, -60}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points = {{-92, -60}, {-66, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 68}, {0, 88}}, color = {0, 0, 0}, smooth = Smooth.None)}));
  end Mecanisme_Ciseau;

  model Mecanisme_Ciseau_Inertie
    parameter Modelica.SIunits.Length Length_arm = 0.36
      "Longueur du bras (complet)";
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{-10, 88}, {10, 108}}), iconTransformation(extent = {{-10, 88}, {10, 108}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110, -70}, {-90, -50}}), iconTransformation(extent = {{-110, -70}, {-90, -50}})));
    Mecanisme_Ciseau mecanisme_Ciseau_Simple(Length_arm = Length_arm) annotation(Placement(transformation(extent = {{-24, -30}, {26, 22}})));
    Modelica.Mechanics.Rotational.Components.Inertia EquivalentInertia(J = J) annotation(Placement(transformation(extent = {{-70, -48}, {-50, -28}})));
    parameter Modelica.SIunits.Inertia J = 1 "Inertie equivalente des bras";
  equation
    connect(EquivalentInertia.flange_b, mecanisme_Ciseau_Simple.flange_a) annotation(Line(points = {{-50, -38}, {-32, -38}, {-32, -19.6}, {-24, -19.6}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(EquivalentInertia.flange_a, flange_a) annotation(Line(points = {{-70, -38}, {-86, -38}, {-86, -60}, {-100, -60}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(mecanisme_Ciseau_Simple.flange_b, flange_b) annotation(Line(points = {{1, 21.48}, {1, 98}, {0, 98}}, color = {0, 127, 0}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-68, 68}, {100, 52}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{10, 64}, {94, 56}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-66, -54}, {-54, -66}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{0, -52}, {100, -68}}, lineColor = {0, 0, 255}, fillColor = {85, 170, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{10, -56}, {94, -64}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-60, -60}, {60, 60}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points = {{-60, 60}, {58, -60}}, color = {0, 0, 255}, smooth = Smooth.None, thickness = 1), Line(points = {{-92, -60}, {-66, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 68}, {0, 88}}, color = {0, 0, 0}, smooth = Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end Mecanisme_Ciseau_Inertie;

  model MoteurDC
    parameter Modelica.SIunits.Resistance Rmoteur = 0.35 "resistance moteur DC";
    parameter Modelica.SIunits.Inductance Lmoteur = 1e-5 "Inductance moteur DC";
    parameter Modelica.SIunits.ElectricalTorqueConstant Kmoteur = 0.018
      "Constante electromecanique moteur DC";
    parameter Modelica.SIunits.Inertia Jmoteur = 1.2e-5 "Inertie moteur DC";
    Modelica.Electrical.Analog.Basic.EMF emf(k = Kmoteur) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = Rmoteur) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 60})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = Lmoteur) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 30})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = Jmoteur) annotation(Placement(transformation(extent = {{48, -10}, {68, 10}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1
      "Right flange of shaft"                                                           annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                    annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
    Modelica.Mechanics.Rotational.Components.Damper damper(d = Dmoteur) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {30, -10})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{20, -36}, {40, -16}})));
    parameter Modelica.SIunits.RotationalDampingConstant Dmoteur = 6e-6
      "Damping constant moteur DC";
  equation
    connect(emf.flange, inertia.flange_a) annotation(Line(points = {{10, 0}, {48, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(inertia.flange_b, flange_b1) annotation(Line(points = {{68, 0}, {100, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(emf.p, inductor.n) annotation(Line(points = {{0, 10}, {0, 20}, {-1.77636e-015, 20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductor.p, resistor.n) annotation(Line(points = {{1.77636e-015, 40}, {0, 40}, {0, 50}, {-1.77636e-015, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor.p, p1) annotation(Line(points = {{1.77636e-015, 70}, {0, 70}, {0, 100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(emf.n, n1) annotation(Line(points = {{0, -10}, {0, -100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(damper.flange_a, fixed.flange) annotation(Line(points = {{30, -20}, {30, -26}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(damper.flange_b, inertia.flange_a) annotation(Line(points = {{30, 0}, {48, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(emf.flange, damper.flange_b) annotation(Line(points = {{10, 0}, {30, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{60, 10}, {100, -10}}, lineColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Ellipse(extent = {{-62, 62}, {62, -64}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{0, -90}, {0, 90}}, color = {0, 0, 0}, smooth = Smooth.None), Rectangle(extent = {{-8, 68}, {8, 62}}, lineColor = {0, 0, 0}, fillColor = {127, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-8, -64}, {8, -70}}, lineColor = {0, 0, 0}, fillColor = {127, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid)}));
  end MoteurDC;

  model LeveVitreComplet
    Vitre_simple vitre(F_friction = 50) annotation(Placement(transformation(extent = {{36, 20}, {82, 60}})));
    Mecanisme_Ciseau mecanisme_Ciseau annotation(Placement(transformation(extent = {{40, -26}, {80, 6}})));
    Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(offsetTorque = 0, startTime = 1, stepTorque = 0.14) annotation(Placement(transformation(extent = {{-76, -30}, {-56, -10}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 8 * 79) annotation(Placement(visible = true, transformation(extent = {{2, -30}, {22, -10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1.2e-5) annotation(Placement(transformation(extent = {{-48, -30}, {-28, -10}})));
  equation
    connect(idealGear.flange_a, inertia.flange_b) annotation(
      Line(points = {{2, -20}, {-28, -20}}));
    connect(idealGear.flange_b, mecanisme_Ciseau.flange_a) annotation(
      Line(points = {{22, -20}, {36, -20}, {36, -19.6}, {40, -19.6}}));
    connect(mecanisme_Ciseau.flange_b, vitre.flange_a1) annotation(Line(points = {{60, 5.68}, {60, 14}, {59, 14}, {59, 20}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(torqueStep.flange, inertia.flange_a) annotation(Line(points = {{-56, -20}, {-48, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end LeveVitreComplet;

  model LeveVitreComplet_Simple
    Vitre_simple vitre annotation(Placement(transformation(extent = {{36, 20}, {82, 60}})));
    Mecanisme_Ciseau_Simple mecanisme_Ciseau annotation(Placement(transformation(extent = {{40, -26}, {80, 6}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 8) annotation(Placement(transformation(extent = {{10, -30}, {30, -10}})));
    MoteurDC moteurDC annotation(Placement(transformation(extent = {{-50, -30}, {-30, -10}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-50, -60}, {-30, -40}})));
    Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage(startTime = 1, V = 12) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-80, -20})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(lossTable = [0, 0.35, 0.01, 0, 0], ratio = 150) annotation(Placement(transformation(extent = {{-20, -30}, {0, -10}})));
  equation
    connect(mecanisme_Ciseau.flange_b, vitre.flange_a1) annotation(Line(points = {{60, 5.68}, {60, 14}, {59, 14}, {59, 20}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(idealGear.flange_b, mecanisme_Ciseau.flange_a) annotation(Line(points = {{30, -20}, {34, -20}, {34, -19.6}, {40, -19.6}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(ground.p, moteurDC.n1) annotation(Line(points = {{-40, -40}, {-40, -30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(stepVoltage.p, moteurDC.p1) annotation(Line(points = {{-80, -10}, {-40, -10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground.p, stepVoltage.n) annotation(Line(points = {{-40, -40}, {-80, -40}, {-80, -30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(moteurDC.flange_b1, lossyGear.flange_a) annotation(Line(points = {{-30, -20}, {-20, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(lossyGear.flange_b, idealGear.flange_a) annotation(Line(points = {{0, -20}, {10, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end LeveVitreComplet_Simple;

  model LeveVitreComplet_Complet
    Vitre_simple vitre(Mass_Vitre = 3.2) annotation(Placement(transformation(extent = {{85, 14}, {131, 54}})));
    Mecanisme_Ciseau mecanisme_Ciseau annotation(Placement(transformation(extent = {{88, -26}, {128, 6}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 15) annotation(Placement(transformation(extent = {{32, -30}, {52, -10}})));
    MoteurDC moteurDC annotation(Placement(transformation(extent = {{-50, -30}, {-30, -10}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-50, -60}, {-30, -40}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio = 79, lossTable = [0, 0.35, 0.0001, 0, 0]) annotation(Placement(transformation(extent = {{-20, -30}, {0, -10}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 2 / 0.3 ^ 2) annotation(Placement(transformation(extent = {{58, -30}, {78, -10}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(c = 20e3, d = 100) annotation(Placement(transformation(extent = {{6, -30}, {26, -10}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper RessortCompensation(phi_rel0(displayUnit = "rad") = 2.8, c = 3 * 0, d = 0.1 * 0) annotation(Placement(transformation(extent = {{32, -66}, {52, -46}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {28, -56})));
    Modelica.Electrical.Analog.Sources.TableVoltage tableVoltage(table = [0, 0; 1, 0; 1, 12; 3, 12; 3, 0; 4, 0; 4, -12; 8, -12; 8, 0; 10, 0]) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-72, -22})));
  equation
    connect(mecanisme_Ciseau.flange_b, vitre.flange_a1) annotation(Line(points = {{108, 5.68}, {108, 14}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(ground.p, moteurDC.n1) annotation(Line(points = {{-40, -40}, {-40, -30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(moteurDC.flange_b1, lossyGear.flange_a) annotation(Line(points = {{-30, -20}, {-20, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(inertia.flange_b, mecanisme_Ciseau.flange_a) annotation(Line(points = {{78, -20}, {84, -20}, {84, -19.6}, {88, -19.6}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(inertia.flange_a, idealGear.flange_b) annotation(Line(points = {{58, -20}, {52, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(idealGear.flange_a, springDamper.flange_b) annotation(Line(points = {{32, -20}, {26, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(lossyGear.flange_b, springDamper.flange_a) annotation(Line(points = {{0, -20}, {6, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(RessortCompensation.flange_b, inertia.flange_a) annotation(Line(points = {{52, -56}, {58, -56}, {58, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(fixed.flange, RessortCompensation.flange_a) annotation(Line(points = {{28, -56}, {32, -56}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(tableVoltage.p, moteurDC.p1) annotation(Line(points = {{-72, -12}, {-72, -2}, {-40, -2}, {-40, -10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground.p, tableVoltage.n) annotation(Line(points = {{-40, -40}, {-72, -40}, {-72, -32}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -100}, {140, 100}}), graphics), Icon(coordinateSystem(extent = {{-120, -100}, {140, 100}})));
  end LeveVitreComplet_Complet;

  model Logic_Pilotage
    inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
    Modelica.StateGraph.InitialStep initialStep annotation(Placement(transformation(extent = {{-82, 38}, {-62, 58}})));
    Modelica.StateGraph.TransitionWithSignal AppuiSurBouton(enableTimer = false) annotation(Placement(transformation(extent = {{-50, 38}, {-30, 58}})));
    Modelica.Blocks.Sources.RadioButtonSource On(buttonTimeTable = {0, 1}, reset = {Off.on}) annotation(Placement(transformation(extent = {{-82, 16}, {-70, 28}})));
    Modelica.StateGraph.StepWithSignal stepWithSignal annotation(Placement(transformation(extent = {{-22, 38}, {-2, 58}})));
    Modelica.StateGraph.TransitionWithSignal transitionWithSignal(enableTimer = true, waitTime = 0.5) annotation(Placement(transformation(extent = {{12, 38}, {32, 58}})));
    Vitre_simple vitre(Mass_Vitre = 3.2) annotation(Placement(transformation(extent = {{137, -10}, {183, 30}})));
    Mecanisme_Ciseau mecanisme_Ciseau annotation(Placement(transformation(extent = {{140, -50}, {180, -18}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 15) annotation(Placement(transformation(extent = {{84, -54}, {104, -34}})));
    MoteurDC moteurDC annotation(Placement(transformation(extent = {{2, -54}, {22, -34}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{2, -84}, {22, -64}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio = 79, lossTable = [0, 0.35, 0.0001, 0, 0]) annotation(Placement(transformation(extent = {{32, -54}, {52, -34}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 2 / 0.3 ^ 2) annotation(Placement(transformation(extent = {{110, -54}, {130, -34}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(c = 20e3, d = 100) annotation(Placement(transformation(extent = {{58, -54}, {78, -34}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper RessortCompensation(phi_rel0(displayUnit = "rad") = 2.8, c = 3 * 0, d = 0.1 * 0) annotation(Placement(transformation(extent = {{84, -90}, {104, -70}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {80, -80})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Batterie(V = 12) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-80, -46})));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch annotation(Placement(transformation(extent = {{-64, -26}, {-44, -6}})));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-38, -38})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent = {{-24, -6}, {-4, -26}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 12 / 0.35 / 2) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {22, 16})));
    Modelica.Blocks.Sources.RadioButtonSource Off(buttonTimeTable = {0, 1.2}, reset = {On.on}) annotation(Placement(transformation(extent = {{-82, -2}, {-70, 10}})));
  equation
    connect(initialStep.outPort[1], AppuiSurBouton.inPort) annotation(Line(points = {{-61.5, 48}, {-44, 48}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(On.on, AppuiSurBouton.condition) annotation(Line(points = {{-69.1, 22}, {-40, 22}, {-40, 36}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(stepWithSignal.inPort[1], AppuiSurBouton.outPort) annotation(Line(points = {{-23, 48}, {-38.5, 48}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(stepWithSignal.outPort[1], transitionWithSignal.inPort) annotation(Line(points = {{-1.5, 48}, {18, 48}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(transitionWithSignal.outPort, initialStep.inPort[1]) annotation(Line(points = {{23.5, 48}, {54, 48}, {54, 72}, {-92, 72}, {-92, 48}, {-83, 48}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(mecanisme_Ciseau.flange_b, vitre.flange_a1) annotation(Line(points = {{160, -18.32}, {160, -10}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(ground.p, moteurDC.n1) annotation(Line(points = {{12, -64}, {12, -54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(moteurDC.flange_b1, lossyGear.flange_a) annotation(Line(points = {{22, -44}, {32, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(inertia.flange_b, mecanisme_Ciseau.flange_a) annotation(Line(points = {{130, -44}, {136, -44}, {136, -43.6}, {140, -43.6}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(inertia.flange_a, idealGear.flange_b) annotation(Line(points = {{110, -44}, {104, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(idealGear.flange_a, springDamper.flange_b) annotation(Line(points = {{84, -44}, {78, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(lossyGear.flange_b, springDamper.flange_a) annotation(Line(points = {{52, -44}, {58, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(RessortCompensation.flange_b, inertia.flange_a) annotation(Line(points = {{104, -80}, {110, -80}, {110, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(fixed.flange, RessortCompensation.flange_a) annotation(Line(points = {{80, -80}, {84, -80}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(ground.p, Batterie.n) annotation(Line(points = {{12, -64}, {-80, -64}, {-80, -56}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealClosingSwitch.control, stepWithSignal.active) annotation(Line(points = {{-54, -9}, {-54, 12}, {-12, 12}, {-12, 37}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(Batterie.p, idealClosingSwitch.p) annotation(Line(points = {{-80, -36}, {-80, -16}, {-64, -16}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealDiode.n, idealClosingSwitch.n) annotation(Line(points = {{-38, -28}, {-38, -16}, {-44, -16}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealDiode.p, ground.p) annotation(Line(points = {{-38, -48}, {-38, -64}, {12, -64}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealClosingSwitch.n, currentSensor.p) annotation(Line(points = {{-44, -16}, {-24, -16}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(currentSensor.n, moteurDC.p1) annotation(Line(points = {{-4, -16}, {12, -16}, {12, -34}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(greaterThreshold.y, transitionWithSignal.condition) annotation(Line(points = {{22, 27}, {22, 36}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(greaterThreshold.u, currentSensor.i) annotation(Line(points = {{22, 4}, {22, -6}, {-14, -6}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {200, 100}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {200, 100}})));
  end Logic_Pilotage;

  model Logic_uC_Pilotage
    Vitre_simple vitre(Mass_Vitre = 3.2, Xinit = -0.2) annotation(Placement(transformation(extent = {{145, -8}, {191, 32}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 15) annotation(Placement(transformation(extent = {{98, -54}, {118, -34}})));
    MoteurDC moteurDC annotation(Placement(transformation(extent = {{0, -54}, {20, -34}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio = 79, lossTable = [0, 0.35, 0.0001, 0, 0]) annotation(Placement(transformation(extent = {{40, -54}, {60, -34}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(c = 20e3, d = 100) annotation(Placement(transformation(extent = {{68, -54}, {88, -34}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper RessortCompensation(phi_rel0(displayUnit = "rad") = 2.8, c = 3, d = 0.1) annotation(Placement(transformation(extent = {{92, -90}, {112, -70}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {88, -80})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Batterie(V = 12) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-80, -46})));
    Modelica.Blocks.Sources.BooleanTable Up(table = {0, 1, 1.2}, startValue = true) annotation(Placement(transformation(extent = {{-106, 16}, {-86, 36}})));
    Modelica.Blocks.Sources.BooleanTable Down(table = {0}, startValue = true) annotation(Placement(transformation(extent = {{-106, -10}, {-86, 10}})));
    RelaySPDT relaySPDT1 annotation(Placement(transformation(extent = {{-6, 6}, {6, -6}}, rotation = 270, origin = {-52, -38})));
    RelaySPDT relaySPDT annotation(Placement(transformation(extent = {{-6, 6}, {6, -6}}, rotation = 270, origin = {-30, -14})));
    Modelica.Electrical.Analog.Basic.Resistor Shunt(R = 0.04) annotation(Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 270, origin = {-58, -62})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-90, -90}, {-70, -70}})));
    Modelica.Electrical.Analog.Sensors.PotentialSensor ShuntSensor annotation(Placement(transformation(extent = {{-32, -80}, {-12, -60}})));
    Modelica.Blocks.Sources.RealExpression CopieMesureCourant(y = ShuntSensor.phi) annotation(Placement(transformation(extent = {{-15, -9}, {15, 9}}, rotation = 180, origin = {-15, 23})));
    Modelica.Blocks.Sources.RealExpression CopieMesurePosition(y = MotorAngleSensor.phi * 660 / 0.2) annotation(Placement(transformation(extent = {{-15, -9}, {15, 9}}, rotation = 180, origin = {-15, 35})));
    MicroController microController annotation(Placement(transformation(extent = {{-70, 8}, {-42, 34}})));
    Mecanisme_Ciseau_Inertie mecanisme_Ciseau_Inertie(J = 2 / 0.3 ^ 2) annotation(Placement(transformation(extent = {{146, -52}, {192, -14}})));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor MotorAngleSensor annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {30, -26})));
  equation
    connect(idealGear.flange_a, springDamper.flange_b) annotation(Line(points = {{98, -44}, {88, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(lossyGear.flange_b, springDamper.flange_a) annotation(Line(points = {{60, -44}, {68, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(fixed.flange, RessortCompensation.flange_a) annotation(Line(points = {{88, -80}, {92, -80}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(lossyGear.flange_a, moteurDC.flange_b1) annotation(Line(points = {{40, -44}, {20, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(relaySPDT1.NO, Shunt.p) annotation(Line(points = {{-58, -42.8}, {-58, -54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(relaySPDT.NO, Shunt.p) annotation(Line(points = {{-36, -18.8}, {-36, -54}, {-58, -54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Shunt.n, Batterie.n) annotation(Line(points = {{-58, -70}, {-80, -70}, {-80, -56}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(relaySPDT.COM, moteurDC.p1) annotation(Line(points = {{-24, -16.4}, {-12, -16.4}, {-12, -16}, {10, -16}, {10, -34}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Batterie.p, relaySPDT.NC) annotation(Line(points = {{-80, -36}, {-80, -14}, {-36, -14}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(relaySPDT1.NC, relaySPDT.NC) annotation(Line(points = {{-58, -38}, {-64, -38}, {-64, -14}, {-36, -14}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Shunt.n, ground.p) annotation(Line(points = {{-58, -70}, {-80, -70}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(moteurDC.n1, relaySPDT1.COM) annotation(Line(points = {{10, -54}, {-22, -54}, {-22, -40.4}, {-46, -40.4}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ShuntSensor.p, Shunt.p) annotation(Line(points = {{-32, -70}, {-40, -70}, {-40, -54}, {-58, -54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(microController.X, CopieMesurePosition.y) annotation(Line(points = {{-40, 32}, {-36, 32}, {-36, 35}, {-31.5, 35}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(microController.I, CopieMesureCourant.y) annotation(Line(points = {{-40, 26}, {-36, 26}, {-36, 23}, {-31.5, 23}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(microController.Up, Up.y) annotation(Line(points = {{-72, 16}, {-78, 16}, {-78, 26}, {-85, 26}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(microController.Down, Down.y) annotation(Line(points = {{-72, 10}, {-78, 10}, {-78, 0}, {-85, 0}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(mecanisme_Ciseau_Inertie.flange_b, vitre.flange_a1) annotation(Line(points = {{169, -14.38}, {169, -15.19}, {168, -15.19}, {168, -8}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(mecanisme_Ciseau_Inertie.flange_a, idealGear.flange_b) annotation(Line(points = {{146, -44.4}, {133, -44.4}, {133, -44}, {118, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(RessortCompensation.flange_b, idealGear.flange_b) annotation(Line(points = {{112, -80}, {132, -80}, {132, -44}, {118, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(MotorAngleSensor.flange, moteurDC.flange_b1) annotation(Line(points = {{30, -36}, {30, -44}, {20, -44}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(relaySPDT.coil, microController.R1) annotation(Line(points = {{-30, -8}, {-30, 16}, {-41, 16}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(microController.R2, relaySPDT1.coil) annotation(Line(points = {{-41, 10}, {-38, 10}, {-38, -2}, {-52, -2}, {-52, -32}}, color = {255, 0, 255}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -100}, {200, 100}}), graphics), Icon(coordinateSystem(extent = {{-120, -100}, {200, 100}})));
  end Logic_uC_Pilotage;

  model RelaySPDT "Single Pole Double Throw Relay"
    Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpeningSwitch annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {80, 30})));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {0, 30})));
    Modelica.Electrical.Analog.Interfaces.PositivePin NC
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                    annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin NO
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                    annotation(Placement(transformation(extent = {{70, 90}, {90, 110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin COM "Negative pin" annotation(Placement(transformation(extent = {{30, -110}, {50, -90}})));
    Modelica.Blocks.Interfaces.BooleanInput coil
      "true => p--n connected, false => switch open"                                            annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
  equation
    connect(idealOpeningSwitch.p, NO) annotation(Line(points = {{80, 40}, {80, 100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealOpeningSwitch.n, COM) annotation(Line(points = {{80, 20}, {60, 20}, {60, -100}, {40, -100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealClosingSwitch.p, NC) annotation(Line(points = {{0, 40}, {0, 100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealClosingSwitch.n, COM) annotation(Line(points = {{0, 20}, {2, 20}, {2, -100}, {40, -100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealClosingSwitch.control, coil) annotation(Line(points = {{-7, 30}, {-48, 30}, {-48, 0}, {-100, 0}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(idealOpeningSwitch.control, coil) annotation(Line(points = {{73, 30}, {52, 30}, {52, 0}, {-100, 0}}, color = {255, 0, 255}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-4, 44}, {4, 36}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{76, 44}, {84, 36}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{36, -36}, {44, -44}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-80, 40}, {-40, -40}}, lineColor = {0, 0, 0}), Line(points = {{-40, 20}, {-80, -20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{40, -40}, {80, 40}, {82, 40}, {80, 40}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 40}, {0, 100}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{80, 40}, {80, 100}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{40, -100}, {40, -40}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-40, 0}, {40, 0}}, color = {0, 0, 0}, smooth = Smooth.None, pattern = LinePattern.Dash), Text(extent = {{-34, 94}, {-4, 62}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "NO"), Text(extent = {{44, 90}, {74, 64}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "NC"), Text(extent = {{-16, -50}, {30, -90}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "COM")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end RelaySPDT;

  model ControlModule
    RelaySPDT relaySPDT annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {50, 10})));
    RelaySPDT relaySPDT1 annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-50, 10})));
    Modelica.Electrical.Analog.Interfaces.NegativePin A "Negative pin" annotation(Placement(transformation(extent = {{90, 70}, {110, 90}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin B "Negative pin" annotation(Placement(transformation(extent = {{90, -90}, {110, -70}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin P
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                   annotation(Placement(transformation(extent = {{-110, 70}, {-90, 90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin N
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                   annotation(Placement(transformation(extent = {{-110, -90}, {-90, -70}})));
    Modelica.Electrical.Analog.Basic.Resistor Shunt(R = R) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-80, -60})));
    parameter Modelica.SIunits.Resistance R = 0.2 "Shunt resistance";
    Modelica.Blocks.Interfaces.BooleanInput Up annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-60, 120})));
    Modelica.Blocks.Interfaces.BooleanInput Down annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 120})));
    Modelica.Blocks.Interfaces.RealInput X annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {60, 120})));
  equation
    connect(relaySPDT.COM, A) annotation(Line(points = {{40, 6}, {20, 6}, {20, 80}, {100, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(relaySPDT1.COM, B) annotation(Line(points = {{-40, 6}, {-20, 6}, {-20, -80}, {100, -80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(relaySPDT1.NC, P) annotation(Line(points = {{-60, 10}, {-80, 10}, {-80, 80}, {-100, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(relaySPDT.NC, P) annotation(Line(points = {{60, 10}, {80, 10}, {80, 60}, {-80, 60}, {-80, 80}, {-100, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Shunt.n, N) annotation(Line(points = {{-80, -70}, {-80, -80}, {-100, -80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Shunt.p, relaySPDT1.NO) annotation(Line(points = {{-80, -50}, {-80, 2}, {-60, 2}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(relaySPDT.NO, relaySPDT1.NO) annotation(Line(points = {{60, 2}, {80, 2}, {80, -40}, {-80, -40}, {-80, 2}, {-60, 2}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-62, 78}, {18, -82}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-32, 88}, {-10, 68}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-34, 91}, {-9, 79}}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{-70, 76}, {-62, 60}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-70, 56}, {-62, 40}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-70, 16}, {-62, 0}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-70, 36}, {-62, 20}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-70, -24}, {-62, -40}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-70, -4}, {-62, -20}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-70, -64}, {-62, -80}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-70, -44}, {-62, -60}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, 76}, {26, 60}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, 56}, {26, 40}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, 16}, {26, 0}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, 36}, {26, 20}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, -24}, {26, -40}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, -4}, {26, -20}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, -64}, {26, -80}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{18, -44}, {26, -60}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Ellipse(extent = {{36, 44}, {44, 36}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{76, 44}, {84, 36}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{56, -16}, {64, -24}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{60, -20}, {80, 40}, {82, 40}, {80, 40}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{40, 40}, {40, 80}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{80, 40}, {80, 80}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{60, -80}, {60, -20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{36, 10}, {72, 10}}, color = {0, 0, 0}, smooth = Smooth.None, pattern = LinePattern.Dash), Line(points = {{-66, 84}, {-54, 98}, {-54, 92}, {-54, 98}, {-60, 96}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-6, 98}, {10, 86}, {8, 92}, {10, 86}, {4, 86}}, color = {0, 0, 0}, smooth = Smooth.None)}));
  end ControlModule;

  model MicroController
    inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(Placement(transformation(extent = {{-140, 80}, {-120, 100}})));
    Modelica.StateGraph.InitialStep initialStep annotation(Placement(transformation(extent = {{-130, -10}, {-110, 10}})));
    Modelica.StateGraph.TransitionWithSignal Appui(waitTime = 0.2, enableTimer = false) annotation(Placement(transformation(extent = {{-104, -10}, {-84, 10}})));
    Modelica.Blocks.Interfaces.BooleanInput Up annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 0, origin = {-160, -80})));
    Modelica.Blocks.Interfaces.BooleanInput Down annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 0, origin = {-160, -140})));
    Modelica.Blocks.Interfaces.RealInput X annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 180, origin = {160, 80})));
    Modelica.Blocks.Logical.Or or1 annotation(Placement(transformation(extent = {{-128, -90}, {-108, -70}})));
    Modelica.StateGraph.Alternative alternative annotation(Placement(transformation(extent = {{-76, -40}, {102, 44}})));
    Modelica.StateGraph.Step OnBouge annotation(Placement(transformation(extent = {{-82, 12}, {-72, 22}})));
    Modelica.StateGraph.Transition transition(condition = X < 0.2 and Up, waitTime = 0.5, enableTimer = false) annotation(Placement(transformation(extent = {{-48, 10}, {-26, 32}})));
    Modelica.StateGraph.Step OnMonte annotation(Placement(transformation(extent = {{-12, 10}, {8, 30}})));
    Modelica.StateGraph.Transition transition2(condition = X > (-0.2) and Down) annotation(Placement(transformation(extent = {{-46, -30}, {-24, -8}})));
    Modelica.StateGraph.Step OnDescend annotation(Placement(transformation(extent = {{-12, -30}, {8, -10}})));
    Modelica.Blocks.Interfaces.BooleanOutput R1 annotation(Placement(transformation(extent = {{140, -90}, {160, -70}})));
    Modelica.Blocks.Interfaces.BooleanOutput R2 annotation(Placement(transformation(extent = {{140, -150}, {160, -130}})));
    Modelica.Blocks.Sources.BooleanExpression setCondition(y = OnMonte.active) annotation(Placement(transformation(extent = {{94, -90}, {124, -70}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression setCondition1(y = OnDescend.active) annotation(Placement(transformation(extent = {{96, -150}, {126, -130}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput I annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 180, origin = {160, 20})));
    Modelica.Blocks.Logical.Timer timer annotation(Placement(transformation(extent = {{10, -88}, {30, -68}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression setCondition2(y = OnMonte.active) annotation(Placement(transformation(extent = {{-72, -96}, {-42, -76}}, rotation = 0)));
    Modelica.Blocks.Logical.Or or2 annotation(Placement(transformation(extent = {{-28, -98}, {-8, -78}})));
    Modelica.Blocks.Sources.BooleanExpression setCondition3(y = OnDescend.active) annotation(Placement(transformation(extent = {{-74, -112}, {-44, -92}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression setCondition4(y = abs(I) > 0.5 and timer.y > 0.5) annotation(Placement(transformation(extent = {{-2, -12}, {28, 8}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression setCondition5(y = abs(I) > 0.5 and timer.y > 0.5) annotation(Placement(transformation(extent = {{-2, -60}, {28, -40}}, rotation = 0)));
    Modelica.StateGraph.TransitionWithSignal transitionWithSignal annotation(Placement(transformation(extent = {{28, 12}, {48, 32}})));
    Modelica.StateGraph.TransitionWithSignal transitionWithSignal1 annotation(Placement(transformation(extent = {{30, -28}, {50, -8}})));
  equation
    connect(initialStep.outPort[1], Appui.inPort) annotation(Line(points = {{-109.5, 0}, {-98, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(or1.u1, Up) annotation(Line(points = {{-130, -80}, {-160, -80}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(Down, or1.u2) annotation(Line(points = {{-160, -140}, {-160, -139}, {-130, -139}, {-130, -88}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(or1.y, Appui.condition) annotation(Line(points = {{-107, -80}, {-94, -80}, {-94, -12}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(OnBouge.inPort[1], Appui.outPort) annotation(Line(points = {{-82.5, 17}, {-84, 17}, {-84, 0}, {-92.5, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(transition.inPort, alternative.split[1]) annotation(Line(points = {{-41.4, 21}, {-46, 21}, {-46, 23}, {-57.31, 23}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(OnMonte.inPort[1], transition.outPort) annotation(Line(points = {{-13, 20}, {-34, 20}, {-34, 21}, {-35.35, 21}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(transition2.outPort, OnDescend.inPort[1]) annotation(Line(points = {{-33.35, -19}, {-27.675, -19}, {-27.675, -20}, {-13, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(transition2.inPort, alternative.split[2]) annotation(Line(points = {{-39.4, -19}, {-57.31, -19}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(alternative.outPort, initialStep.inPort[1]) annotation(Line(points = {{103.78, 2}, {103.78, -4}, {108, -4}, {108, 62}, {-136, 62}, {-136, 0}, {-131, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(setCondition.y, R1) annotation(Line(points = {{125.5, -80}, {150, -80}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(setCondition1.y, R2) annotation(Line(points = {{127.5, -140}, {150, -140}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(OnBouge.outPort[1], alternative.inPort) annotation(Line(points = {{-71.75, 17}, {-71.75, 2}, {-78.67, 2}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(setCondition2.y, or2.u1) annotation(Line(points = {{-40.5, -86}, {-36, -86}, {-36, -88}, {-30, -88}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(or2.y, timer.u) annotation(Line(points = {{-7, -88}, {0, -88}, {0, -78}, {8, -78}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(setCondition3.y, or2.u2) annotation(Line(points = {{-42.5, -102}, {-36, -102}, {-36, -96}, {-30, -96}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(OnMonte.outPort[1], transitionWithSignal.inPort) annotation(Line(points = {{8.5, 20}, {22, 20}, {22, 22}, {34, 22}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(setCondition4.y, transitionWithSignal.condition) annotation(Line(points = {{29.5, -2}, {34, -2}, {34, 10}, {38, 10}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(transitionWithSignal.outPort, alternative.join[1]) annotation(Line(points = {{39.5, 22}, {62, 22}, {62, 23}, {83.31, 23}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(OnDescend.outPort[1], transitionWithSignal1.inPort) annotation(Line(points = {{8.5, -20}, {22, -20}, {22, -18}, {36, -18}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(setCondition5.y, transitionWithSignal1.condition) annotation(Line(points = {{29.5, -50}, {36, -50}, {36, -30}, {40, -30}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(transitionWithSignal1.outPort, alternative.join[2]) annotation(Line(points = {{41.5, -18}, {62, -18}, {62, -19}, {83.31, -19}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-140, -160}, {140, 100}}), graphics={  Rectangle(extent = {{-40, 80}, {40, -80}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
              fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-10, 90}, {12, 70}}, lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-12, 93}, {13, 81}}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{-48, 78}, {-40, 62}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-48, 58}, {-40, 42}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-48, 18}, {-40, 2}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-48, 38}, {-40, 22}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-48, -22}, {-40, -38}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-48, -2}, {-40, -18}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-48, -62}, {-40, -78}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-48, -42}, {-40, -58}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, 78}, {48, 62}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, 58}, {48, 42}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, 18}, {48, 2}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, 38}, {48, 22}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, -22}, {48, -38}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, -2}, {48, -18}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, -62}, {48, -78}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{40, -42}, {48, -58}}, pattern = LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-140, 100}, {140, -160}}, lineColor = {0, 0, 255})}), Diagram(coordinateSystem(extent = {{-140, -160}, {140, 100}}, preserveAspectRatio = false), graphics));
  end MicroController;

  model MoteurDC_Ideal
    parameter Modelica.SIunits.Resistance Rmoteur = 0.35 "resistance moteur DC";
    parameter Modelica.SIunits.Inductance Lmoteur = 1e-5 "Inductance moteur DC";
    parameter Modelica.SIunits.ElectricalTorqueConstant Kmoteur = 0.018
      "Constante electromecanique moteur DC";
    parameter Modelica.SIunits.Inertia Jmoteur = 1.2e-5 "Inertie moteur DC";
    Modelica.Electrical.Analog.Basic.EMF emf(k = Kmoteur) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1
      "Right flange of shaft"                                                           annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                    annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
  equation
    connect(emf.n, n1) annotation(Line(points = {{0, -10}, {0, -100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(p1, emf.p) annotation(Line(points = {{0, 100}, {0, 10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(emf.flange, flange_b1) annotation(Line(points = {{10, 0}, {100, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{60, 10}, {100, -10}}, lineColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Ellipse(extent = {{-62, 62}, {62, -64}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{0, -90}, {0, 90}}, color = {0, 0, 0}, smooth = Smooth.None), Rectangle(extent = {{-8, 68}, {8, 62}}, lineColor = {0, 0, 0}, fillColor = {127, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-8, -64}, {8, -70}}, lineColor = {0, 0, 0}, fillColor = {127, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid)}));
  end MoteurDC_Ideal;

  model MoteurDC_Loss
    parameter Modelica.SIunits.Resistance Rmoteur = 0.35 "resistance moteur DC";
    parameter Modelica.SIunits.Inductance Lmoteur = 1e-5 "Inductance moteur DC";
    parameter Modelica.SIunits.ElectricalTorqueConstant Kmoteur = 0.018
      "Constante electromecanique moteur DC";
    parameter Modelica.SIunits.Inertia Jmoteur = 1.2e-5 "Inertie moteur DC";
    Modelica.Electrical.Analog.Basic.EMF emf(k = Kmoteur) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1
      "Right flange of shaft"                                                           annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                    annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 56})));
    Modelica.Mechanics.Rotational.Components.Damper damper annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {28, -10})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{18, -34}, {38, -14}})));
  equation
    connect(emf.n, n1) annotation(Line(points = {{0, -10}, {0, -100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(emf.flange, flange_b1) annotation(Line(points = {{10, 0}, {100, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(emf.p, resistor.n) annotation(Line(points = {{0, 10}, {0, 46}, {-1.77636e-015, 46}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor.p, p1) annotation(Line(points = {{1.77636e-015, 66}, {1.77636e-015, 88}, {0, 88}, {0, 100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(emf.flange, damper.flange_b) annotation(Line(points = {{10, 0}, {28, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(fixed.flange, damper.flange_a) annotation(Line(points = {{28, -24}, {28, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{60, 10}, {100, -10}}, lineColor = {0, 0, 0},
              fillPattern =                                                                                                    FillPattern.HorizontalCylinder), Ellipse(extent = {{-62, 62}, {62, -64}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{0, -90}, {0, 90}}, color = {0, 0, 0}, smooth = Smooth.None), Rectangle(extent = {{-8, 68}, {8, 62}}, lineColor = {0, 0, 0}, fillColor = {127, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-8, -64}, {8, -70}}, lineColor = {0, 0, 0}, fillColor = {127, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid)}));
  end MoteurDC_Loss;
  annotation(uses(Modelica(version = "3.2.1")));
end LeveVitre;
