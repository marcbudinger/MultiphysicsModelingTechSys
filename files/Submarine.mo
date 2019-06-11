model Submarine_v1
  Modelica.Mechanics.Rotational.Components.Inertia Inertie_Helice(J = 150e3) annotation(
    Placement(visible = true, transformation(extent = {{-82, -10}, {-62, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque Couple_Poussee(TorqueDirection = false, tau_nominal = -1.75e5, w_nominal = 120 * 2 * 3.14 / 60) annotation(
    Placement(visible = true, transformation(extent = {{-114, -10}, {-94, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.BearingFriction Frottement_Sec(peak = 1, tau_pos = [0, 9000]) annotation(
    Placement(visible = true, transformation(extent = {{-50, -10}, {-30, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.SpringDamper RaideurFrott_Arbre(c = 6.5e6, d = 25000) annotation(
    Placement(visible = true, transformation(extent = {{-18, -10}, {2, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia Inertie_Motor(J = 3e3) annotation(
    Placement(visible = true, transformation(origin = {24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Damper Frott_Visq_Mot(d = 10) annotation(
    Placement(visible = true, transformation(origin = {52, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.EMF Moteur_Parfait(k = 700 / (120 * 2 * 3.14 / 60)) annotation(
    Placement(visible = true, transformation(extent = {{88, -10}, {68, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 8e-3) annotation(
    Placement(transformation(extent = {{88, 34}, {108, 54}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(extent = {{42, -40}, {62, -20}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 20e-3) annotation(
    Placement(transformation(extent = {{120, 34}, {140, 54}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table = [0, 0; 200, 700; 400, 700; 400, 0; 600, 0]) annotation(
    Placement(transformation(extent = {{178, -10}, {158, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation(
    Placement(visible = true, transformation(origin = {140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(extent = {{104, -30}, {124, -10}})));
equation
  connect(RaideurFrott_Arbre.flange_a, Frottement_Sec.flange_b) annotation(
    Line(points = {{-18, 0}, {-30, 0}}));
  connect(Inertie_Helice.flange_b, Frottement_Sec.flange_a) annotation(
    Line(points = {{-62, 0}, {-50, 0}}));
  connect(Couple_Poussee.flange, Inertie_Helice.flange_a) annotation(
    Line(points = {{-94, 0}, {-82, 0}}));
  connect(RaideurFrott_Arbre.flange_b, Inertie_Motor.flange_a) annotation(
    Line(points = {{2, 0}, {14, 0}}));
  connect(Frott_Visq_Mot.flange_a, Inertie_Motor.flange_b) annotation(
    Line(points = {{52, 0}, {34, 0}}));
  connect(Moteur_Parfait.n, signalVoltage.n) annotation(
    Line(points = {{78, -10}, {140, -10}}, color = {0, 0, 255}));
  connect(timeTable.y, signalVoltage.v) annotation(
    Line(points = {{157, 0}, {147, 0}}, color = {0, 0, 127}));
  connect(inductor.n, signalVoltage.p) annotation(
    Line(points = {{140, 44}, {140, 10}}, color = {0, 0, 255}));
  connect(Moteur_Parfait.n, ground.p) annotation(
    Line(points = {{78, -10}, {114, -10}}, color = {0, 0, 255}));
  connect(Moteur_Parfait.p, resistor.p) annotation(
    Line(points = {{78, 10}, {78, 44}, {88, 44}}, color = {0, 0, 255}));
  connect(Frott_Visq_Mot.flange_a, Moteur_Parfait.flange) annotation(
    Line(points = {{52, 0}, {68, 0}}));
  connect(Frott_Visq_Mot.flange_b, fixed.flange) annotation(
    Line(points = {{52, -20}, {52, -30}}));
  connect(resistor.n, inductor.p) annotation(
    Line(points = {{108, 44}, {120, 44}}, color = {0, 0, 255}, smooth = Smooth.None));
  annotation(
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -100}, {200, 100}}), graphics),
    Icon(coordinateSystem(extent = {{-120, -100}, {200, 100}})),
    version = "1",
    conversion(noneFromVersion = ""),
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 0.12));
end Submarine_v1;
