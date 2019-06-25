within ;
package Chap2_Scooter_Student
  model Scooter

   parameter Modelica.SIunits.Weight ScooterMass = 180
      "Scooter mass with driver";
   parameter Real Crr=1e-2 "Rolling coeficient";
   parameter Real Alpha=0.3 "Aerodynamic coefficient";
   constant Modelica.SIunits.Acceleration g = Modelica.Constants.g_n
      "Gravity constant";

    Modelica.Blocks.Interfaces.RealInput Slope "Slope " annotation (Placement(
          transformation(extent={{-120,-100},{-80,-60}}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-76})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
      "Flange of left shaft" annotation (Placement(transformation(extent={{-110,-40},
              {-90,-20}}), iconTransformation(extent={{-110,-40},{-90,-20}})));
    annotation (Diagram(graphics), Icon(graphics={
          Rectangle(
            extent={{-84,28},{-20,16}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-88,-20},{-84,8},{-68,22},{-66,28},{-40,28},{-24,16},{-30,2},
                {-18,-20},{-88,-20}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0}),
          Rectangle(
            extent={{-44,-12},{36,-20}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0}),
          Ellipse(
            extent={{42,8},{88,-40}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{36,-20},{38,-6},{42,4},{54,10},{70,14},{82,10},{88,12},{88,14},
                {86,20},{70,24},{58,48},{68,50},{68,60},{56,60},{52,66},{42,70},{22,
                70},{18,66},{22,64},{34,64},{52,24},{32,12},{26,-4},{24,-20},{36,-20}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{100,-36},{-100,-56},{100,-56}},
            color={0,0,0},
            smooth=Smooth.None),
          Ellipse(
            extent={{-78,-4},{-32,-52}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-92,-30},{-56,-30},{-60,-40}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{20,-64},{84,-86}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="Slope"),
          Rectangle(
            extent={{-24,-24},{-84,-20}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None)}));

  end Scooter;

  model TestScooter
    Chap2_Scooter_Student.Scooter scooter annotation (Placement(visible=true,
          transformation(extent={{-26,-8},{6,26}}, rotation=0)));
    Modelica.Blocks.Sources.Step stepForce(height=220.12)
      annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
    Modelica.Blocks.Sources.Step stepSlope(height=0.1)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Mechanics.Translational.Sources.Force force
      annotation (Placement(transformation(extent={{-64,-6},{-44,14}})));
  equation
    connect(stepSlope.y, scooter.Slope) annotation (
      Line(points={{-19,-30},{-10,-30},{-10,-3.92}},     color = {0, 0, 127}));
    connect(force.flange, scooter.flange_a) annotation (
      Line(points={{-44,4},{-36,4},{-36,3.9},{-26,3.9}},
                                          color = {0, 127, 0}));
    connect(stepForce.y, force.f) annotation (Line(
        points={{-79,4},{-66,4}},
        color={0,0,127}));
    annotation (Diagram(graphics));
  end TestScooter;

  model TestSlopeMotor
    Scooter scooter
      annotation (Placement(transformation(extent={{84,-8},{116,26}})));
    Modelica.Blocks.Sources.Step stepTorque
      annotation (Placement(transformation(extent={{-116,-6},{-96,14}})));
    Modelica.Blocks.Sources.Step stepSlope(height=0.1)
      annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel
      idealRollingWheel(radius=0.2)
      annotation (Placement(transformation(extent={{50,-6},{70,14}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(lossTable=[0,0.88,
                                                                                  0.88,
                  0,0])
      annotation (Placement(transformation(extent={{-4,-6},{16,14}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor
      annotation (Placement(transformation(extent={{-30,-6},{-10,14}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-88,-6},{-68,14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{-60,-6},{-40,14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1
      annotation (Placement(transformation(extent={{24,-6},{44,14}})));
  equation
    connect(stepSlope.y, scooter.Slope) annotation (Line(
        points={{91,-30},{100,-30},{100,-3.92}},
        color={0,0,127}));
    connect(idealRollingWheel.flangeT, scooter.flange_a) annotation (Line(
        points={{70,4},{74,4},{74,3.9},{84,3.9}},
        color={0,127,0}));
    connect(powerSensor1.flange_b, idealRollingWheel.flangeR) annotation (Line(
        points = {{44, 4}, {50, 4}}));
    connect(lossyGear.flange_b, powerSensor1.flange_a) annotation (Line(
        points = {{16, 4}, {24, 4}}));
    connect(inertiaReducerMotor.flange_b, lossyGear.flange_a) annotation (Line(
        points = {{-10, 4}, {-4, 4}}));
    connect(torque.tau, stepTorque.y) annotation (Line(
        points={{-90,4},{-95,4}},
        color={0,0,127}));
    connect(powerSensor.flange_b, inertiaReducerMotor.flange_a) annotation (
        Line(
        points = {{-40, 4}, {-30, 4}}));
    connect(torque.flange, powerSensor.flange_a) annotation (Line(
        points = {{-68, 4}, {-60, 4}}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{
              -150,-100},{150,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-150,-100},{150,100}})));
  end TestSlopeMotor;

  model TestAccelerationMotor
    Scooter scooter
      annotation (Placement(transformation(extent={{84,-8},{116,26}})));
    Modelica.Blocks.Sources.Step stepTorque
      annotation (Placement(transformation(extent={{-116,-6},{-96,14}})));
    Modelica.Blocks.Sources.Step stepSlope(height=0)
      annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
    Modelica.Mechanics.Translational.Components.IdealRollingWheel
      idealRollingWheel(radius=0.2)
      annotation (Placement(transformation(extent={{50,-6},{70,14}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(lossTable=[0,0.88,
                                                                                  0.88,
                  0,0])
      annotation (Placement(transformation(extent={{-4,-6},{16,14}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertiaReducerMotor
      annotation (Placement(transformation(extent={{-30,-6},{-10,14}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-88,-6},{-68,14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{-60,-6},{-40,14}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1
      annotation (Placement(transformation(extent={{24,-6},{44,14}})));
  equation
    connect(stepSlope.y, scooter.Slope) annotation (Line(
        points={{91,-30},{100,-30},{100,-3.92}},
        color={0,0,127}));
    connect(idealRollingWheel.flangeT, scooter.flange_a) annotation (Line(
        points={{70,4},{74,4},{74,3.9},{84,3.9}},
        color={0,127,0}));
    connect(powerSensor1.flange_b, idealRollingWheel.flangeR) annotation (Line(
        points = {{44, 4}, {50, 4}}));
    connect(lossyGear.flange_b, powerSensor1.flange_a) annotation (Line(
        points = {{16, 4}, {24, 4}}));
    connect(inertiaReducerMotor.flange_b, lossyGear.flange_a) annotation (Line(
        points = {{-10, 4}, {-4, 4}}));
    connect(powerSensor.flange_b, inertiaReducerMotor.flange_a) annotation (
        Line(
        points = {{-40, 4}, {-30, 4}}));
    connect(torque.flange, powerSensor.flange_a) annotation (Line(
        points = {{-68, 4}, {-60, 4}}));
    connect(torque.tau, stepTorque.y) annotation (Line(
        points={{-90,4},{-95,4}},
        color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{
              -150,-100},{150,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-150,-100},{150,100}})));
  end TestAccelerationMotor;
  annotation (uses(Modelica(version="3.2.2")));
end Chap2_Scooter_Student;
