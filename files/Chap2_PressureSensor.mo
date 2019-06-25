within ;
package Chap2_PressureSensor
  model PressureSensor1
    Modelica.Electrical.Analog.Basic.VariableResistor R1(useHeatPort = false) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, 40})));
    Modelica.Electrical.Analog.Basic.VariableResistor R2(useHeatPort = false) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, 0})));
    Modelica.Electrical.Analog.Basic.VariableResistor R4(useHeatPort = false) annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {80, 40})));
    Modelica.Electrical.Analog.Basic.VariableResistor R3(useHeatPort = false) annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {80, 0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor Vout annotation(Placement(transformation(extent = {{70, 10}, {50, 30}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{30, -36}, {50, -16}})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent = {{70, -36}, {90, -16}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vin(V = 10) annotation(Placement(visible = true, transformation(origin = {30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant R0(k = 1000) annotation(Placement(visible = true, transformation(extent = {{-100, 28}, {-80, 48}}, rotation = 0)));
    Modelica.Blocks.Math.Add add annotation(Placement(visible = true, transformation(extent = {{-20, 18}, {0, 38}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1(k2 = -1) annotation(Placement(visible = true, transformation(extent = {{-18, -22}, {2, -2}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(Placement(visible = true, transformation(extent = {{-50, -28}, {-38, -16}}, rotation = 0)));
    Modelica.Blocks.Math.Gain A(k = 1e-4) annotation(Placement(visible = true, transformation(extent = {{-72, -54}, {-60, -42}}, rotation = 0)));
    Modelica.Blocks.Sources.Step Pressure( height = 100, startTime = 2)
      "unit is hPa"                                                                  annotation(Placement(visible = true, transformation(extent = {{-100, -58}, {-80, -38}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(visible = true, transformation(origin = {4, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  equation
    connect(Vin.p, R4.n) annotation (
      Line(points = {{40, 60}, {80, 60}, {80, 50}}, color = {0, 0, 255}));
    connect(Vin.p, R1.n) annotation (
      Line(points = {{40, 60}, {40, 50}}, color = {0, 0, 255}));
    connect(ground2.p, Vin.n) annotation(Line(points = {{14, 60}, {20, 60}}, color = {0, 0, 255}));
    connect(Pressure.y, A.u) annotation(Line(points={{-79,-48},{-73.2,-48}},    color = {0, 0, 127}));
    connect(A.y, product.u2) annotation(Line(points={{-59.4,-48},{-60,-48},{-60,
            -25.6},{-51.2,-25.6}},                                                                      color = {0, 0, 127}));
    connect(product.u1, R0.y) annotation(Line(points={{-51.2,-18.4},{-60,-18.4},
            {-60,38},{-79,38}},                                                                        color = {0, 0, 127}));
    connect(add.u2, product.y) annotation(Line(points={{-22,22},{-32,22},{-32,
            -22},{-37.4,-22}},                                                                          color = {0, 0, 127}));
    connect(product.y, add1.u2) annotation(Line(points={{-37.4,-22},{-28.7,-22},
            {-28.7,-18},{-20,-18}},                                                                            color = {0, 0, 127}));
    connect(R4.R, add1.y) annotation(Line(points = {{91, 40}, {98, 40}, {98, -12}, {3, -12}}, color = {0, 0, 127}));
    connect(add1.y, R2.R) annotation(Line(points = {{3, -12}, {14, -12}, {14, 6.73556e-16}, {29, 6.73556e-16}}, color = {0, 0, 127}));
    connect(add1.u1, R0.y) annotation(Line(points = {{-20, -6}, {-50, -6}, {-50, 38}, {-79, 38}}, color = {0, 0, 127}));
    connect(R3.R, add.y) annotation(Line(points = {{91, -6.73556e-16}, {91, -36}, {20, -36}, {20, 28}, {1, 28}}, color = {0, 0, 127}));
    connect(add.y, R1.R) annotation(Line(points = {{1, 28}, {15, 28}, {15, 40}, {29, 40}}, color = {0, 0, 127}));
    connect(R0.y, add.u1) annotation(Line(points = {{-79, 38}, {-50.5, 38}, {-50.5, 34}, {-22, 34}}, color = {0, 0, 127}));
    connect(R2.n, R1.p) annotation(Line(points = {{40, 10}, {40, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground1.p, R3.p) annotation(Line(points = {{80, -16}, {80, -10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground.p, R2.p) annotation(Line(points = {{40, -16}, {40, -10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vout.p, R4.p) annotation(Line(points = {{70, 20}, {80, 20}, {80, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R3.n, R4.p) annotation(Line(points = {{80, 10}, {80, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vout.n, R1.p) annotation(Line(points = {{50, 20}, {40, 20}, {40, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation(uses(Modelica(version = "3.1")), Diagram(graphics));
  end PressureSensor1;

  model PressureSensor2
    Modelica.Blocks.Sources.Step Pressure(startTime = 2, height = 100)
      "unit is hPa"                                                                  annotation(Placement(transformation(extent = {{-100, -60}, {-80, -40}})));
    PressureSensor pressureSensor1 annotation(Placement(transformation(extent = {{-50, -2}, {-30, 18}})));
    DifferentialAmplifier2 differentialAmplifier2(A = 50) annotation(Placement(transformation(extent = {{-20, 32}, {0, 52}})));
    PressureSensor pressureSensor2 annotation(Placement(transformation(extent = {{-50, 62}, {-30, 82}})));
    DifferentialAmplifier1 differentialAmplifier1_1
      annotation (Placement(transformation(extent={{-14,-30},{6,-10}})));
  equation
    connect(pressureSensor1.Pressure, Pressure.y) annotation(Line(points = {{-52, 8}, {-72, 8}, {-72, -50}, {-79, -50}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(pressureSensor2.Pressure, Pressure.y) annotation(Line(points = {{-52, 72}, {-72, 72}, {-72, -50}, {-79, -50}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(differentialAmplifier2.Vin_p, pressureSensor2.p1) annotation(Line(points = {{-20, 50}, {-44, 50}, {-44, 62}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pressureSensor2.p2, differentialAmplifier2.Vin_n) annotation(Line(points = {{-36, 62}, {-36, 34}, {-20, 34}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(differentialAmplifier1_1.Vin_n, pressureSensor1.p2) annotation (
        Line(
        points={{-14,-28},{-24,-28},{-24,-2},{-36,-2}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(differentialAmplifier1_1.Vin_p, pressureSensor1.p1) annotation (
        Line(
        points={{-14,-12},{-30,-12},{-30,-14},{-44,-14},{-44,-2}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation(uses(Modelica(version = "3.1")), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                        graphics));
  end PressureSensor2;

  model PressureSensor
    parameter Real Al = 1e-4 "Pressure sensor sensitivity hPa^-1";
    parameter Real Vinp = 10 "Input voltage";
    Modelica.Electrical.Analog.Basic.VariableResistor R1 annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, 40})));
    Modelica.Electrical.Analog.Basic.VariableResistor R2 annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, 0})));
    Modelica.Electrical.Analog.Basic.VariableResistor R4 annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {80, 40})));
    Modelica.Electrical.Analog.Basic.VariableResistor R3 annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {80, 0})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{30, -36}, {50, -16}})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent = {{70, -36}, {90, -16}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vin(V = Vinp) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {30, 60})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {2, 60})));
    Modelica.Blocks.Sources.Constant R0(k = 1000) annotation(Placement(transformation(extent = {{-100, 30}, {-80, 50}})));
    Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-20, 20}, {0, 40}})));
    Modelica.Blocks.Math.Add add1(k2 = -1) annotation(Placement(transformation(extent = {{-20, -20}, {0, 0}})));
    Modelica.Blocks.Interfaces.RealInput Pressure "Pressure in hPa" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}), iconTransformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                    annotation(Placement(transformation(extent = {{-50, -110}, {-30, -90}}), iconTransformation(extent = {{-50, -110}, {-30, -90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p2
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                    annotation(Placement(transformation(extent = {{30, -110}, {50, -90}}), iconTransformation(extent = {{30, -110}, {50, -90}})));
    Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent = {{-62, -22}, {-50, -10}})));
    Modelica.Blocks.Math.Gain A1(k = Al) annotation(Placement(transformation(extent = {{-82, -52}, {-70, -40}})));
  equation
    connect(R2.n, R1.p) annotation(Line(points = {{40, 10}, {40, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground1.p, R3.p) annotation(Line(points = {{80, -16}, {80, -10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground.p, R2.p) annotation(Line(points = {{40, -16}, {40, -10}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vin.p, R1.n) annotation(Line(points = {{40, 60}, {40, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vin.p, R4.n) annotation(Line(points = {{40, 60}, {80, 60}, {80, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground2.p, Vin.n) annotation(Line(points = {{12, 60}, {20, 60}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R0.y, add.u1) annotation(Line(points = {{-79, 40}, {-50, 40}, {-50, 36}, {-22, 36}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add1.u1, R0.y) annotation(Line(points = {{-22, -4}, {-50, -4}, {-50, 40}, {-79, 40}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.y, R1.R) annotation(Line(points = {{1, 30}, {14, 30}, {14, 40}, {29, 40}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add1.y, R2.R) annotation(Line(points = {{1, -10}, {14, -10}, {14, 6.73556e-016}, {29, 6.73556e-016}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(R3.R, add.y) annotation(Line(points = {{91, -6.73556e-016}, {91, -36}, {20, -36}, {20, 30}, {1, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(R4.R, add1.y) annotation(Line(points = {{91, 40}, {98, 40}, {98, -44}, {14, -44}, {14, -10}, {1, -10}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(R1.p, p1) annotation(Line(points = {{40, 30}, {40, 20}, {8, 20}, {8, -100}, {-40, -100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R4.p, p2) annotation(Line(points = {{80, 30}, {80, 20}, {70, 20}, {70, -100}, {40, -100}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(A1.y, product.u2) annotation(Line(points = {{-69.4, -46}, {-66, -46}, {-66, -19.6}, {-63.2, -19.6}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(A1.u, Pressure) annotation(Line(points = {{-83.2, -46}, {-92, -46}, {-92, 0}, {-120, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(product.y, add1.u2) annotation(Line(points = {{-49.4, -16}, {-22, -16}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(product.y, add.u2) annotation(Line(points = {{-49.4, -16}, {-36, -16}, {-36, 24}, {-22, 24}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(product.u1, R0.y) annotation(Line(points = {{-63.2, -12.4}, {-63.2, 14}, {-72, 14}, {-72, 40}, {-79, 40}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(R3.n, R4.p) annotation(Line(points = {{80, 10}, {80, 30}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation(uses(Modelica(version = "3.1")), Diagram(graphics), Icon(graphics={  Rectangle(extent = {{-60, 40}, {62, -60}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Rectangle(extent = {{-100, -60}, {100, -80}}, lineColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid, fillColor = {255, 255, 0}), Ellipse(extent = {{-100, 40}, {-20, -40}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-40, -80}, {-40, -90}, {-38, -90}, {-38, -80}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{40, -80}, {40, -90}, {42, -90}, {42, -80}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-66, -90}, {-54, -106}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "-"), Text(extent = {{16, -92}, {28, -108}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "+")}));
  end PressureSensor;

  model DifferentialAmplifier1
    Modelica.Electrical.Analog.Basic.OpAmp opAmp(Slope = 1e6) annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{36, -20}, {44, -12}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_n(V = -15) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 270, origin = {40, 2})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_p(V = +15) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 90, origin = {40, 38})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 180, origin = {40, 50})));
    Modelica.Electrical.Analog.Basic.Resistor R1(R = 50e3) annotation(Placement(transformation(extent = {{-12, 2}, {8, 22}})));
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 50e3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {20, 2})));
    Modelica.Electrical.Analog.Basic.Resistor R3(R = 50e3) annotation(Placement(transformation(extent = {{-12, 18}, {8, 38}})));
    Modelica.Electrical.Analog.Basic.Resistor R4(R = 50e3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {20, 38})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vout "Output pin" annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vin_p
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                       annotation(Placement(transformation(extent = {{-110, 70}, {-90, 90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vin_n
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                       annotation(Placement(transformation(extent = {{-110, -90}, {-90, -70}})));
  equation
    connect(Vcc_n.p, opAmp.VMin) annotation(Line(points = {{40, 6}, {40, 13}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp.VMax, Vcc_p.p) annotation(Line(points = {{40, 27}, {40, 34}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.p, opAmp.in_p) annotation(Line(points = {{20, 12}, {25, 12}, {25, 15}, {30, 15}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R1.n, R2.p) annotation(Line(points = {{8, 12}, {20, 12}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.n, Vcc_n.n) annotation(Line(points = {{20, -8}, {40, -8}, {40, -2}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R3.n, R4.p) annotation(Line(points = {{8, 28}, {20, 28}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R4.p, opAmp.in_n) annotation(Line(points = {{20, 28}, {26, 28}, {26, 25}, {30, 25}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R4.n, opAmp.out) annotation(Line(points = {{20, 48}, {20, 60}, {60, 60}, {60, 20}, {50, 20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vcc_p.n, ground1.p) annotation(Line(points = {{40, 42}, {40, 46}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground.p, Vcc_n.n) annotation(Line(points = {{40, -12}, {40, -2}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp.out, Vout) annotation(Line(points = {{50, 20}, {75, 20}, {75, 0}, {100, 0}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R3.p, Vin_p) annotation(Line(points = {{-12, 28}, {-56, 28}, {-56, 80}, {-100, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R1.p, Vin_n) annotation(Line(points = {{-12, 12}, {-56, 12}, {-56, -80}, {-100, -80}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation(Diagram(graphics), Icon(graphics={  Line(points = {{-60, 80}, {-60, -80}, {60, 0}, {-60, 80}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-60, 42}, {28, -34}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "A1"), Line(points = {{60, 0}, {98, 0}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-90, 80}, {-80, 80}, {-80, 60}, {-60, 60}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-90, -80}, {-80, -80}, {-80, -60}, {-60, -60}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-116, -46}, {-84, -74}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "+"), Text(extent = {{-116, 76}, {-84, 48}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "-")}));
  end DifferentialAmplifier1;

  model DifferentialAmplifier2
    parameter Real A = 10 "Amplication of the differential amplifier";
    Modelica.Electrical.Analog.Basic.OpAmp opAmp(Slope = 1e6) annotation(Placement(transformation(extent = {{30, -10}, {50, 10}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{36, -40}, {44, -32}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_n(V = -15) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 270, origin = {40, -18})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_p(V = +15) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 90, origin = {40, 18})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 180, origin = {40, 30})));
    Modelica.Electrical.Analog.Basic.Resistor R1(R = 50e3) annotation(Placement(transformation(extent = {{-12, -18}, {8, 2}})));
    Modelica.Electrical.Analog.Basic.Resistor R2(R = 50e3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {20, -18})));
    Modelica.Electrical.Analog.Basic.Resistor R3(R = 50e3) annotation(Placement(transformation(extent = {{-12, -2}, {8, 18}})));
    Modelica.Electrical.Analog.Basic.Resistor R4(R = 50e3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {20, 18})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vout "Output pin" annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vin_p
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                       annotation(Placement(transformation(extent = {{-110, 70}, {-90, 90}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin Vin_n
      "Positive pin (potential p.v > n.v for positive voltage drop v)"                                                       annotation(Placement(transformation(extent = {{-110, -90}, {-90, -70}})));
    Modelica.Electrical.Analog.Basic.OpAmp opAmp1(Slope = 1e6) annotation(Placement(transformation(extent = {{-64, 60}, {-44, 40}})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent = {{-58, 10}, {-50, 18}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_n1(V = -15) annotation(Placement(transformation(extent = {{4, -4}, {-4, 4}}, rotation = 270, origin = {-54, 68})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_p1(V = +15) annotation(Placement(transformation(extent = {{4, -4}, {-4, 4}}, rotation = 90, origin = {-54, 30})));
    Modelica.Electrical.Analog.Basic.Ground ground3 annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 180, origin = {-54, 80})));
    Modelica.Electrical.Analog.Basic.OpAmp opAmp2(Slope = 1e6) annotation(Placement(transformation(extent = {{-64, -66}, {-44, -46}})));
    Modelica.Electrical.Analog.Basic.Ground ground4 annotation(Placement(transformation(extent = {{-58, -96}, {-50, -88}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_n2(V = -15) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 270, origin = {-54, -74})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vcc_p2(V = +15) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 90, origin = {-54, -38})));
    Modelica.Electrical.Analog.Basic.Ground ground5 annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 180, origin = {-54, -26})));
    Modelica.Electrical.Analog.Basic.Resistor Rg(R = 2 * 10e3 / (A - 1)) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-80, -6})));
    Modelica.Electrical.Analog.Basic.Resistor R5(R = 10e3) annotation(Placement(transformation(extent = {{-70, -6}, {-50, 14}})));
    Modelica.Electrical.Analog.Basic.Resistor R6(R = 10e3) annotation(Placement(transformation(extent = {{-70, -26}, {-50, -6}})));
  equation
    connect(Vcc_n.p, opAmp.VMin) annotation(Line(points = {{40, -14}, {40, -7}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp.VMax, Vcc_p.p) annotation(Line(points = {{40, 7}, {40, 14}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.p, opAmp.in_p) annotation(Line(points = {{20, -8}, {25, -8}, {25, -5}, {30, -5}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R1.n, R2.p) annotation(Line(points = {{8, -8}, {20, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R2.n, Vcc_n.n) annotation(Line(points = {{20, -28}, {40, -28}, {40, -22}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R3.n, R4.p) annotation(Line(points = {{8, 8}, {20, 8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R4.p, opAmp.in_n) annotation(Line(points = {{20, 8}, {26, 8}, {26, 5}, {30, 5}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R4.n, opAmp.out) annotation(Line(points = {{20, 28}, {20, 66}, {62, 66}, {62, 0}, {50, 0}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vcc_p.n, ground1.p) annotation(Line(points = {{40, 22}, {40, 26}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground.p, Vcc_n.n) annotation(Line(points = {{40, -32}, {40, -22}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp.out, Vout) annotation(Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vcc_n2.p, opAmp2.VMin) annotation(Line(points = {{-54, -70}, {-54, -63}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp2.VMax, Vcc_p2.p) annotation(Line(points = {{-54, -49}, {-54, -42}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vcc_p2.n, ground5.p) annotation(Line(points = {{-54, -34}, {-54, -30}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground4.p, Vcc_n2.n) annotation(Line(points = {{-54, -88}, {-54, -78}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vin_n, opAmp2.in_p) annotation(Line(points = {{-100, -80}, {-82, -80}, {-82, -61}, {-64, -61}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp1.in_p, Vin_p) annotation(Line(points = {{-64, 55}, {-80, 55}, {-80, 80}, {-100, 80}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vcc_n1.p, opAmp1.VMin) annotation(Line(points = {{-54, 64}, {-54, 57}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vcc_n1.n, ground3.p) annotation(Line(points = {{-54, 72}, {-54, 76}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp1.VMax, Vcc_p1.p) annotation(Line(points = {{-54, 43}, {-54, 34}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Vcc_p1.n, ground2.p) annotation(Line(points = {{-54, 26}, {-54, 18}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp2.in_n, Rg.p) annotation(Line(points = {{-64, -51}, {-80, -51}, {-80, -16}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R6.p, Rg.p) annotation(Line(points = {{-70, -16}, {-80, -16}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R5.p, Rg.n) annotation(Line(points = {{-70, 4}, {-80, 4}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp1.in_n, Rg.n) annotation(Line(points = {{-64, 45}, {-72, 45}, {-72, 46}, {-80, 46}, {-80, 4}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp1.out, R3.p) annotation(Line(points = {{-44, 50}, {-20, 50}, {-20, 8}, {-12, 8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R6.n, R1.p) annotation(Line(points = {{-50, -16}, {-20, -16}, {-20, -8}, {-12, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(R5.n, opAmp1.out) annotation(Line(points = {{-50, 4}, {-40, 4}, {-40, 50}, {-44, 50}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(opAmp2.out, R6.n) annotation(Line(points = {{-44, -56}, {-40, -56}, {-40, -16}, {-50, -16}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation(Diagram(graphics), Icon(graphics={  Line(points = {{-60, 80}, {-60, -80}, {60, 0}, {-60, 80}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-58, 42}, {24, -34}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "A2"), Line(points = {{60, 0}, {98, 0}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-90, 80}, {-80, 80}, {-80, 60}, {-60, 60}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-90, -80}, {-80, -80}, {-80, -60}, {-60, -60}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-116, -48}, {-84, -76}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "+"), Text(extent = {{-116, 78}, {-84, 50}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "-")}));
  end DifferentialAmplifier2;
  annotation(uses(Modelica(version="3.2.2")));
end Chap2_PressureSensor;
