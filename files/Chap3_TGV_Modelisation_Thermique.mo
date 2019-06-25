package Chap3_TGV_Modelisation_Thermique
  model ModeleTGV_1
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (
      Placement(visible = true, transformation(origin = {-28, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Sources.Step PertesPuissance(height = 5000, offset = 0) annotation (
      Placement(visible = true, transformation(extent = {{-90, 50}, {-70, 70}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourcePuissance(T_ref(displayUnit = "K") = 273.15 + 40) annotation (
      Placement(visible = true, transformation(extent = {{-50, 50}, {-30, 70}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CapaThEq(T(fixed = true, start = 273.15 + 40, displayUnit = "K"), C = 94730) annotation (
      Placement(visible = true, transformation(origin = {6, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor ResistanceThEq(R = 0.0279) annotation (
      Placement(visible = true, transformation(extent = {{28, 50}, {48, 70}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TempAmbiante(T(displayUnit = "K") = 40 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {84, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourcePuissance2(T_ref(displayUnit = "K") = 273.15 + 40) annotation (
      Placement(visible = true, transformation(extent = {{-54, -48}, {-34, -28}}, rotation = 0)));
    Modelica.Blocks.Sources.Step PertesPuissance2(height = 10000, offset = 0) annotation (
      Placement(visible = true, transformation(extent = {{-94, -48}, {-74, -28}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor2 annotation (
      Placement(visible = true, transformation(origin = {-32, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CapaThEq2(C = 94730, T(displayUnit = "K", fixed = true, start = 273.15 + 40)) annotation (
      Placement(visible = true, transformation(origin = {2, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor ResistanceThEq2(R = 0.0279) annotation (
      Placement(visible = true, transformation(extent = {{24, -48}, {44, -28}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TempAmbiante2(T(displayUnit = "K") = 40 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {80, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    connect(temperatureSensor2.port, CapaThEq2.port) annotation (
      Line(points = {{-32, -58}, {2, -58}, {2, -58}, {2, -58}}, color = {191, 0, 0}));
    connect(CapaThEq2.port, ResistanceThEq2.port_a) annotation (
      Line(points = {{2, -58}, {2, -58}, {2, -38}, {24, -38}, {24, -38}}, color = {191, 0, 0}));
    connect(ResistanceThEq2.port_b, TempAmbiante2.port) annotation (
      Line(points = {{44, -38}, {70, -38}, {70, -38}, {70, -38}}, color = {191, 0, 0}));
    connect(SourcePuissance2.port, ResistanceThEq2.port_a) annotation (
      Line(points = {{-34, -38}, {24, -38}, {24, -38}, {24, -38}}, color = {191, 0, 0}));
    connect(PertesPuissance2.y, SourcePuissance2.Q_flow) annotation (
      Line(points={{-73,-38},{-54,-38},{-54,-38},{-54,-38}},          color = {0, 0, 127}));
    connect(CapaThEq.port, ResistanceThEq.port_a) annotation (
      Line(points = {{6, 40}, {6, 40}, {6, 60}, {28, 60}, {28, 60}}, color = {191, 0, 0}));
    connect(temperatureSensor.port, CapaThEq.port) annotation (
      Line(points = {{-28, 40}, {6, 40}}, color = {191, 0, 0}));
    connect(ResistanceThEq.port_b, TempAmbiante.port) annotation (
      Line(points = {{48, 60}, {74, 60}}, color = {191, 0, 0}));
    connect(ResistanceThEq.port_a, SourcePuissance.port) annotation (
      Line(points = {{28, 60}, {-30, 60}}, color = {191, 0, 0}));
    connect(SourcePuissance.Q_flow, PertesPuissance.y) annotation (
      Line(points = {{-50, 60}, {-69, 60}}, color = {0, 0, 127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Text(origin = {-57, 90}, extent = {{-15, 8}, {49, -24}}, textString = "Fonctionnement normal"), Text(origin = {-61, -8}, extent = {{-15, 8}, {53, -26}}, textString = "Fonctionnement record du monde")}),
      experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 20));
  end ModeleTGV_1;

  model ModeleTGV_2
    Modelica.Blocks.Sources.Step step(height = 5000, offset = 0, startTime = 0) annotation (
      Placement(visible = true, transformation(extent = {{-94, 52}, {-74, 72}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow(T_ref = 313.15) annotation (
      Placement(visible = true, transformation(extent = {{-58, 52}, {-38, 72}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RthCuivre(R = 0.6 * 1E-3 / (140E-3 * 0.54)) annotation (
      Placement(visible = true, transformation(extent = {{-12, 52}, {8, 72}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RthFer(R = 1 / (1 * 50)) annotation (
      Placement(visible = true, transformation(extent = {{38, 52}, {58, 72}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = 385 * 50, T(fixed = true, start = 313.15)) annotation (
      Placement(visible = true, transformation(origin = {-42, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = 444 * 170, T(fixed = true, start = 313.15)) annotation (
      Placement(visible = true, transformation(origin = {54, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TemperatureAmbient(T = 313.15) annotation (
      Placement(visible = true, transformation(origin = {80, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureCuivre annotation (
      Placement(visible = true, transformation(origin = {-16, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureFer annotation (
      Placement(visible = true, transformation(origin = {20, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation (
      Placement(visible = true, transformation(extent = {{-62, -46}, {-42, -26}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step1(height = 10000, offset = 0, startTime = 0) annotation (
      Placement(visible = true, transformation(extent = {{-98, -46}, {-78, -26}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RthCuivre2(R = 0.6 * 1E-3 / (140E-3 * 0.54)) annotation (
      Placement(visible = true, transformation(extent = {{-16, -46}, {4, -26}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureFer2 annotation (
      Placement(visible = true, transformation(origin = {12, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureCuivre2 annotation (
      Placement(visible = true, transformation(origin = {-20, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(C = 444 * 170, T(fixed = true, start = 313.15)) annotation (
      Placement(visible = true, transformation(origin = {50, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor3(C = 385 * 50, T(fixed = true, start = 313.15)) annotation (
      Placement(visible = true, transformation(origin = {-46, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RthFer2(R = 1 / (1 * 50)) annotation (
      Placement(visible = true, transformation(extent = {{34, -46}, {54, -26}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TemperatureAmbient2(T = 313.15) annotation (
      Placement(visible = true, transformation(origin = {76, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    connect(temperatureCuivre2.port, RthCuivre2.port_a) annotation (
      Line(points = {{-20, -62}, {-20, -62}, {-20, -36}, {-16, -36}, {-16, -36}}, color = {191, 0, 0}));
    connect(heatCapacitor3.port, temperatureCuivre2.port) annotation (
      Line(points = {{-46, -62}, {-20, -62}, {-20, -62}, {-20, -62}}, color = {191, 0, 0}));
    connect(temperatureFer2.port, heatCapacitor2.port) annotation (
      Line(points = {{12, -60}, {50, -60}, {50, -60}, {50, -60}}, color = {191, 0, 0}));
    connect(RthCuivre2.port_b, temperatureFer2.port) annotation (
      Line(points = {{4, -36}, {12, -36}, {12, -60}, {12, -60}, {12, -60}}, color = {191, 0, 0}));
    connect(RthFer2.port_b, TemperatureAmbient2.port) annotation (
      Line(points = {{54, -36}, {66, -36}, {66, -36}, {66, -36}}, color = {191, 0, 0}));
    connect(RthCuivre2.port_b, RthFer2.port_a) annotation (
      Line(points = {{4, -36}, {34, -36}, {34, -36}, {34, -36}}, color = {191, 0, 0}));
    connect(prescribedHeatFlow1.port, RthCuivre2.port_a) annotation (
      Line(points = {{-42, -36}, {-16, -36}, {-16, -36}, {-16, -36}}, color = {191, 0, 0}));
    connect(step1.y, prescribedHeatFlow1.Q_flow) annotation (
      Line(points={{-77,-36},{-62,-36},{-62,-36},{-62,-36}},          color = {0, 0, 127}));
    connect(temperatureCuivre.port, RthCuivre.port_a) annotation (
      Line(points = {{-16, 36}, {-16, 62}, {-12, 62}}, color = {191, 0, 0}));
    connect(temperatureFer.port, RthCuivre.port_b) annotation (
      Line(points = {{20, 36}, {20, 36}, {20, 62}, {8, 62}, {8, 62}}, color = {191, 0, 0}));
    connect(heatCapacitor1.port, temperatureFer.port) annotation (
      Line(points = {{54, 38}, {20, 38}, {20, 36}, {20, 36}}, color = {191, 0, 0}));
    connect(heatCapacitor.port, temperatureCuivre.port) annotation (
      Line(points = {{-42, 36}, {-16, 36}, {-16, 36}, {-16, 36}}, color = {191, 0, 0}));
    connect(TemperatureAmbient.port, RthFer.port_b) annotation (
      Line(points = {{70, 62}, {58, 62}}, color = {191, 0, 0}));
    connect(RthCuivre.port_b, RthFer.port_a) annotation (
      Line(points = {{8, 62}, {38, 62}}, color = {191, 0, 0}));
    connect(prescribedHeatFlow.port, RthCuivre.port_a) annotation (
      Line(points = {{-38, 62}, {-12, 62}}, color = {191, 0, 0}));
    connect(step.y, prescribedHeatFlow.Q_flow) annotation (
      Line(points = {{-73, 62}, {-58, 62}}, color = {0, 0, 127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Text(origin = {-62, 87}, extent = {{-20, 9}, {30, -17}}, textString = "Fonctionnement normal"), Text(origin = {-54, -9}, extent = {{-30, 19}, {38, -21}}, textString = "Fonctionnement record du monde")}),
      experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 20));
  end ModeleTGV_2;
  annotation (
    uses(Modelica(version="3.2.2")));
end Chap3_TGV_Modelisation_Thermique;
