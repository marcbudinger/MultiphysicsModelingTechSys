package Chap2_PerturbationsCEM
  model CouplageImpedanceCommune
    Modelica.Electrical.Analog.Basic.Ground ground annotation (
      Placement(transformation(extent = {{-70, 8}, {-50, 28}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 60e-9) annotation (
      Placement(transformation(extent = {{0, 78}, {20, 98}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 100e-3) annotation (
      Placement(transformation(extent = {{-38, 78}, {-18, 98}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 5) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-60, 58})));
    Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent(I = 3e-3, freqHz = 100e6, offset = 3e-3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {40, 60})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
      Placement(transformation(extent = {{-90, -100}, {-70, -80}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 60e-9) annotation (
      Placement(transformation(extent = {{-20, -30}, {0, -10}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 100e-3) annotation (
      Placement(transformation(extent = {{-58, -30}, {-38, -10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 5) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-80, -50})));
    Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent1(I = 3e-3, freqHz = 100e6, offset = 3e-3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {40, -48})));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 100e-9, v(start = 5 - 3e-4)) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {20, -48})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {72, 58})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1 annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {72, -48})));
  equation
    connect(ground.p, constantVoltage.n) annotation (
      Line(points = {{-60, 28}, {-60, 48}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(constantVoltage.p, resistor.p) annotation (
      Line(points = {{-60, 68}, {-60, 88}, {-38, 88}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor.n, inductor.p) annotation (
      Line(points = {{-18, 88}, {0, 88}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineCurrent.p, inductor.n) annotation (
      Line(points = {{40, 70}, {40, 88}, {20, 88}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineCurrent.n, ground.p) annotation (
      Line(points = {{40, 50}, {40, 28}, {-60, 28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground1.p, constantVoltage1.n) annotation (
      Line(points = {{-80, -80}, {-80, -60}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(constantVoltage1.p, resistor1.p) annotation (
      Line(points = {{-80, -40}, {-80, -20}, {-58, -20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor1.n, inductor1.p) annotation (
      Line(points = {{-38, -20}, {-20, -20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineCurrent1.p, inductor1.n) annotation (
      Line(points = {{40, -38}, {40, -20}, {0, -20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineCurrent1.n, ground1.p) annotation (
      Line(points = {{40, -58}, {40, -80}, {-80, -80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(capacitor.p, inductor1.n) annotation (
      Line(points = {{20, -38}, {20, -20}, {0, -20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(capacitor.n, ground1.p) annotation (
      Line(points = {{20, -58}, {20, -80}, {-80, -80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor.p, inductor.n) annotation (
      Line(points = {{72, 68}, {72, 88}, {20, 88}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor.n, ground.p) annotation (
      Line(points = {{72, 48}, {72, 28}, {-60, 28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor1.p, inductor1.n) annotation (
      Line(points = {{72, -38}, {72, -20}, {0, -20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor1.n, ground1.p) annotation (
      Line(points = {{72, -58}, {72, -80}, {-80, -80}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
      experiment(StopTime = 1e-06, StartTime = 0, Tolerance = 1e-06, Interval = 2e-10));
  end CouplageImpedanceCommune;

  model CouplageInductifCablePlat_sinus
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
      Placement(visible = true, transformation(extent = {{-70, -50}, {-50, -30}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 100) annotation (
      Placement(transformation(extent = {{-68, 50}, {-48, 70}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 100) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, 18})));
    Modelica.Electrical.Analog.Basic.Transformer transformer(L1 = 10e-6, L2 = 10e-6, M = 9e-6) annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-8, 50})));
    Modelica.Electrical.Analog.Basic.Resistor resistor3(R = 10e3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {68, 8})));
    Modelica.Electrical.Analog.Basic.Resistor resistor4(R = 10e3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {48, 8})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(V=5, freqHz=1e6)
                                                                                     annotation (
      Placement(visible = true, transformation(origin={-90,18},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(resistor3.n, ground1.p) annotation (
      Line(points = {{68, -2}, {68, -30}, {-60, -30}}, color = {0, 0, 255}));
    connect(resistor4.n, ground1.p) annotation (
      Line(points = {{48, -2}, {48, -30}, {-60, -30}}, color = {0, 0, 255}));
    connect(resistor2.p, ground1.p) annotation (
      Line(points = {{-60, 8}, {-60, -30}}, color = {0, 0, 255}));
    connect(transformer.p1, resistor1.n) annotation (
      Line(points = {{-13, 60}, {-48, 60}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor2.n, transformer.p2) annotation (
      Line(points = {{-60, 28}, {-60, 40}, {-13, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor4.p, transformer.n2) annotation (
      Line(points = {{48, 18}, {46, 18}, {46, 40}, {-3, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor3.p, transformer.n1) annotation (
      Line(points = {{68, 18}, {68, 60}, {-3, 60}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineVoltage1.p, resistor1.p)
      annotation (Line(points={{-90,28},{-90,60},{-68,60}}, color={0,0,255}));
    connect(ground1.p, sineVoltage1.n)
      annotation (Line(points={{-60,-30},{-90,-30},{-90,8}}, color={0,0,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      experiment(StopTime = 1e-05, StartTime = 0, Tolerance = 1e-06, Interval = 2e-09),
      __Dymola_experimentSetupOutput);
  end CouplageInductifCablePlat_sinus;

  model CouplageInductifCablePlat_creneaux
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
      Placement(visible = true, transformation(extent = {{-70, -50}, {-50, -30}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 100) annotation (
      Placement(transformation(extent = {{-68, 50}, {-48, 70}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 100) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, 18})));
    Modelica.Electrical.Analog.Basic.Transformer transformer(L1 = 10e-6, L2 = 10e-6, M = 9e-6) annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-8, 50})));
    Modelica.Electrical.Analog.Basic.Resistor resistor3(R = 10e3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {68, 8})));
    Modelica.Electrical.Analog.Basic.Resistor resistor4(R = 10e3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {48, 8})));
    Modelica.Electrical.Analog.Sources.PulseVoltage pulseVoltage(
      V=5,
      width=50,
      period=1e-6)                                                                   annotation (
      Placement(visible = true, transformation(origin={-86,16},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(resistor3.n, ground1.p) annotation (
      Line(points = {{68, -2}, {68, -30}, {-60, -30}}, color = {0, 0, 255}));
    connect(resistor4.n, ground1.p) annotation (
      Line(points = {{48, -2}, {48, -30}, {-60, -30}}, color = {0, 0, 255}));
    connect(resistor2.p, ground1.p) annotation (
      Line(points = {{-60, 8}, {-60, -30}}, color = {0, 0, 255}));
    connect(transformer.p1, resistor1.n) annotation (
      Line(points = {{-13, 60}, {-48, 60}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor2.n, transformer.p2) annotation (
      Line(points = {{-60, 28}, {-60, 40}, {-13, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor4.p, transformer.n2) annotation (
      Line(points = {{48, 18}, {46, 18}, {46, 40}, {-3, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor3.p, transformer.n1) annotation (
      Line(points = {{68, 18}, {68, 60}, {-3, 60}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pulseVoltage.p, resistor1.p)
      annotation (Line(points={{-86,26},{-86,60},{-68,60}}, color={0,0,255}));
    connect(ground1.p, pulseVoltage.n)
      annotation (Line(points={{-60,-30},{-86,-30},{-86,6}}, color={0,0,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      experiment(StopTime = 1e-05, StartTime = 0, Tolerance = 1e-06, Interval = 2e-09),
      __Dymola_experimentSetupOutput);
  end CouplageInductifCablePlat_creneaux;

  model PerturbationChampMagnetique
    Modelica.Electrical.Analog.Sources.PulseVoltage pulseVoltage(width = 50, period = 1e-4, V = 5) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-122, 60})));
    Modelica.Electrical.Analog.Basic.Resistor EmetteurLigne(R = 100) annotation (
      Placement(transformation(extent = {{-106, 70}, {-86, 90}})));
    Modelica.Electrical.Analog.Basic.Resistor Recepteur(R = 10e3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-44, 62})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (
      Placement(transformation(extent = {{-132, 10}, {-112, 30}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage_perturbations(V = 1, freqHz = 100e3) annotation (
      Placement(transformation(extent = {{-78, 70}, {-58, 90}})));
    Modelica.Electrical.Analog.Sources.PulseCurrent pulseCurrent(width = 50, period = 1e-4, I = -10e-3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 60})));
    Modelica.Electrical.Analog.Basic.Resistor Ligne(R = 10) annotation (
      Placement(transformation(extent = {{34, 70}, {54, 90}})));
    Modelica.Electrical.Analog.Basic.Resistor CurrentToVoltage(R = 500) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {116, 78})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
      Placement(transformation(extent = {{-10, 10}, {10, 30}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage_perturbations1(V = 1, freqHz = 100e3) annotation (
      Placement(transformation(extent = {{60, 70}, {80, 90}})));
    Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin idealOpAmp3Pin annotation (
      Placement(transformation(extent = {{104, 44}, {124, 64}})));
    Modelica.Electrical.Analog.Basic.Resistor ImperfectionSourceCourant(R = 1e5) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {20, 58})));
    Modelica.Electrical.Analog.Sources.PulseVoltage pulseVoltage2(width = 50, period = 1e-4, V = 5 / 2) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, -62})));
    Modelica.Electrical.Analog.Basic.Resistor EmetteurLigne1(R = 100) annotation (
      Placement(transformation(extent = {{-54, -38}, {-34, -18}})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
      Placement(transformation(extent = {{-130, -72}, {-110, -52}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage_perturbations2(V = 1, freqHz = 100e3) annotation (
      Placement(transformation(extent = {{-26, -38}, {-6, -18}})));
    Modelica.Electrical.Analog.Basic.Resistor EmetteurLigne2(R = 100) annotation (
      Placement(transformation(extent = {{-54, -84}, {-34, -64}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage_perturbations3(V = 1, freqHz = 100e3) annotation (
      Placement(transformation(extent = {{-26, -84}, {-6, -64}})));
    Modelica.Electrical.Analog.Sources.PulseVoltage pulseVoltage3(width = 50, period = 1e-4, V = 5 / 2) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, -40})));
    DifferentialAmplifier differentialAmplifier annotation (
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {34, -52})));
    Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor annotation (
      Placement(transformation(extent = {{30, -38}, {50, -18}})));
    Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor1 annotation (
      Placement(transformation(extent = {{30, -84}, {50, -64}})));
  equation
    connect(pulseVoltage.p, EmetteurLigne.p) annotation (
      Line(points = {{-122, 70}, {-122, 80}, {-106, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(EmetteurLigne.n, sineVoltage_perturbations.p) annotation (
      Line(points = {{-86, 80}, {-78, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineVoltage_perturbations.n, Recepteur.p) annotation (
      Line(points = {{-58, 80}, {-44, 80}, {-44, 72}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Recepteur.n, ground.p) annotation (
      Line(points = {{-44, 52}, {-44, 30}, {-122, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground.p, pulseVoltage.n) annotation (
      Line(points = {{-122, 30}, {-122, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Ligne.n, sineVoltage_perturbations1.p) annotation (
      Line(points = {{54, 80}, {60, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pulseCurrent.n, Ligne.p) annotation (
      Line(points = {{0, 70}, {0, 80}, {34, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pulseCurrent.p, ground1.p) annotation (
      Line(points = {{0, 50}, {0, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealOpAmp3Pin.in_p, ground1.p) annotation (
      Line(points = {{104, 49}, {52, 49}, {52, 30}, {0, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ImperfectionSourceCourant.p, Ligne.p) annotation (
      Line(points = {{20, 68}, {20, 80}, {34, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ImperfectionSourceCourant.n, ground1.p) annotation (
      Line(points = {{20, 48}, {20, 30}, {0, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealOpAmp3Pin.in_n, CurrentToVoltage.p) annotation (
      Line(points = {{104, 59}, {104, 78}, {106, 78}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(CurrentToVoltage.n, idealOpAmp3Pin.out) annotation (
      Line(points = {{126, 78}, {126, 54}, {124, 54}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineVoltage_perturbations1.n, idealOpAmp3Pin.in_n) annotation (
      Line(points = {{80, 80}, {80, 59}, {104, 59}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(EmetteurLigne1.n, sineVoltage_perturbations2.p) annotation (
      Line(points = {{-34, -28}, {-26, -28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(EmetteurLigne2.p, pulseVoltage2.n) annotation (
      Line(points = {{-54, -74}, {-90, -74}, {-90, -72}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sineVoltage_perturbations3.p, EmetteurLigne2.n) annotation (
      Line(points = {{-26, -74}, {-34, -74}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pulseVoltage2.p, pulseVoltage3.n) annotation (
      Line(points = {{-90, -52}, {-90, -50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pulseVoltage3.p, EmetteurLigne1.p) annotation (
      Line(points = {{-90, -30}, {-90, -28}, {-54, -28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground2.p, pulseVoltage2.p) annotation (
      Line(points = {{-120, -52}, {-90, -52}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(differentialAmplifier.Vin_p, sineVoltage_perturbations2.n) annotation (
      Line(points = {{24, -44}, {10, -44}, {10, -28}, {-6, -28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(differentialAmplifier.Vin_n, sineVoltage_perturbations3.n) annotation (
      Line(points = {{24, -60}, {10, -60}, {10, -74}, {-6, -74}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(potentialSensor.p, sineVoltage_perturbations2.n) annotation (
      Line(points = {{30, -28}, {-6, -28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(potentialSensor1.p, sineVoltage_perturbations3.n) annotation (
      Line(points = {{30, -74}, {-6, -74}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-140, -100}, {160, 100}}, initialScale = 0.1), graphics={  Text(extent = {{-132, 102}, {-98, 86}}, textString = "Ligne simple"), Text(extent = {{-24, 116}, {68, 74}}, textString = "Transmission par source de courant"), Text(extent = {{-130, 12}, {-38, -30}}, textString = "Transmission par paire différentielle")}),
      Icon(coordinateSystem(extent = {{-140, -100}, {160, 100}})),
      experiment(StartTime = 0, StopTime = 1e-3, Tolerance = 1e-06, Interval = 2e-07));
  end PerturbationChampMagnetique;

  model PerturbationChampElectrique
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 1e-9) annotation (
      Placement(visible = true, transformation(origin = {-66, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = 2e-9) annotation (
      Placement(visible = true, transformation(origin = {-66, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 50) annotation (
      Placement(visible = true, transformation(extent = {{-102, 60}, {-82, 80}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.PulseVoltage pulseVoltage(width = 50, period = 1e-4, V = 5) annotation (
      Placement(visible = true, transformation(origin = {-116, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor EmetteurLigne(R = 100) annotation (
      Placement(visible = true, transformation(extent = {{-102, -4}, {-82, 16}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Recepteur(R = 10e3) annotation (
      Placement(visible = true, transformation(origin = {-40, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (
      Placement(visible = true, transformation(origin = {-116, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
      Placement(visible = true, transformation(extent = {{-126, 0}, {-106, 20}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage trapezoidVoltage(V = 1000, falling = 20e-9, nperiod = 10, period = 1.89e-4, rising = 20e-9, width = 1e-4) annotation (
      Placement(visible = true, transformation(origin = {-116, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
      Placement(visible = true, transformation(origin = {28, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor Recepteur1(R = 10e3) annotation (
      Placement(visible = true, transformation(origin = {104, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Sources.PulseVoltage pulseVoltage1(V = 5, period = 1e-4, width = 50)  annotation (
      Placement(visible = true, transformation(origin = {28, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2(C = 2e-9) annotation (
      Placement(visible = true, transformation(origin = {78, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation (
      Placement(visible = true, transformation(extent = {{18, 8}, {38, 28}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor EmetteurLigne1(R = 100) annotation (
      Placement(visible = true, transformation(extent = {{44, -2}, {64, 18}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage trapezoidVoltage1(V = 1000, falling = 20e-9, nperiod = 10, period = 1.89e-4, rising = 20e-9, width = 1e-4)  annotation (
      Placement(visible = true, transformation(origin = {28, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor3(C = 1e-9) annotation (
      Placement(visible = true, transformation(origin = {78, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Resistor resistor3(R = 50) annotation (
      Placement(visible = true, transformation(extent = {{40, 60}, {60, 80}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor4(C=2e-9)
                                                        annotation (
      Placement(visible = true, transformation(origin = {78, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground4 annotation (
      Placement(visible = true, transformation(origin={108,42},    extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    connect(capacitor4.n, Recepteur1.p) annotation (
      Line(points = {{78, 22}, {78, 22}, {78, 8}, {104, 8}, {104, -8}, {104, -8}}, color = {0, 0, 255}));
    connect(capacitor3.n, capacitor4.p) annotation (
      Line(points = {{78, 50}, {78, 42}}, color = {0, 0, 255}));
    connect(pulseVoltage1.p, EmetteurLigne1.p) annotation (
      Line(points = {{28, -6}, {28, 8}, {44, 8}}, color = {0, 0, 255}));
    connect(ground2.p, pulseVoltage1.n) annotation (
      Line(points = {{28, -44}, {28, -26}}, color = {0, 0, 255}));
    connect(ground3.p, trapezoidVoltage1.n) annotation (
      Line(points = {{28, 28}, {28, 34}}, color = {0, 0, 255}));
    connect(Recepteur.n, ground.p) annotation (
      Line(points = {{-40, -32}, {-40, -50}, {-116, -50}}, color = {0, 0, 255}));
    connect(capacitor1.n, ground.p) annotation (
      Line(points = {{-66, -30}, {-66, -50}, {-116, -50}}, color = {0, 0, 255}));
    connect(ground.p, pulseVoltage.n) annotation (
      Line(points = {{-116, -50}, {-116, -28}}, color = {0, 0, 255}));
    connect(Recepteur1.n, ground2.p) annotation (
      Line(points = {{104, -28}, {104, -44}, {28, -44}}, color = {0, 0, 255}));
    connect(capacitor2.n, ground2.p) annotation (
      Line(points = {{78, -26}, {78, -44}, {28, -44}}, color = {0, 0, 255}));
    connect(trapezoidVoltage1.p, resistor3.p) annotation (
      Line(points = {{28, 54}, {28, 70}, {40, 70}}, color = {0, 0, 255}));
    connect(ground1.p, trapezoidVoltage.n) annotation (
      Line(points={{-116,20},{-116,26}},      color = {0, 0, 255}));
    connect(resistor3.n, capacitor3.p) annotation (
      Line(points = {{60, 70}, {78, 70}}, color = {0, 0, 255}));
    connect(Recepteur.p, EmetteurLigne.n) annotation (
      Line(points={{-40,-12},{-40,6},{-82,6}},       color = {0, 0, 255}));
    connect(capacitor.n, Recepteur.p) annotation (
      Line(points={{-66,26},{-66,6},{-40,6},{-40,-12}},         color = {0, 0, 255}));
    connect(EmetteurLigne.n, capacitor1.p) annotation (
      Line(points = {{-82, 6}, {-66, 6}, {-66, -10}}, color = {0, 0, 255}));
    connect(EmetteurLigne1.n, Recepteur1.p) annotation (
      Line(points = {{64, 8}, {104, 8}, {104, -8}}, color = {0, 0, 255}));
    connect(EmetteurLigne1.n, capacitor2.p) annotation (
      Line(points = {{64, 8}, {78, 8}, {78, -6}}, color = {0, 0, 255}));
    connect(pulseVoltage.p, EmetteurLigne.p) annotation (
      Line(points = {{-116, -8}, {-116, 6}, {-102, 6}}, color = {0, 0, 255}));
    connect(resistor.n, capacitor.p) annotation (
      Line(points = {{-82, 70}, {-66, 70}, {-66, 46}}, color = {0, 0, 255}));
    connect(trapezoidVoltage.p, resistor.p) annotation (
      Line(points = {{-116, 46}, {-116, 46}, {-116, 70}, {-102, 70}, {-102, 70}}, color = {0, 0, 255}));
    connect(ground4.p, capacitor4.p)
      annotation (Line(points={{98,42},{78,42}}, color={0,0,255}));
    annotation (
      Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}}, preserveAspectRatio = false), graphics={  Text(origin = {-144, 30}, extent = {{12, 78}, {88, 38}}, textString = "Perturbation par champ electrique"), Text(origin = {0, 32}, extent = {{12, 78}, {88, 38}}, textString = "Perturbation par champ electrique avec blindage")}),
      experiment(StartTime = 0, StopTime = 0.001, Tolerance = 1e-06, Interval = 2e-07),
      Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}}, preserveAspectRatio = false)),
      __OpenModelica_commandLineOptions = "");
  end PerturbationChampElectrique;

  model DifferentialAmplifier
    parameter Real A = 10 "Amplication of the differential amplifier";
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 50e3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {20, -18})));
    Modelica.Electrical.Analog.Basic.Resistor R3(R = 50e3) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {20, 28})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vout "Output pin" annotation (
      Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vin_p "Positive pin (potential p.v > n.v for positive voltage drop v)" annotation (
      Placement(transformation(extent = {{-110, 70}, {-90, 90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vin_n "Positive pin (potential p.v > n.v for positive voltage drop v)" annotation (
      Placement(transformation(extent = {{-110, -90}, {-90, -70}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (
      Placement(transformation(extent = {{10, -56}, {30, -36}})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {20, 58})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {42, 2})));
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {70, 2})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
      Placement(transformation(extent = {{60, -36}, {80, -16}})));
  equation
    connect(ground.p, R2.n) annotation (
      Line(points = {{20, -36}, {20, -28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.p, Vin_n) annotation (
      Line(points = {{20, -8}, {-40, -8}, {-40, -80}, {-100, -80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R3.n, ground1.p) annotation (
      Line(points = {{20, 38}, {20, 48}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R3.p, Vin_p) annotation (
      Line(points = {{20, 18}, {-40, 18}, {-40, 80}, {-100, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor.p, R3.p) annotation (
      Line(points = {{42, 12}, {32, 12}, {32, 18}, {20, 18}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor.n, R2.p) annotation (
      Line(points = {{42, -8}, {20, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(signalVoltage.v, voltageSensor.v) annotation (
      Line(points = {{63, 2}, {52, 2}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(ground2.p, signalVoltage.n) annotation (
      Line(points = {{70, -16}, {70, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(signalVoltage.p, Vout) annotation (
      Line(points = {{70, 12}, {100, 12}, {100, 0}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
      Icon(graphics={  Line(points = {{-60, 80}, {-60, -80}, {60, 0}, {-60, 80}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-58, 42}, {24, -34}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "A2"), Line(points = {{60, 0}, {98, 0}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-90, 80}, {-80, 80}, {-80, 60}, {-60, 60}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-90, -80}, {-80, -80}, {-80, -60}, {-60, -60}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-116, 76}, {-84, 48}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "+"), Text(extent = {{-116, -48}, {-84, -76}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "-")}));
  end DifferentialAmplifier;
  annotation (
    uses(Modelica(version="3.2.2")));
end Chap2_PerturbationsCEM;
