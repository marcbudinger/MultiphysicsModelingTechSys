package Chap2_Scooter
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
      Line(points={{-44,-2},{-80,-2},{-80,-14},{-72,-14}},          color = {0, 0, 127}, smooth = Smooth.None));
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

  model Scooter_AeroSimple
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
    Modelica.Mechanics.Translational.Sources.QuadraticSpeedDependentForce
      quadraticSpeedDependentForce(f_nominal=-Alpha, v_nominal=1)
      annotation (Placement(transformation(extent={{-2,76},{18,96}})));
  equation
    connect(RollingFriction.flange_b, mass.flange_a) annotation (
      Line(points = {{20, 60}, {34, 60}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(mass.flange_b, speedSensor.flange) annotation (
      Line(points = {{54, 60}, {64, 60}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(force.flange, mass.flange_a) annotation (
      Line(points = {{34, 42}, {34, 60}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(sin.y, GainSlopeForce.u) annotation (
      Line(points = {{-37, -64}, {-26, -64}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(sin.u, atan.y) annotation (
      Line(points = {{-60, -64}, {-67, -64}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(atan.u, Slope) annotation (
      Line(points = {{-90, -64}, {-95, -64}, {-95, -80}, {-100, -80}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(RollingFriction.flange_a, flange_a) annotation (
      Line(points = {{0, 60}, {-98, 60}, {-98, -30}, {-100, -30}}, color = {0, 127, 0}, smooth = Smooth.None));
    connect(GainSlopeForce.y, force.f)
      annotation (Line(points={{-3,-64},{34,-64},{34,20}}, color={0,0,127}));
    connect(quadraticSpeedDependentForce.flange, mass.flange_a)
      annotation (Line(points={{18,86},{34,86},{34,60}}, color={0,127,0}));
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
  end Scooter_AeroSimple;

  model TestScooter
    Scooter scooter annotation (
      Placement(transformation(extent={{8,-52},{40,-18}})));
    Modelica.Blocks.Sources.Step stepForce(height = 220.12) annotation (
      Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Modelica.Blocks.Sources.Step stepSlope(height = 0.1) annotation (
      Placement(transformation(extent={{-6,-84},{14,-64}})));
    Modelica.Mechanics.Translational.Sources.Force force annotation (
      Placement(visible = true, transformation(extent={{-30,-50},{-10,-30}},    rotation = 0)));
    Scooter_AeroSimple
            scooter_AeroSimple
                    annotation (
      Placement(transformation(extent={{14,44},{46,78}})));
    Modelica.Blocks.Sources.Step stepForce1(height=220.12)  annotation (
      Placement(transformation(extent={{-60,46},{-40,66}})));
    Modelica.Blocks.Sources.Step stepSlope1(height=0.1)  annotation (
      Placement(transformation(extent={{0,12},{20,32}})));
    Modelica.Mechanics.Translational.Sources.Force force1
                                                         annotation (
      Placement(visible = true, transformation(extent={{-24,46},{-4,66}},       rotation = 0)));
  equation
    connect(force.flange, scooter.flange_a) annotation (
      Line(points={{-10,-40},{-1,-40},{-1,-40.1},{8,-40.1}},      color = {0, 127, 0}));
    connect(stepForce.y, force.f) annotation (
      Line(points={{-39,-40},{-32,-40}},  color = {0, 0, 127}));
    connect(stepSlope.y, scooter.Slope) annotation (
      Line(points={{15,-74},{24,-74},{24,-47.92}},          color = {0, 0, 127}));
    connect(force1.flange, scooter_AeroSimple.flange_a) annotation (Line(points
          ={{-4,56},{5,56},{5,55.9},{14,55.9}}, color={0,127,0}));
    connect(stepForce1.y, force1.f)
      annotation (Line(points={{-39,56},{-26,56}}, color={0,0,127}));
    connect(stepSlope1.y, scooter_AeroSimple.Slope)
      annotation (Line(points={{21,22},{30,22},{30,48.08}}, color={0,0,127}));
    annotation (
      Diagram(graphics), experiment(StopTime=300));
  end TestScooter;

  model TestSlopeMotor
    Scooter scooter annotation (
      Placement(transformation(extent = {{84, -8}, {116, 26}})));
    Modelica.Blocks.Sources.Step stepTorque(height=8.93)   annotation (
      Placement(transformation(extent = {{-116, -6}, {-96, 14}})));
    Modelica.Blocks.Sources.Step stepSlope(height = 0.1) annotation (
      Placement(transformation(extent = {{70, -40}, {90, -20}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel(radius = 0.2) annotation (
      Placement(transformation(extent = {{50, -6}, {70, 14}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(           lossTable = [0, 0.88, 0.88, 0, 0], ratio=
          5.6)                                                                                                 annotation (
      Placement(transformation(extent = {{-4, -6}, {16, 14}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor(J=0.57e-4)
                                                                                               annotation (
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

  model TestMotors
    Scooter scooter1
      annotation (Placement(transformation(extent={{100,48},{132,82}})));
    Modelica.Blocks.Sources.Step stepSlope(height = 0) annotation (
      Placement(transformation(extent={{86,16},{106,36}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel1(radius=
          0.2) annotation (Placement(transformation(extent={{66,50},{86,70}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(lossTable=[0,
          0.88,0.88,0,0], ratio=5.6)
      annotation (Placement(transformation(extent={{12,50},{32,70}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor1(J=0.57e-4)
      annotation (Placement(transformation(extent={{-14,50},{6,70}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaMotor1(J=0.0234)
      annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
    Modelica.Electrical.Analog.Basic.EMF emf1(k=0.055)
      annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
    Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage1(V=24)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-138,60})));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R=185e-3)
      annotation (Placement(transformation(extent={{-134,70},{-114,90}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L=0.008e-3)
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Scooter scooter2
      annotation (Placement(transformation(extent={{98,-56},{130,-22}})));
    Modelica.Blocks.Sources.Step stepSlope1(height=0)  annotation (
      Placement(transformation(extent={{84,-88},{104,-68}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel2(radius=
          0.2)
      annotation (Placement(transformation(extent={{64,-54},{84,-34}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear2(lossTable=[0,
          0.88,0.88,0,0], ratio=5.6)
      annotation (Placement(transformation(extent={{10,-54},{30,-34}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor2(J=0.57e-4)
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaMotor2(J=0.0018)
      annotation (Placement(transformation(extent={{-72,-54},{-52,-34}})));
    Modelica.Electrical.Analog.Basic.EMF emf2(k=0.057)
      annotation (Placement(transformation(extent={{-102,-54},{-82,-34}})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-102,-80},{-82,-60}})));
    Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage2(V=24)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-140,-44})));
    Modelica.Electrical.Analog.Basic.Resistor resistor2(R=10e-3)
      annotation (Placement(transformation(extent={{-136,-34},{-116,-14}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor2(L=46e-3)
      annotation (Placement(transformation(extent={{-112,-34},{-92,-14}})));
  equation
    connect(stepSlope.y, scooter1.Slope) annotation (Line(points={{107,26},{116,
            26},{116,52.08}}, color={0,0,127}));
    connect(inertiaReducerMotor1.flange_b, lossyGear1.flange_a)
      annotation (Line(points={{6,60},{12,60}}));
    connect(idealRollingWheel1.flangeT, scooter1.flange_a) annotation (Line(
          points={{86,60},{90,60},{90,59.9},{100,59.9}}, color={0,127,0}));
    connect(emf1.flange, inertiaMotor1.flange_a)
      annotation (Line(points={{-80,60},{-70,60}}, color={0,0,0}));
    connect(ground.p, emf1.n) annotation (Line(points={{-90,44},{-90,47},{-90,
            47},{-90,50}}, color={0,0,255}));
    connect(stepVoltage1.n, ground.p) annotation (Line(points={{-138,50},{-138,
            44},{-90,44}}, color={0,0,255}));
    connect(inductor1.n, emf1.p)
      annotation (Line(points={{-90,80},{-90,70}}, color={0,0,255}));
    connect(inductor1.p, resistor1.n)
      annotation (Line(points={{-110,80},{-114,80}}, color={0,0,255}));
    connect(resistor1.p, stepVoltage1.p) annotation (Line(points={{-134,80},{
            -138,80},{-138,70}}, color={0,0,255}));
    connect(inertiaMotor1.flange_b, inertiaReducerMotor1.flange_a)
      annotation (Line(points={{-50,60},{-14,60}}, color={0,0,0}));
    connect(lossyGear1.flange_b, idealRollingWheel1.flangeR)
      annotation (Line(points={{32,60},{66,60}}, color={0,0,0}));
    connect(stepSlope1.y, scooter2.Slope) annotation (Line(points={{105,-78},{
            114,-78},{114,-51.92}}, color={0,0,127}));
    connect(inertiaReducerMotor2.flange_b, lossyGear2.flange_a)
      annotation (Line(points={{4,-44},{10,-44}}));
    connect(idealRollingWheel2.flangeT, scooter2.flange_a) annotation (Line(
          points={{84,-44},{88,-44},{88,-44.1},{98,-44.1}}, color={0,127,0}));
    connect(emf2.flange, inertiaMotor2.flange_a)
      annotation (Line(points={{-82,-44},{-72,-44}}, color={0,0,0}));
    connect(ground1.p, emf2.n)
      annotation (Line(points={{-92,-60},{-92,-54}}, color={0,0,255}));
    connect(stepVoltage2.n, ground1.p) annotation (Line(points={{-140,-54},{
            -140,-60},{-92,-60}}, color={0,0,255}));
    connect(inductor2.n, emf2.p)
      annotation (Line(points={{-92,-24},{-92,-34}}, color={0,0,255}));
    connect(inductor2.p, resistor2.n)
      annotation (Line(points={{-112,-24},{-116,-24}}, color={0,0,255}));
    connect(resistor2.p, stepVoltage2.p) annotation (Line(points={{-136,-24},{
            -140,-24},{-140,-34}}, color={0,0,255}));
    connect(inertiaMotor2.flange_b, inertiaReducerMotor2.flange_a)
      annotation (Line(points={{-52,-44},{-16,-44}}, color={0,0,0}));
    connect(lossyGear2.flange_b, idealRollingWheel2.flangeR)
      annotation (Line(points={{30,-44},{64,-44}}, color={0,0,0}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}})),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}})));
  end TestMotors;

  model TestMotors_Icontrol
    Scooter scooter2
      annotation (Placement(transformation(extent={{106,22},{138,56}})));
    Modelica.Blocks.Sources.Step stepSlope1(height=0)  annotation (
      Placement(transformation(extent={{92,-10},{112,10}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel2(radius=
          0.2) annotation (Placement(transformation(extent={{72,24},{92,44}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear2(lossTable=[0,
          0.88,0.88,0,0], ratio=5.6)
      annotation (Placement(transformation(extent={{36,24},{56,44}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor2(J=0.57e-4)
      annotation (Placement(transformation(extent={{10,24},{30,44}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaMotor2(J=0.0018)
      annotation (Placement(transformation(extent={{-14,24},{6,44}})));
    Modelica.Electrical.Analog.Basic.EMF emf2(k=0.055)
      annotation (Placement(transformation(extent={{-44,24},{-24,44}})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-44,-2},{-24,18}})));
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-104,34})));
    Modelica.Electrical.Analog.Basic.Resistor resistor2(R=10e-3)
      annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor2(L=46e-3)
      annotation (Placement(transformation(extent={{-54,44},{-34,64}})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{-170,24},{-150,44}})));
    Modelica.Blocks.Math.Gain gain(k=100)
      annotation (Placement(transformation(extent={{-146,28},{-134,40}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=24)
      annotation (Placement(transformation(extent={{-128,28},{-116,40}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
      annotation (Placement(transformation(extent={{-76,44},{-56,64}})));
    Modelica.Blocks.Sources.Step step(height=50)
      annotation (Placement(transformation(extent={{-198,24},{-178,44}})));
  equation
    connect(stepSlope1.y, scooter2.Slope)
      annotation (Line(points={{113,0},{122,0},{122,26.08}}, color={0,0,127}));
    connect(inertiaReducerMotor2.flange_b, lossyGear2.flange_a)
      annotation (Line(points={{30,34},{36,34}}));
    connect(idealRollingWheel2.flangeT, scooter2.flange_a) annotation (Line(
          points={{92,34},{96,34},{96,33.9},{106,33.9}}, color={0,127,0}));
    connect(emf2.flange, inertiaMotor2.flange_a)
      annotation (Line(points={{-24,34},{-14,34}}, color={0,0,0}));
    connect(ground1.p, emf2.n)
      annotation (Line(points={{-34,18},{-34,24}}, color={0,0,255}));
    connect(signalVoltage.n, ground1.p) annotation (Line(points={{-104,24},{
            -104,18},{-34,18}}, color={0,0,255}));
    connect(inductor2.n, emf2.p)
      annotation (Line(points={{-34,54},{-34,44}}, color={0,0,255}));
    connect(resistor2.p, signalVoltage.p) annotation (Line(points={{-100,54},{
            -104,54},{-104,44}}, color={0,0,255}));
    connect(inertiaMotor2.flange_b, inertiaReducerMotor2.flange_a)
      annotation (Line(points={{6,34},{10,34}}, color={0,0,0}));
    connect(lossyGear2.flange_b, idealRollingWheel2.flangeR)
      annotation (Line(points={{56,34},{72,34}}, color={0,0,0}));
    connect(signalVoltage.v, limiter.y)
      annotation (Line(points={{-111,34},{-115.4,34}}, color={0,0,127}));
    connect(limiter.u, gain.y)
      annotation (Line(points={{-129.2,34},{-133.4,34}}, color={0,0,127}));
    connect(gain.u, feedback.y)
      annotation (Line(points={{-147.2,34},{-151,34}}, color={0,0,127}));
    connect(currentSensor.n, inductor2.p)
      annotation (Line(points={{-56,54},{-54,54}}, color={0,0,255}));
    connect(currentSensor.p, resistor2.n)
      annotation (Line(points={{-76,54},{-80,54}}, color={0,0,255}));
    connect(currentSensor.i, feedback.u2) annotation (Line(points={{-66,44},{
            -66,2},{-160,2},{-160,26}}, color={0,0,127}));
    connect(step.y, feedback.u1)
      annotation (Line(points={{-177,34},{-168,34}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = true, extent={{-200,-100},
              {150,100}})),
      Icon(coordinateSystem(preserveAspectRatio = true, extent={{-200,-100},{
              150,100}})));
  end TestMotors_Icontrol;
  annotation (
    uses(Modelica(version="3.2.2")));
end Chap2_Scooter;
