package TorqueSensor "Mod?lisation d'un capteur de couple de direction assist?e"
  model InductiveSensor1
    Modelica.Electrical.Analog.Sensors.VoltageSensor Vout annotation(
      Placement(transformation(extent = {{16, 36}, {-4, 56}})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(transformation(extent = {{16, -10}, {36, 10}})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-60, 86})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 5, freqHz = 5e3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-28, 86})));
    InductiveSensorRef inductiveSensor1 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-28, 54})));
    Modelica.Electrical.Analog.Basic.Resistor R1(R = 10e3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {26, 62})));
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 10e3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {26, 26})));
    InductiveSensorVar inductiveSensorVar annotation(
      Placement(transformation(extent = {{-38, 18}, {-18, 38}})));
    Modelica.Mechanics.Rotational.Components.Spring spring(c = 100) annotation(
      Placement(visible = true, transformation(origin = {-100, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(
      Placement(transformation(extent = {{-110, -2}, {-90, 18}})));
    Modelica.Mechanics.Rotational.Sources.Position position annotation(
      Placement(transformation(extent = {{-132, 54}, {-112, 74}})));
    Modelica.Blocks.Sources.Step step(height = 0.01, startTime = 0.05) annotation(
      Placement(transformation(extent = {{-172, 54}, {-152, 74}})));
  equation
    connect(position.flange, spring.flange_a) annotation(
      Line(points = {{-112, 64}, {-100, 64}, {-100, 42}}));
    connect(fixed.flange, spring.flange_b) annotation(
      Line(points = {{-100, 8}, {-100, 22}}));
    connect(spring.flange_b, inductiveSensorVar.flange_b) annotation(
      Line(points = {{-100, 22}, {-69, 22}, {-69, 20}, {-38, 20}}));
    connect(spring.flange_a, inductiveSensorVar.flange_a) annotation(
      Line(points = {{-100, 42}, {-66, 42}, {-66, 36}, {-38, 36}}));
    connect(ground2.p, sineVoltage.n) annotation(
      Line(points = {{-50, 86}, {-38, 86}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R1.n, sineVoltage.p) annotation(
      Line(points = {{26, 72}, {26, 86}, {-18, 86}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.p, ground1.p) annotation(
      Line(points = {{26, 16}, {26, 10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.n, R1.p) annotation(
      Line(points = {{26, 36}, {26, 52}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vout.p, R2.n) annotation(
      Line(points = {{16, 46}, {26, 46}, {26, 36}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensor1.p1, sineVoltage.p) annotation(
      Line(points = {{-19, 59}, {-19, 76.5}, {-18, 76.5}, {-18, 86}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensor1.n1, Vout.n) annotation(
      Line(points = {{-19, 49}, {-19, 46}, {-4, 46}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensorVar.p1, inductiveSensor1.n1) annotation(
      Line(points = {{-17, 33}, {-17, 49}, {-19, 49}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensorVar.n1, ground1.p) annotation(
      Line(points = {{-17, 23}, {-17, 10}, {26, 10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(position.phi_ref, step.y) annotation(
      Line(points = {{-134, 64}, {-151, 64}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      uses(Modelica(version = "3.1")),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {100, 100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-200, -100}, {100, 100}})),
      experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 2e-06));
  end InductiveSensor1;

  model InductiveSensor2
    Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor annotation(
      Placement(transformation(extent = {{-34, 64}, {-14, 84}})));
    Modelica.Blocks.Math.Product product annotation(
      Placement(transformation(extent = {{10, -56}, {30, -36}})));
    Modelica.Blocks.Continuous.SecondOrder LowPassFilter(D = 0.7, w = 2 * 3.14 * 300) annotation(
      Placement(transformation(extent = {{42, -56}, {62, -36}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor Vout annotation(
      Placement(transformation(extent = {{-24, 4}, {-44, 24}})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(transformation(extent = {{-24, -42}, {-4, -22}})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-100, 54})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 5, freqHz = 5e3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-68, 54})));
    InductiveSensorRef inductiveSensor1 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-68, 22})));
    Modelica.Electrical.Analog.Basic.Resistor R1(R = 10e3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-14, 30})));
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 10e3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-14, -6})));
    InductiveSensorVar inductiveSensorVar annotation(
      Placement(transformation(extent = {{-78, -14}, {-58, 6}})));
    Modelica.Mechanics.Rotational.Components.Spring spring(c = 100) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-120, -2})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(
      Placement(transformation(extent = {{-130, -84}, {-110, -64}})));
    Modelica.Mechanics.Rotational.Sources.Position position annotation(
      Placement(transformation(extent = {{-162, 84}, {-142, 104}})));
    Modelica.Blocks.Sources.Step step(height = 0.01, startTime = 0.05) annotation(
      Placement(transformation(extent = {{-190, 84}, {-170, 104}})));
  equation
    connect(potentialSensor.phi, product.u1) annotation(
      Line(points = {{-13, 74}, {0, 74}, {0, -40}, {8, -40}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(product.y, LowPassFilter.u) annotation(
      Line(points = {{31, -46}, {40, -46}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(ground2.p, sineVoltage.n) annotation(
      Line(points = {{-90, 54}, {-78, 54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R1.n, sineVoltage.p) annotation(
      Line(points = {{-14, 40}, {-14, 54}, {-58, 54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.p, ground1.p) annotation(
      Line(points = {{-14, -16}, {-14, -22}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.n, R1.p) annotation(
      Line(points = {{-14, 4}, {-14, 20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vout.p, R2.n) annotation(
      Line(points = {{-24, 14}, {-14, 14}, {-14, 4}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensor1.p1, sineVoltage.p) annotation(
      Line(points = {{-59, 27}, {-59, 44.5}, {-58, 44.5}, {-58, 54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensor1.n1, Vout.n) annotation(
      Line(points = {{-59, 17}, {-59, 14}, {-44, 14}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensorVar.p1, inductiveSensor1.n1) annotation(
      Line(points = {{-57, 1}, {-57, 17}, {-59, 17}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductiveSensorVar.n1, ground1.p) annotation(
      Line(points = {{-57, -9}, {-57, -22}, {-14, -22}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(spring.flange_a, inductiveSensorVar.flange_a) annotation(
      Line(points = {{-120, 8}, {-96, 8}, {-96, 4}, {-78, 4}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(spring.flange_b, inductiveSensorVar.flange_b) annotation(
      Line(points = {{-120, -12}, {-78, -12}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(fixed.flange, spring.flange_b) annotation(
      Line(points = {{-120, -74}, {-120, -12}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(position.flange, spring.flange_a) annotation(
      Line(points = {{-142, 94}, {-120, 94}, {-120, 8}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(position.phi_ref, step.y) annotation(
      Line(points = {{-164, 94}, {-169, 94}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(potentialSensor.p, sineVoltage.p) annotation(
      Line(points = {{-34, 74}, {-54, 74}, {-54, 54}, {-58, 54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(product.u2, Vout.v) annotation(
      Line(points = {{8, -52}, {-34, -52}, {-34, 4}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      uses(Modelica(version = "3.1")),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {100, 100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-200, -100}, {100, 100}})),
  experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 2e-06));
  end InductiveSensor2;

  model InductiveSensorRef
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N = 1000) annotation(
      Placement(transformation(extent = {{40, -54}, {20, -34}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 30) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {50, 50})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1 "Positive pin (potential p.v > n.v for positive voltage drop v)" annotation(
      Placement(transformation(extent = {{80, 40}, {100, 60}}), iconTransformation(extent = {{80, 40}, {100, 60}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 "Negative electric pin" annotation(
      Placement(transformation(extent = {{80, -60}, {100, -40}}), iconTransformation(extent = {{80, -60}, {100, -40}})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground annotation(
      Placement(transformation(extent = {{10, -80}, {30, -60}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux RadialIron1(nonLinearPermeability = false, mu_rConst = 1000, l = 2e-3, r_i = 16.5e-3, r_o = 21.5e-3) annotation(
      Placement(transformation(extent = {{-22, 50}, {-2, 70}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux AirGap1(nonLinearPermeability = false, mu_rConst = 1, l = 2e-3, r_i = 15e-3, r_o = 16.5e-3) annotation(
      Placement(transformation(extent = {{-60, 50}, {-40, 70}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux AxialIron2(l = 10e-3, r_i = 12e-3, r_o = 15e-3, nonLinearPermeability = false, mu_rConst = 1000) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-80, 0})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux AxialIron1(l = 10e-3, r_i = 21.5e-3, r_o = 23.5e-3, nonLinearPermeability = false, mu_rConst = 1000) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {20, 0})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux RadialIron2(nonLinearPermeability = false, mu_rConst = 1000, l = 2e-3, r_i = 16.5e-3, r_o = 21.5e-3) annotation(
      Placement(transformation(extent = {{-22, -70}, {-2, -50}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux AirGap2(nonLinearPermeability = false, mu_rConst = 1, l = 2e-3, r_i = 15e-3, r_o = 16.5e-3) annotation(
      Placement(transformation(extent = {{-60, -70}, {-40, -50}})));
  equation
    connect(ground.port, converter.port_n) annotation(
      Line(points = {{20, -60}, {20, -50}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(n1, n1) annotation(
      Line(points = {{90, -50}, {90, -50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(p1, resistor.p) annotation(
      Line(points = {{90, 50}, {60, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(converter.p, resistor.n) annotation(
      Line(points = {{40, -38}, {40, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(converter.n, n1) annotation(
      Line(points = {{40, -50}, {90, -50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(AxialIron1.port_n, RadialIron1.port_n) annotation(
      Line(points = {{20, 10}, {20, 60}, {-2, 60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(RadialIron1.port_p, AirGap1.port_n) annotation(
      Line(points = {{-22, 60}, {-40, 60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(AirGap1.port_p, AxialIron2.port_n) annotation(
      Line(points = {{-60, 60}, {-80, 60}, {-80, 10}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(converter.port_p, AxialIron1.port_p) annotation(
      Line(points = {{20, -38}, {20, -10}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(RadialIron2.port_n, ground.port) annotation(
      Line(points = {{-2, -60}, {20, -60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(AirGap2.port_n, RadialIron2.port_p) annotation(
      Line(points = {{-40, -60}, {-22, -60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(AirGap2.port_p, AxialIron2.port_p) annotation(
      Line(points = {{-60, -60}, {-80, -60}, {-80, -10}}, color = {255, 127, 0}, smooth = Smooth.None));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-20, 80}, {0, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{60, 60}, {80, -60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, 60}, {60, -60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.CrossDiag), Rectangle(extent = {{20, 80}, {80, 60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, -60}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{60, 50}, {100, 50}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{60, -50}, {100, -50}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-60, 100}, {-60, -100}}, color = {0, 0, 255}, smooth = Smooth.None, pattern = LinePattern.DashDot), Line(points = {{-20, 80}, {-60, 80}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-20, -80}, {-60, -80}}, color = {0, 0, 255}, smooth = Smooth.None)}));
  end InductiveSensorRef;

  model InductiveSensorVar
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N = 1000) annotation(
      Placement(transformation(extent = {{60, -54}, {40, -34}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 30) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {70, 50})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1 "Positive pin (potential p.v > n.v for positive voltage drop v)" annotation(
      Placement(transformation(extent = {{100, 40}, {120, 60}}), iconTransformation(extent = {{100, 40}, {120, 60}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 "Negative electric pin" annotation(
      Placement(transformation(extent = {{100, -60}, {120, -40}}), iconTransformation(extent = {{100, -60}, {120, -40}})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground annotation(
      Placement(transformation(extent = {{30, -80}, {50, -60}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux RadialIron1(nonLinearPermeability = false, mu_rConst = 1000, l = 2e-3, r_i = 16.5e-3, r_o = 21.5e-3) annotation(
      Placement(transformation(extent = {{-2, 50}, {18, 70}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux AirGap1(nonLinearPermeability = false, mu_rConst = 1, l = 2e-3, r_o = 16.5e-3, r_i = 16e-3) annotation(
      Placement(transformation(extent = {{-40, 50}, {-20, 70}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux AxialIron2(r_i = 12e-3, r_o = 15e-3, nonLinearPermeability = false, mu_rConst = 1000, l = 5e-3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, 38})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux AxialIron1(l = 10e-3, r_i = 21.5e-3, r_o = 23.5e-3, nonLinearPermeability = false, mu_rConst = 1000) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, 0})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux RadialIron2(nonLinearPermeability = false, mu_rConst = 1000, l = 2e-3, r_i = 16.5e-3, r_o = 21.5e-3) annotation(
      Placement(transformation(extent = {{-2, -70}, {18, -50}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux AirGap2(nonLinearPermeability = false, mu_rConst = 1, l = 2e-3, r_o = 16.5e-3, r_i = 16e-3) annotation(
      Placement(transformation(extent = {{-40, -70}, {-20, -50}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(
      Placement(transformation(extent = {{-110, 70}, {-90, 90}}), iconTransformation(extent = {{-110, 70}, {-90, 90}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(
      Placement(transformation(extent = {{-110, -90}, {-90, -70}}), iconTransformation(extent = {{-110, -90}, {-90, -70}})));
    HollowCylinderAxialFluxVariable AxialTorqueSensor(r_i = 12e-3, r_o = 15e-3, nonLinearPermeability = false, mu_rConst = 1, l = 0.4e-3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, 0})));
    Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngleSensor annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-100, 0})));
  equation
    connect(ground.port, converter.port_n) annotation(
      Line(points = {{40, -60}, {40, -50}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(n1, n1) annotation(
      Line(points = {{110, -50}, {107, -50}, {107, -50}, {110, -50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(p1, resistor.p) annotation(
      Line(points = {{110, 50}, {80, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(converter.p, resistor.n) annotation(
      Line(points = {{60, -38}, {60, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(converter.n, n1) annotation(
      Line(points = {{60, -50}, {110, -50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(AxialIron1.port_n, RadialIron1.port_n) annotation(
      Line(points = {{40, 10}, {40, 60}, {18, 60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(RadialIron1.port_p, AirGap1.port_n) annotation(
      Line(points = {{-2, 60}, {-20, 60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(AirGap1.port_p, AxialIron2.port_n) annotation(
      Line(points = {{-40, 60}, {-60, 60}, {-60, 48}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(converter.port_p, AxialIron1.port_p) annotation(
      Line(points = {{40, -38}, {40, -10}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(RadialIron2.port_n, ground.port) annotation(
      Line(points = {{18, -60}, {40, -60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(AirGap2.port_n, RadialIron2.port_p) annotation(
      Line(points = {{-20, -60}, {-2, -60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(AxialTorqueSensor.port_n, AxialIron2.port_p) annotation(
      Line(points = {{-60, 10}, {-60, 28}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(AxialTorqueSensor.port_p, AirGap2.port_p) annotation(
      Line(points = {{-60, -10}, {-60, -60}, {-40, -60}}, color = {255, 127, 0}, smooth = Smooth.None));
    connect(relAngleSensor.flange_a, flange_a) annotation(
      Line(points = {{-100, 10}, {-100, 80}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(relAngleSensor.flange_b, flange_b) annotation(
      Line(points = {{-100, -10}, {-100, -80}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(relAngleSensor.phi_rel, AxialTorqueSensor.Teta) annotation(
      Line(points = {{-89, 0}, {-70, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-20, 80}, {0, 2}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{60, 60}, {80, -60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, 60}, {60, -60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.CrossDiag), Rectangle(extent = {{20, 80}, {80, 60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{20, -60}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{60, 50}, {100, 50}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{60, -50}, {100, -50}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-60, 100}, {-60, -100}}, color = {0, 0, 255}, smooth = Smooth.None, pattern = LinePattern.DashDot), Line(points = {{-20, 80}, {-90, 80}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-20, -80}, {-90, -80}}, color = {0, 0, 255}, smooth = Smooth.None), Rectangle(extent = {{-20, -2}, {0, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-20, 24}, {-12, 2}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-8, -2}, {0, -24}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
  end InductiveSensorVar;

  model HollowCylinderAxialFluxVariable "(Hollow) cylinder with axial flux; fixed shape; linear or non-linear material characteristics"
    extends Modelica.Magnetic.FluxTubes.Interfaces.PartialFixedShape;
    parameter Integer N = 10 "Poles numbers";
    parameter Modelica.SIunits.Length l = 0.01 "Axial length (in direction of flux)" annotation(
      Dialog(group = "Fixed geometry", groupImage = "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png"));
    parameter Modelica.SIunits.Radius r_i = 0 "Inner radius of hollow cylinder (zero for cylinder)" annotation(
      Dialog(group = "Fixed geometry"));
    parameter Modelica.SIunits.Radius r_o = 0.01 "Outer radius of (hollow) cylinder" annotation(
      Dialog(group = "Fixed geometry"));
    Modelica.Blocks.Interfaces.RealInput Teta annotation(
      Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 100})));
  equation
    A = Modelica.Constants.pi * (r_o ^ 2 - r_i ^ 2) * (1 / 4 + N * Teta / 2 / Modelica.Constants.pi);
    G_m = Modelica.Constants.mue_0 * mu_r * A / l;
    annotation(
      Documentation(info = "<html>
<p>
Please refer to the enclosing sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a> for a description of all elements of this package and to <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a> for derivation and/or coefficients of the equation for permeance G_m.
</p>

<p>
Set the inner radius r_i=0 for modelling of a solid cylindric flux tube.
</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-70, 30}, {70, -30}}, lineColor = {255, 128, 0}, fillColor = {255, 170, 85}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-40, 30}, {-6, 6}}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{4, -6}, {38, -30}}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{-6, 30}, {4, -30}}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, pattern = LinePattern.None)}),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end HollowCylinderAxialFluxVariable;
  annotation(
    uses(Modelica(version = "3.2.1")));
end TorqueSensor;
