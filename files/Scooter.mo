package Scooter
  model Scooter
    parameter Modelica.SIunits.Weight ScooterMass = 180 "Scooter mass with driver";
    parameter Real Crr = 1e-2 "Rolling coeficient";
    parameter Real Alpha = 0.3 "Aerodynamic coefficient";
    constant Modelica.SIunits.Acceleration g = Modelica.Constants.g_n "Gravity constant";
    Modelica.Mechanics.Translational.Components.Mass mass(m = ScooterMass) annotation (
      Placement(transformation(extent = {{34, 50}, {54, 70}})));
    Modelica.Mechanics.Translational.Components.SupportFriction RollingFriction(f_pos = [0, ScooterMass * g * Crr]) annotation (
      Placement(transformation(extent = {{0, 50}, {20, 70}})));
    Modelica.Mechanics.Translational.Sources.Force force annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {34, 32})));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(extent = {{64, 50}, {84, 70}})));
    Modelica.Blocks.Math.Product ProductSpeed annotation (
      Placement(transformation(extent = {{-42, -18}, {-22, 2}})));
    Modelica.Blocks.Math.Gain GainAeroForce(k = -Alpha) annotation (
      Placement(transformation(extent = {{-12, -4}, {8, 16}})));
    Modelica.Blocks.Math.Abs AbsSpeed annotation (
      Placement(transformation(extent = {{-70, -24}, {-50, -4}})));
    Modelica.Blocks.Math.Add add annotation (
      Placement(transformation(extent = {{16, -20}, {36, 0}})));
    Modelica.Blocks.Math.Atan atan annotation (
      Placement(transformation(extent = {{-88, -74}, {-68, -54}})));
    Modelica.Blocks.Math.Gain GainSlopeForce(k = -ScooterMass * g) annotation (
      Placement(transformation(extent = {{-24, -74}, {-4, -54}})));
    Modelica.Blocks.Math.Sin sin annotation (
      Placement(transformation(extent = {{-58, -74}, {-38, -54}})));
    Modelica.Blocks.Interfaces.RealInput Slope "Slope " annotation (
      Placement(transformation(extent = {{-120, -100}, {-80, -60}}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -76})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a "Flange of left shaft" annotation (
      Placement(transformation(extent = {{-110, -40}, {-90, -20}}), iconTransformation(extent = {{-110, -40}, {-90, -20}})));
  equation
    connect(RollingFriction.flange_b, mass.flange_a) annotation (
      Line(points = {{20, 60}, {34, 60}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(mass.flange_b, speedSensor.flange) annotation (
      Line(points = {{54, 60}, {64, 60}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(ProductSpeed.y, GainAeroForce.u) annotation (
      Line(points = {{-21, -8}, {-18, -8}, {-18, 6}, {-14, 6}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(AbsSpeed.y, ProductSpeed.u2) annotation (
      Line(points = {{-49, -14}, {-44, -14}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(speedSensor.v, AbsSpeed.u) annotation (
      Line(points = {{85, 60}, {90, 60}, {90, -26}, {-84, -26}, {-84, -14}, {-72, -14}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(ProductSpeed.u1, AbsSpeed.u) annotation (
      Line(points = {{-44, -2}, {-80, -2}, {-80, -14}, {-72, -14}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(force.flange, mass.flange_a) annotation (
      Line(points = {{34, 42}, {34, 60}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(add.u1, GainAeroForce.y) annotation (
      Line(points = {{14, -4}, {12, -4}, {12, 6}, {9, 6}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.y, force.f) annotation (
      Line(points = {{37, -10}, {48, -10}, {48, 20}, {34, 20}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(GainSlopeForce.y, add.u2) annotation (
      Line(points = {{-3, -64}, {6, -64}, {6, -16}, {14, -16}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(sin.y, GainSlopeForce.u) annotation (
      Line(points = {{-37, -64}, {-26, -64}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(sin.u, atan.y) annotation (
      Line(points = {{-60, -64}, {-67, -64}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(atan.u, Slope) annotation (
      Line(points = {{-90, -64}, {-95, -64}, {-95, -80}, {-100, -80}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(RollingFriction.flange_a, flange_a) annotation (
      Line(points = {{0, 60}, {-98, 60}, {-98, -30}, {-100, -30}}, color = {0, 127, 0}, smooth = Smooth.None));
    annotation (
      Icon(graphics={  Rectangle(extent = {{-84, 28}, {-20, 16}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-88, -20}, {-84, 8}, {-68, 22}, {-66, 28}, {-40, 28}, {-24, 16}, {-30, 2}, {-18, -20}, {-88, -20}}, lineColor = {0, 0, 0}, smooth = Smooth.None,
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, fillColor = {0, 0, 0}), Rectangle(extent = {{-44, -12}, {36, -20}}, lineColor = {0, 0, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, fillColor = {0, 0, 0}), Ellipse(extent = {{42, 8}, {88, -40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Polygon(points = {{36, -20}, {38, -6}, {42, 4}, {54, 10}, {70, 14}, {82, 10}, {88, 12}, {88, 14}, {86, 20}, {70, 24}, {58, 48}, {68, 50}, {68, 60}, {56, 60}, {52, 66}, {42, 70}, {22, 70}, {18, 66}, {22, 64}, {34, 64}, {52, 24}, {32, 12}, {26, -4}, {24, -20}, {36, -20}}, lineColor = {0, 0, 0}, smooth = Smooth.None, fillColor = {0, 0, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Line(points = {{100, -36}, {-100, -56}, {100, -56}}, color = {0, 0, 0}, smooth = Smooth.None), Ellipse(extent = {{-78, -4}, {-32, -52}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Line(points = {{-92, -30}, {-56, -30}, {-60, -40}}, color = {0, 0, 0}, smooth = Smooth.None), Text(extent = {{20, -64}, {84, -86}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "Slope"), Rectangle(extent = {{-24, -24}, {-84, -20}}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, pattern = LinePattern.None)}));
  end Scooter;

  model TestScooter
    Scooter scooter annotation (
      Placement(transformation(extent = {{-26, -8}, {6, 26}})));
    Modelica.Blocks.Sources.Step stepForce(height = 220.12) annotation (
      Placement(transformation(extent = {{-100, -6}, {-80, 14}})));
    Modelica.Blocks.Sources.Step stepSlope(height = 0.1) annotation (
      Placement(transformation(extent = {{-40, -40}, {-20, -20}})));
    Modelica.Mechanics.Translational.Sources.Force force annotation (
      Placement(visible = true, transformation(extent = {{-64, -6}, {-44, 14}}, rotation = 0)));
  equation
    connect(force.flange, scooter.flange_a) annotation (
      Line(points = {{-44, 4}, {-35, 4}, {-35, 3.9}, {-26, 3.9}}, color = {0, 127, 0}));
    connect(stepForce.y, force.f) annotation (
      Line(points = {{-79, 4}, {-66, 4}}, color = {0, 0, 127}));
    connect(stepSlope.y, scooter.Slope) annotation (
      Line(points = {{-19, -30}, {-10, -30}, {-10, -3.92}}, color = {0, 0, 127}));
    annotation (
      Diagram(graphics));
  end TestScooter;

  model TestSlopeMotor
    Scooter scooter annotation (
      Placement(transformation(extent = {{84, -8}, {116, 26}})));
    Modelica.Blocks.Sources.Step stepTorque(height = 6.25) annotation (
      Placement(transformation(extent = {{-116, -6}, {-96, 14}})));
    Modelica.Blocks.Sources.Step stepSlope(height = 0.1) annotation (
      Placement(transformation(extent = {{70, -40}, {90, -20}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel(radius = 0.2) annotation (
      Placement(transformation(extent = {{50, -6}, {70, 14}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio = 8, lossTable = [0, 0.88, 0.88, 0, 0]) annotation (
      Placement(transformation(extent = {{-4, -6}, {16, 14}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor(J = (7 + 1.1) * 1e-4) annotation (
      Placement(transformation(extent = {{-30, -6}, {-10, 14}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation (
      Placement(transformation(extent = {{-88, -6}, {-68, 14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (
      Placement(transformation(extent = {{-60, -6}, {-40, 14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1 annotation (
      Placement(transformation(extent = {{24, -6}, {44, 14}})));
  equation
    connect(stepSlope.y, scooter.Slope) annotation (
      Line(points = {{91, -30}, {100, -30}, {100, -3.92}}, color = {0, 0, 127}));
    connect(inertiaReducerMotor.flange_b, lossyGear.flange_a) annotation (
      Line(points = {{-10, 4}, {-4, 4}}));
    connect(powerSensor1.flange_b, idealRollingWheel.flangeR) annotation (
      Line(points = {{44, 4}, {50, 4}}));
    connect(lossyGear.flange_b, powerSensor1.flange_a) annotation (
      Line(points = {{16, 4}, {24, 4}}));
    connect(idealRollingWheel.flangeT, scooter.flange_a) annotation (
      Line(points = {{70, 4}, {74, 4}, {74, 3.9}, {84, 3.9}}, color = {0, 127, 0}));
    connect(torque.tau, stepTorque.y) annotation (
      Line(points = {{-90, 4}, {-95, 4}}, color = {0, 0, 127}));
    connect(torque.flange, powerSensor.flange_a) annotation (
      Line(points = {{-68, 4}, {-60, 4}}));
    connect(powerSensor.flange_b, inertiaReducerMotor.flange_a) annotation (
      Line(points = {{-40, 4}, {-30, 4}}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}})));
  end TestSlopeMotor;

  model TestAccelerationMotor
    Scooter scooter annotation (
      Placement(transformation(extent = {{84, -8}, {116, 26}})));
    Modelica.Blocks.Sources.Step stepTorque(height = 6.75) annotation (
      Placement(transformation(extent = {{-116, -6}, {-96, 14}})));
    Modelica.Blocks.Sources.Step stepSlope(height = 0) annotation (
      Placement(transformation(extent = {{70, -40}, {90, -20}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel(radius = 0.2) annotation (
      Placement(transformation(extent = {{50, -6}, {70, 14}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio = 8, lossTable = [0, 0.88, 0.88, 0, 0]) annotation (
      Placement(transformation(extent = {{-4, -6}, {16, 14}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor(J = (7 + 1.1) * 1e-4) annotation (
      Placement(transformation(extent = {{-30, -6}, {-10, 14}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation (
      Placement(transformation(extent = {{-88, -6}, {-68, 14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (
      Placement(transformation(extent = {{-60, -6}, {-40, 14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1 annotation (
      Placement(transformation(extent = {{24, -6}, {44, 14}})));
  equation
    connect(powerSensor1.flange_b, idealRollingWheel.flangeR) annotation (
      Line(points = {{44, 4}, {50, 4}}));
    connect(stepSlope.y, scooter.Slope) annotation (
      Line(points = {{91, -30}, {100, -30}, {100, -3.92}}, color = {0, 0, 127}));
    connect(inertiaReducerMotor.flange_b, lossyGear.flange_a) annotation (
      Line(points = {{-10, 4}, {-4, 4}}));
    connect(lossyGear.flange_b, powerSensor1.flange_a) annotation (
      Line(points = {{16, 4}, {24, 4}}));
    connect(idealRollingWheel.flangeT, scooter.flange_a) annotation (
      Line(points = {{70, 4}, {74, 4}, {74, 3.9}, {84, 3.9}}, color = {0, 127, 0}));
    connect(powerSensor.flange_b, inertiaReducerMotor.flange_a) annotation (
      Line(points = {{-40, 4}, {-30, 4}}));
    connect(torque.tau, stepTorque.y) annotation (
      Line(points = {{-90, 4}, {-95, 4}}, color = {0, 0, 127}));
    connect(torque.flange, powerSensor.flange_a) annotation (
      Line(points = {{-68, 4}, {-60, 4}}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}})));
  end TestAccelerationMotor;

  function ForceCalculation
    input Real Slope "en %";
    input Real Speed "en km/h";
    output Real Force "en N";
  protected
    Real v;
  algorithm
    v := Speed / 3.6;
    Force := 0.3 * v ^ 2 + 180 * 9.81 * 1e-2 + 180 * 9.81 * sin(arctan(Slope / 100));
  end ForceCalculation;

  function TorqueCalculation
    input Real Slope "en %";
    input Real Speed "en km/h";
    output Real Torque "en N.m";
  protected
    Real v;
    Real Force "en N";
  algorithm
    v := Speed / 3.6;
    Force := 0.3 * v ^ 2 + 180 * 9.81 * 1e-2 + 180 * 9.81 * sin(arctan(Slope / 100));
    Torque := Force * 0.2 / 0.88 / 8;
  end TorqueCalculation;

  model TestVibMotor
    Scooter scooter annotation (
      Placement(transformation(extent = {{128, -8}, {160, 26}})));
    Modelica.Blocks.Sources.Step stepTorque(height = 6.75) annotation (
      Placement(transformation(extent = {{-148, -6}, {-128, 14}})));
    Modelica.Blocks.Sources.Step stepSlope(height = 0) annotation (
      Placement(transformation(extent = {{114, -40}, {134, -20}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel(radius = 0.2) annotation (
      Placement(transformation(extent = {{94, -6}, {114, 14}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio = 2, lossTable = [0, 0.91, 0.91, 0, 0]) annotation (
      Placement(transformation(extent = {{-36, -6}, {-16, 14}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor(J = (7 + 1) * 1e-4) annotation (
      Placement(transformation(extent = {{-62, -6}, {-42, 14}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation (
      Placement(transformation(extent = {{-120, -6}, {-100, 14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (
      Placement(transformation(extent = {{-92, -6}, {-72, 14}})));
    Modelica.Mechanics.Rotational.Components.Spring spring(c = 330) annotation (
      Placement(transformation(extent = {{-12, -6}, {8, 14}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(ratio = 4, lossTable = [0, 0.97, 0.97, 0, 0]) annotation (
      Placement(transformation(extent = {{44, -6}, {64, 14}})));
    Modelica.Mechanics.Rotational.Components.Spring spring1(c = 3300) annotation (
      Placement(transformation(extent = {{68, -6}, {88, 14}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor1(J = 0.44 * 1e-4) annotation (
      Placement(transformation(extent = {{14, -6}, {34, 14}})));
  equation
    connect(stepSlope.y, scooter.Slope) annotation (
      Line(points = {{135, -30}, {144, -30}, {144, -3.92}}, color = {0, 0, 127}));
    connect(idealRollingWheel.flangeT, scooter.flange_a) annotation (
      Line(points = {{114, 4}, {118, 4}, {118, 3.9}, {128, 3.9}}, color = {0, 127, 0}));
    connect(inertiaReducerMotor.flange_b, lossyGear.flange_a) annotation (
      Line(points = {{-42, 4}, {-36, 4}}));
    connect(powerSensor.flange_b, inertiaReducerMotor.flange_a) annotation (
      Line(points = {{-72, 4}, {-62, 4}}));
    connect(torque.tau, stepTorque.y) annotation (
      Line(points = {{-122, 4}, {-127, 4}}, color = {0, 0, 127}));
    connect(torque.flange, powerSensor.flange_a) annotation (
      Line(points = {{-100, 4}, {-92, 4}}));
    connect(lossyGear1.flange_b, spring1.flange_a) annotation (
      Line(points = {{64, 4}, {68, 4}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(spring1.flange_b, idealRollingWheel.flangeR) annotation (
      Line(points = {{88, 4}, {94, 4}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(spring.flange_a, lossyGear.flange_b) annotation (
      Line(points = {{-12, 4}, {-16, 4}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(spring.flange_b, inertiaReducerMotor1.flange_a) annotation (
      Line(points = {{8, 4}, {14, 4}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(inertiaReducerMotor1.flange_b, lossyGear1.flange_a) annotation (
      Line(points = {{34, 4}, {44, 4}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}})));
  end TestVibMotor;
  annotation (
    uses(Modelica(version = "3.2.1")));
end Scooter;
