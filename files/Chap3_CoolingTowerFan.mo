within ;
package Chap3_CoolingTowerFan
  model Steady_State
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{2,-10},{22,10}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(                    w_nominal=19.37,
        tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={74,0})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-28,-24})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1e-3)
      annotation (Placement(transformation(extent={{48,-4},{56,4}})));
    Modelica.Blocks.Tables.CombiTable1D TorqueSpeed(table=[0,454; 80,579; 160,
          784; 220,997; 240,1057; 250,1071; 260,1060; 280,919; 300,500; 314,0])
      annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  equation
    connect(speedSensor.flange, torque.flange) annotation (Line(
        points={{-28,-14},{-28,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, lossyGear.flange_a) annotation (Line(
        points={{-28,0},{2,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia.flange_b, quadraticSpeedDependentTorque.flange) annotation (
       Line(
        points={{56,0},{64,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia.flange_a, lossyGear.flange_b) annotation (Line(
        points={{48,0},{22,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(TorqueSpeed.y[1], torque.tau) annotation (Line(
        points={{-57,0},{-50,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, TorqueSpeed.u[1]) annotation (Line(
        points={{-28,-35},{-28,-40},{-92,-40},{-92,0},{-80,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end Steady_State;

  model Transient_Dynamic
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{6,-10},{26,10}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(                    w_nominal(displayUnit=
            "rad/s") = 19.373154697137, tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={74,0})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-28,-24})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan(J=3000)
      annotation (Placement(transformation(extent={{34,-10},{54,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor(J=1.72)
      annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
    Modelica.Blocks.Tables.CombiTable1D TorqueSpeed(table=[0,454; 80,579; 160,
          784; 220,997; 240,1057; 250,1071; 260,1060; 280,919; 300,500; 314,0])
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  equation
    connect(speedSensor.flange, torque.flange) annotation (Line(
        points={{-28,-14},{-28,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.flange_b, inertia_fan.flange_a) annotation (Line(
        points={{26,0},{34,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan.flange_b, quadraticSpeedDependentTorque.flange)
      annotation (Line(
        points={{54,0},{64,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, inertia_motor.flange_a) annotation (Line(
        points={{-28,0},{-22,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_motor.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-2,0},{6,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(TorqueSpeed.y[1], torque.tau) annotation (Line(
        points={{-59,0},{-50,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, TorqueSpeed.u[1]) annotation (Line(
        points={{-28,-35},{-28,-40},{-92,-40},{-92,0},{-82,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end Transient_Dynamic;

  package LossModel
    package FrictionModels "Friction models for mechanical components"
      model Friction_tanh_rotational
        "Bi-directional friction torque calculated from efficiencies"
        extends
          Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        import SI = Modelica.SIunits;
        parameter Boolean useHeatPort = false "=true, if HeatPort is enabled" annotation(Evaluate = true, HideResult = true, choices(__Dymola_checkBox = true));
        parameter input SI.Efficiency eta_d_input = 1 "Direct efficiency";
        parameter input SI.Efficiency eta_i_input = 1 "Indirect efficiency";
        Modelica.SIunits.Angle phi_a;
        Modelica.SIunits.Angle phi_b;
        SI.Torque tau_friction;
        SI.AngularVelocity w_a;
        SI.AngularVelocity w_b;
        Real quadrant_a "quadrant du flange_a";
        Real quadrant_b "quadrant du flange_b";
        constant SI.Power Pref = 0.000000001 "reference power";
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow FrictionLoss annotation(Placement(transformation(origin = {0,46}, extent = {{-10,-10},{10,10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a if useHeatPort
          "Heat Port"                                                                         annotation(Placement(transformation(extent = {{-10,100},{10,120}}, rotation = 0)));
        SensorSources.Thermal_to_Real thermal_to_Real if not useHeatPort annotation(Placement(transformation(extent = {{34,64},{54,84}})));
      equation
        phi_a = flange_a.phi - phi_support;
        phi_b = flange_b.phi - phi_support;
        w_a = der(phi_a);
        w_b = der(phi_b);
        phi_a = phi_b;
        0 = flange_a.tau + flange_b.tau + tau_friction;
        // Quadrants
        quadrant_a = (1 + tanh((w_a * flange_a.tau) / Pref)) / 2;
        // = 1 flange_a moteur; = 0 flange_a frein
        quadrant_b = (1 + tanh((w_b * flange_b.tau) / Pref)) / 2;
        // = 1 flange_b moteur; = 0 flange_b frein
        // Friction torque
        tau_friction = quadrant_a * (eta_d_input - 1) * flange_a.tau + quadrant_b * (eta_i_input - 1) * flange_b.tau;
        //Heat flow
      algorithm
        FrictionLoss.Q_flow:=abs(quadrant_a * (1 - eta_d_input) * flange_a.tau * w_a) + abs(quadrant_b * (1 - eta_i_input) * flange_b.tau * w_b);
        // Friction loss
      equation
        connect(FrictionLoss.port,port_a) annotation(Line(points = {{0.000000000000000612323,56},{0,56},{0,110}}, color = {191,0,0}));
        connect(FrictionLoss.port,thermal_to_Real.port_a) annotation(Line(points = {{0.000000000000000612323,56},{0,62},{0,74},{34,74}}, color = {191,0,0}, smooth = Smooth.None));
        annotation(Documentation(info = "<html>
<p>
This element describes a rotational friction represented by a <b>tanh</b> function, using direct and indirect efficiency.
This friction generates <b>heat flow</b> that can be output.
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version by Jonathan Liscouet and Marc Budinger</i> </li>
</ul>
</html>"),   Icon(graphics={  Rectangle(extent = {{-90,10},{90,-10}}, lineColor = {0,0,0},
                  fillPattern =                                                                          FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Line(points = {{-40,-40},{40,-40}}, color = {0,0,0}),Text(extent = {{-150,100},{150,60}}, textString = "%name"),Line(points = {{-40,-26},{40,-26}}, color = {0,0,0}, pattern = LinePattern.Dot),Line(points = {{-49,40},{40,40}}, color = {0,0,0}, arrow = {Arrow.None,Arrow.Filled}),Line(points = {{0,-40},{0,-90}}, color = {0,0,0}),Polygon(points = {{-62,-12},{66,-12},{66,-72},{76,-72},{56,-92},{36,-72},{46,-72},{46,-22},{-60,-22},{-64,-12},{-62,-12}}, lineColor = {0,0,0}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Polygon(points = {{-46,-12},{-46,-12},{-46,-72},{-36,-72},{-56,-92},{-76,-72},{-66,-72},{-66,-22},{-66,-12},{-46,-12},{-46,-12}}, lineColor = {0,0,0}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid)}), Diagram(graphics));
      end Friction_tanh_rotational;

      model Friction_hysteresis_rotational
        "Friction torque calculated from efficiency for inverse simulation"
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        import SI = Modelica.SIunits;
        parameter SI.Efficiency eta_d = 0.9 "Direct efficiency";
        parameter SI.Efficiency eta_i = 0.8 "Indirect efficiency";
        parameter SI.Power Pref = 0.00001 "Reference power";
        parameter SI.AngularVelocity Vref = 0.001 "Reference speed";
        parameter Real k0 = 1.5
          "Ration Static friction force / Kinetic friction force";
        Modelica.Blocks.Logical.Hysteresis QuadrantMotor(uLow = -Pref, uHigh = Pref, pre_y_start = true) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {8,-30})));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation(Placement(transformation(extent = {{6,-10},{26,10}})));
        Modelica.Mechanics.Rotational.Sources.Torque FrictionTorque annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 0, origin = {-82,-32})));
        Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation(Placement(transformation(extent = {{50,-10},{70,10}})));
        Modelica.Blocks.Math.Gain G_inverse(k = -(eta_i - 1)) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {44,-30})));
        Modelica.Blocks.Math.Gain G_direct(k = -(1 / eta_d - 1)) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {80,-30})));
        Modelica.Blocks.Logical.Switch switch1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {20,-60})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(Placement(transformation(extent = {{-94,16},{-74,36}})));
        Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = Vref) annotation(Placement(transformation(extent = {{-28,16},{-8,36}})));
        Modelica.Blocks.Logical.Switch switch2 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-56,-32})));
        Modelica.Blocks.Math.Gain gain(k = k0) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-30,-16})));
        Modelica.Blocks.Math.Abs abs1 annotation(Placement(transformation(extent = {{-62,16},{-42,36}})));
      equation
        connect(QuadrantMotor.u,powerSensor.power) annotation(Line(points = {{8,-18},{8,-11}}, color = {0,0,127}, smooth = Smooth.None));
        connect(FrictionTorque.flange,flange_a) annotation(Line(points = {{-92,-32},{-94,-32},{-94,0},{-100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(powerSensor.flange_b,torqueSensor.flange_a) annotation(Line(points = {{26,0},{50,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torqueSensor.flange_b,flange_b) annotation(Line(points = {{70,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(G_inverse.u,torqueSensor.tau) annotation(Line(points = {{44,-18},{44,-10},{52,-10},{52,-11}}, color = {0,0,127}, smooth = Smooth.None));
        connect(G_direct.u,torqueSensor.tau) annotation(Line(points = {{80,-18},{80,-11},{52,-11}}, color = {0,0,127}, smooth = Smooth.None));
        connect(switch1.u3,G_inverse.y) annotation(Line(points = {{32,-52},{44,-52},{44,-41}}, color = {0,0,127}, smooth = Smooth.None));
        connect(switch1.u1,G_direct.y) annotation(Line(points = {{32,-68},{80,-68},{80,-41}}, color = {0,0,127}, smooth = Smooth.None));
        connect(flange_a,powerSensor.flange_a) annotation(Line(points = {{-100,0},{6,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(speedSensor.flange,flange_a) annotation(Line(points = {{-94,26},{-94,0},{-100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(greaterEqualThreshold.y,switch2.u2) annotation(Line(points = {{-7,26},{-4,26},{-4,-32},{-44,-32}}, color = {255,0,255}, smooth = Smooth.None));
        connect(switch1.y,switch2.u1) annotation(Line(points = {{9,-60},{-28,-60},{-28,-40},{-44,-40}}, color = {0,0,127}, smooth = Smooth.None));
        connect(switch2.y,FrictionTorque.tau) annotation(Line(points = {{-67,-32},{-70,-32}}, color = {0,0,127}, smooth = Smooth.None));
        connect(switch2.u3,gain.y) annotation(Line(points = {{-44,-24},{-42,-24},{-42,-16},{-41,-16}}, color = {0,0,127}, smooth = Smooth.None));
        connect(gain.u,switch1.y) annotation(Line(points = {{-18,-16},{-14,-16},{-14,-60},{9,-60}}, color = {0,0,127}, smooth = Smooth.None));
        connect(QuadrantMotor.y,switch1.u2) annotation(Line(points = {{8,-41},{8,-46},{38,-46},{38,-60},{32,-60}}, color = {255,0,255}, smooth = Smooth.None));
        connect(abs1.y,greaterEqualThreshold.u) annotation(Line(points = {{-41,26},{-30,26}}, color = {0,0,127}, smooth = Smooth.None));
        connect(abs1.u,speedSensor.w) annotation(Line(points = {{-64,26},{-73,26}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Documentation(info = "<html>
<p>
This element describes a torque friction represented by a speed <b>hysteresis</b> function, using direct and indirect efficiency.
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version by Jonathan Liscouet and Marc Budinger</i> </li>
</ul>
</html>"),   Icon(graphics={  Rectangle(extent = {{-90,10},{90,-10}}, lineColor = {0,0,0},
                  fillPattern =                                                                          FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Line(points = {{-40,-40},{40,-40}}, color = {0,0,0}),Text(extent = {{-150,100},{150,60}}, textString = "%name"),Line(points = {{-40,-26},{40,-26}}, color = {0,0,0}, pattern = LinePattern.Dot),Line(points = {{-49,40},{40,40}}, color = {0,0,0}, arrow = {Arrow.None,Arrow.Filled}),Line(points = {{0,-40},{0,-90}}, color = {0,0,0}),Polygon(points = {{-62,-12},{66,-12},{66,-72},{76,-72},{56,-92},{36,-72},{46,-72},{46,-22},{-60,-22},{-64,-12},{-62,-12}}, lineColor = {0,0,0}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Polygon(points = {{-46,-12},{-46,-12},{-46,-72},{-36,-72},{-56,-92},{-76,-72},{-66,-72},{-66,-22},{-66,-12},{-46,-12},{-46,-12}}, lineColor = {0,0,0}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid)}), Diagram(graphics));
      end Friction_hysteresis_rotational;
      annotation(Icon(graphics={  Rectangle(extent = {{-100,100},{100,-100}}, fillColor = {255,255,255},
                fillPattern =                                                                                          FillPattern.Solid, lineColor = {215,215,215}),Rectangle(extent = {{0,92},{86,6}}, lineColor = {0,127,0}, fillColor = {255,255,255},
                fillPattern =                                                                                                   FillPattern.Solid),Ellipse(extent = {{-80,60},{28,-40}}, lineColor = {0,127,0}, fillColor = {255,255,255},
                fillPattern =                                                                                                   FillPattern.Solid),Polygon(points = {{-26,6},{-70,-90},{90,-90},{-26,6}}, lineColor = {0,127,0}, smooth = Smooth.None, fillColor = {255,255,255},
                fillPattern =                                                                                                   FillPattern.Solid)}));
    end FrictionModels;

    package FrictionTest
      package Friction_tanh_rotational
        model tanh_test
          FrictionModels.Friction_tanh_rotational friction_tanh_rotational(eta_d_input = 0.51, eta_i_input = 0.35, useHeatPort = false) annotation(Placement(transformation(extent = {{18,48},{38,68}})));
          Modelica.Blocks.Sources.Sine Couple(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{-78,70},{-58,90}})));
          Modelica.Blocks.Sources.Sine Deplacement_angulaire(freqHz = 1) annotation(Placement(transformation(extent = {{-78,30},{-58,50}})));
          SensorSources.Real_to_mechRotational real_to_mechRotational annotation(Placement(transformation(extent = {{-38,48},{-18,68}})));
          FrictionModels.Friction_tanh_rotational friction_tanh_rotational1(eta_d_input = 0.51, eta_i_input = 0.35, useHeatPort = false) annotation(Placement(transformation(extent = {{-6,-76},{14,-56}})));
          SensorSources.mechRotational_to_Real mechRotational_to_Real annotation(Placement(transformation(extent = {{72,48},{92,68}})));
          Modelica.Blocks.Sources.Sine Couple2(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {84,-66})));
          Modelica.Blocks.Sources.Sine Deplacement_angulaire2(freqHz = 1) annotation(Placement(transformation(extent = {{-90,-76},{-70,-56}})));
          Modelica.Mechanics.Rotational.Sources.Position position annotation(Placement(transformation(extent = {{-62,-76},{-42,-56}})));
          Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {56,-66})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left annotation(Placement(transformation(extent = {{-10,48},{10,68}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right annotation(Placement(transformation(extent = {{44,48},{66,68}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left1 annotation(Placement(transformation(extent = {{-34,-76},{-14,-56}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right1 annotation(Placement(transformation(extent = {{20,-76},{42,-56}})));
        equation
          connect(Couple.y,real_to_mechRotational.torque_input) annotation(Line(points = {{-57,80},{-45.5,80},{-45.5,62},{-37,62}}, color = {0,0,127}, smooth = Smooth.None));
          connect(real_to_mechRotational.phi_input,Deplacement_angulaire.y) annotation(Line(points = {{-37,54},{-46,54},{-46,40},{-57,40}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque.tau,Couple2.y) annotation(Line(points = {{68,-66},{73,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(position.phi_ref,Deplacement_angulaire2.y) annotation(Line(points = {{-64,-66},{-69,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(powerSensor_Left.flange_a,real_to_mechRotational.flange) annotation(Line(points = {{-10,58},{-18.2,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left.flange_b,friction_tanh_rotational.flange_a) annotation(Line(points = {{10,58},{18,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right.flange_a,friction_tanh_rotational.flange_b) annotation(Line(points = {{44,58},{38,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right.flange_b,mechRotational_to_Real.flange) annotation(Line(points = {{66,58},{72,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right1.flange_b,torque.flange) annotation(Line(points = {{42,-66},{46,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right1.flange_a,friction_tanh_rotational1.flange_b) annotation(Line(points = {{20,-66},{14,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left1.flange_a,position.flange) annotation(Line(points = {{-34,-66},{-42,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left1.flange_b,friction_tanh_rotational1.flange_a) annotation(Line(points = {{-14,-66},{-6,-66}}, color = {0,0,0}, smooth = Smooth.None));
          annotation(Diagram(graphics = {Rectangle(extent = {{-94,-20},{96,-90}}, lineColor = {0,127,0}, lineThickness = 0.5),Rectangle(extent = {{-94,96},{96,22}}, lineColor = {255,0,0}, lineThickness = 0.5),Text(extent = {{-202,20},{46,18}}, lineColor = {255,0,0}, fillPattern = FillPattern.Solid, textString = "Inverse simulation"),Text(extent = {{-202,-16},{46,-18}}, lineColor = {0,127,0}, fillPattern = FillPattern.Solid, textString = "Direct simulation")}));
        end tanh_test;

        model Direct_test
          Modelica.Blocks.Sources.Sine Couple2(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-80,-66})));
          Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-50,-66})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left1 annotation(Placement(transformation(extent = {{-34,-76},{-14,-56}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right1 annotation(Placement(transformation(extent = {{20,-76},{42,-56}})));
          FrictionModels.Friction_tanh_rotational lossygear2(Pref = 0.001, eta_d_input = 0.5, eta_i_input = 0.3) annotation(Placement(transformation(extent = {{-8,-76},{12,-56}})));
          Modelica.Mechanics.Rotational.Components.Damper damper(d = 1) annotation(Placement(transformation(extent = {{48,-76},{68,-56}})));
          Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{68,-78},{88,-58}})));
          Modelica.Blocks.Sources.Sine Couple1(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-82,40})));
          Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-52,40})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left2 annotation(Placement(transformation(extent = {{-36,30},{-16,50}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right2 annotation(Placement(transformation(extent = {{18,30},{40,50}})));
          FrictionModels.Friction_tanh_rotational lossygear1(Pref = 0.001, eta_d_input = 0.5, eta_i_input = 0.3) annotation(Placement(transformation(extent = {{-10,30},{10,50}})));
          Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1) annotation(Placement(transformation(extent = {{48,30},{68,50}})));
        equation
          connect(powerSensor_Left1.flange_b,lossygear2.flange_a) annotation(Line(points = {{-14,-66},{-8,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(lossygear2.flange_b,powerSensor_Right1.flange_a) annotation(Line(points = {{12,-66},{20,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(Couple2.y,torque.tau) annotation(Line(points = {{-69,-66},{-62,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque.flange,powerSensor_Left1.flange_a) annotation(Line(points = {{-40,-66},{-34,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(damper.flange_b,fixed.flange) annotation(Line(points = {{68,-66},{73,-66},{73,-68},{78,-68}}, color = {0,0,0}, smooth = Smooth.None));
          connect(damper.flange_a,powerSensor_Right1.flange_b) annotation(Line(points = {{48,-66},{42,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left2.flange_b,lossygear1.flange_a) annotation(Line(points = {{-16,40},{-10,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(lossygear1.flange_b,powerSensor_Right2.flange_a) annotation(Line(points = {{10,40},{18,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(Couple1.y,torque1.tau) annotation(Line(points = {{-71,40},{-64,40}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque1.flange,powerSensor_Left2.flange_a) annotation(Line(points = {{-42,40},{-36,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right2.flange_b,inertia.flange_a) annotation(Line(points = {{40,40},{48,40}}, color = {0,0,0}, smooth = Smooth.None));
          annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(extent = {{-100,-100},{100,100}})));
        end Direct_test;
        annotation(Icon(graphics={  Rectangle(extent = {{-90,10},{90,-10}}, lineColor = {0,0,0}),Line(points = {{-40,-40},{40,-40}}, color = {0,0,0}),Line(points = {{-40,-26},{40,-26}}, color = {0,0,0}, pattern = LinePattern.Dot),Line(points = {{0,-40},{0,-90}}, color = {0,0,0}),Polygon(points = {{-62,-12},{66,-12},{66,-72},{76,-72},{56,-92},{36,-72},{46,-72},{46,-22},{-60,-22},{-64,-12},{-62,-12}}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None),Polygon(points = {{-46,-12},{-46,-12},{-46,-72},{-36,-72},{-56,-92},{-76,-72},{-66,-72},{-66,-22},{-66,-12},{-46,-12},{-46,-12}}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None),Rectangle(extent = {{-100,100},{100,-100}}, pattern = LinePattern.None, lineColor = {215,215,215})}), Diagram(graphics));
      end Friction_tanh_rotational;

      package Friction_hysteresis_rotational_test
        model hyst_test
          FrictionModels.Friction_hysteresis_rotational friction_hys_rotational(eta_d = 0.5, eta_i = 0.35, Pref = 0.001, k0 = 1) annotation(Placement(transformation(extent = {{18,48},{38,68}})));
          Modelica.Blocks.Sources.Sine Couple(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{-78,70},{-58,90}})));
          Modelica.Blocks.Sources.Sine Deplacement_angulaire(freqHz = 1) annotation(Placement(transformation(extent = {{-78,30},{-58,50}})));
          SensorSources.Real_to_mechRotational real_to_mechRotational annotation(Placement(transformation(extent = {{-38,48},{-18,68}})));
          FrictionModels.Friction_hysteresis_rotational friction_hys_rotational1(eta_d = 0.5, eta_i = 0.35, Pref = 0.001, k0 = 1) annotation(Placement(transformation(extent = {{-6,-76},{14,-56}})));
          SensorSources.mechRotational_to_Real mechRotational_to_Real annotation(Placement(transformation(extent = {{70,48},{90,68}})));
          Modelica.Blocks.Sources.Sine Couple2(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {84,-66})));
          Modelica.Blocks.Sources.Sine Deplacement_angulaire2(freqHz = 1) annotation(Placement(transformation(extent = {{-90,-76},{-70,-56}})));
          Modelica.Mechanics.Rotational.Sources.Position position annotation(Placement(transformation(extent = {{-62,-76},{-42,-56}})));
          Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {56,-66})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left annotation(Placement(transformation(extent = {{-10,48},{10,68}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right annotation(Placement(transformation(extent = {{44,48},{66,68}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left1 annotation(Placement(transformation(extent = {{-34,-76},{-14,-56}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right1 annotation(Placement(transformation(extent = {{20,-76},{42,-56}})));
        equation
          connect(Couple.y,real_to_mechRotational.torque_input) annotation(Line(points = {{-57,80},{-45.5,80},{-45.5,62},{-37,62}}, color = {0,0,127}, smooth = Smooth.None));
          connect(real_to_mechRotational.phi_input,Deplacement_angulaire.y) annotation(Line(points = {{-37,54},{-46,54},{-46,40},{-57,40}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque.tau,Couple2.y) annotation(Line(points = {{68,-66},{73,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(position.phi_ref,Deplacement_angulaire2.y) annotation(Line(points = {{-64,-66},{-69,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(powerSensor_Left.flange_a,real_to_mechRotational.flange) annotation(Line(points = {{-10,58},{-18.2,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left.flange_b,friction_hys_rotational.flange_a) annotation(Line(points = {{10,58},{18,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right.flange_a,friction_hys_rotational.flange_b) annotation(Line(points = {{44,58},{38,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right.flange_b,mechRotational_to_Real.flange) annotation(Line(points = {{66,58},{70,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right1.flange_b,torque.flange) annotation(Line(points = {{42,-66},{46,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right1.flange_a,friction_hys_rotational1.flange_b) annotation(Line(points = {{20,-66},{14,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left1.flange_a,position.flange) annotation(Line(points = {{-34,-66},{-42,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left1.flange_b,friction_hys_rotational1.flange_a) annotation(Line(points = {{-14,-66},{-6,-66}}, color = {0,0,0}, smooth = Smooth.None));
          annotation(Diagram(graphics={  Rectangle(extent = {{-94,-20},{96,-90}}, lineColor = {0,127,0},
                    lineThickness =                                                                                      0.5),Rectangle(extent = {{-94,96},{96,22}}, lineColor = {255,0,0},
                    lineThickness =                                                                                                   0.5),Text(extent = {{-202,20},{46,18}}, lineColor = {255,0,0},
                    fillPattern =                                                                                                   FillPattern.Solid, textString = "Inverse simulation"),Text(extent = {{-202,-16},{46,-18}}, lineColor = {0,127,0},
                    fillPattern =                                                                                                   FillPattern.Solid, textString = "Direct simulation")}));
        end hyst_test;

        model Direct_test
          Modelica.Blocks.Sources.Sine Couple2(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-80,-66})));
          Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-50,-66})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left1 annotation(Placement(transformation(extent = {{-34,-76},{-14,-56}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right1 annotation(Placement(transformation(extent = {{20,-76},{42,-56}})));
          FrictionModels.Friction_hysteresis_rotational lossygear2(eta_d = 0.5, eta_i = 0.3, Pref = 0.001) annotation(Placement(transformation(extent = {{-8,-76},{12,-56}})));
          Modelica.Mechanics.Rotational.Components.Damper damper(d = 1) annotation(Placement(transformation(extent = {{48,-76},{68,-56}})));
          Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{68,-78},{88,-58}})));
          Modelica.Blocks.Sources.Sine Couple1(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-82,40})));
          Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-52,40})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left2 annotation(Placement(transformation(extent = {{-36,30},{-16,50}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right2 annotation(Placement(transformation(extent = {{18,30},{40,50}})));
          FrictionModels.Friction_hysteresis_rotational lossygear1(eta_d = 0.5, eta_i = 0.3, Pref = 0.001) annotation(Placement(transformation(extent = {{-10,30},{10,50}})));
          Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1) annotation(Placement(transformation(extent = {{48,30},{68,50}})));
        equation
          connect(powerSensor_Left1.flange_b,lossygear2.flange_a) annotation(Line(points = {{-14,-66},{-8,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(lossygear2.flange_b,powerSensor_Right1.flange_a) annotation(Line(points = {{12,-66},{20,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(Couple2.y,torque.tau) annotation(Line(points = {{-69,-66},{-62,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque.flange,powerSensor_Left1.flange_a) annotation(Line(points = {{-40,-66},{-34,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(damper.flange_b,fixed.flange) annotation(Line(points = {{68,-66},{73,-66},{73,-68},{78,-68}}, color = {0,0,0}, smooth = Smooth.None));
          connect(damper.flange_a,powerSensor_Right1.flange_b) annotation(Line(points = {{48,-66},{42,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left2.flange_b,lossygear1.flange_a) annotation(Line(points = {{-16,40},{-10,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(lossygear1.flange_b,powerSensor_Right2.flange_a) annotation(Line(points = {{10,40},{18,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(Couple1.y,torque1.tau) annotation(Line(points = {{-71,40},{-64,40}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque1.flange,powerSensor_Left2.flange_a) annotation(Line(points = {{-42,40},{-36,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right2.flange_b,inertia.flange_a) annotation(Line(points = {{40,40},{48,40}}, color = {0,0,0}, smooth = Smooth.None));
          annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(extent = {{-100,-100},{100,100}})));
        end Direct_test;

        model hyst_test2
          FrictionModels.Friction_hysteresis_rotational friction_hys_rotational(eta_d = 0.5, eta_i = 0.35, Pref = 0.001, k0 = 1) annotation(Placement(transformation(extent = {{18,48},{38,68}})));
          Modelica.Blocks.Sources.Sine Couple(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{-78,70},{-58,90}})));
          Modelica.Blocks.Sources.Sine Deplacement_angulaire(freqHz = 1) annotation(Placement(transformation(extent = {{-78,30},{-58,50}})));
          SensorSources.Real_to_mechRotational real_to_mechRotational annotation(Placement(transformation(extent = {{-38,48},{-18,68}})));
          FrictionModels.Friction_hysteresis_rotational friction_hys_rotational1(eta_d = 0.5, eta_i = 0.35, Pref = 0.001, k0 = 1) annotation(Placement(transformation(extent = {{-6,-76},{14,-56}})));
          SensorSources.mechRotational_to_Real mechRotational_to_Real annotation(Placement(transformation(extent = {{70,48},{90,68}})));
          Modelica.Blocks.Sources.Sine Couple2(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-78,-66})));
          Modelica.Blocks.Sources.Sine Deplacement_angulaire2(freqHz = 1) annotation(Placement(transformation(extent = {{94,-76},{74,-56}})));
          Modelica.Mechanics.Rotational.Sources.Position position annotation(Placement(transformation(extent = {{66,-76},{46,-56}})));
          Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-48,-66})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left annotation(Placement(transformation(extent = {{-10,48},{10,68}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right annotation(Placement(transformation(extent = {{44,48},{66,68}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left1 annotation(Placement(transformation(extent = {{-34,-76},{-14,-56}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right1 annotation(Placement(transformation(extent = {{20,-76},{42,-56}})));
        equation
          connect(Couple.y,real_to_mechRotational.torque_input) annotation(Line(points = {{-57,80},{-45.5,80},{-45.5,62},{-37,62}}, color = {0,0,127}, smooth = Smooth.None));
          connect(real_to_mechRotational.phi_input,Deplacement_angulaire.y) annotation(Line(points = {{-37,54},{-46,54},{-46,40},{-57,40}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque.tau,Couple2.y) annotation(Line(points = {{-60,-66},{-67,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(powerSensor_Left.flange_a,real_to_mechRotational.flange) annotation(Line(points = {{-10,58},{-18.2,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left.flange_b,friction_hys_rotational.flange_a) annotation(Line(points = {{10,58},{18,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right.flange_a,friction_hys_rotational.flange_b) annotation(Line(points = {{44,58},{38,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right.flange_b,mechRotational_to_Real.flange) annotation(Line(points = {{66,58},{70,58}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right1.flange_a,friction_hys_rotational1.flange_b) annotation(Line(points = {{20,-66},{14,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left1.flange_b,friction_hys_rotational1.flange_a) annotation(Line(points = {{-14,-66},{-6,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(torque.flange,powerSensor_Left1.flange_a) annotation(Line(points = {{-38,-66},{-34,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(position.flange,powerSensor_Right1.flange_b) annotation(Line(points = {{46,-66},{42,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(Deplacement_angulaire2.y,position.phi_ref) annotation(Line(points = {{73,-66},{68,-66}}, color = {0,0,127}, smooth = Smooth.None));
          annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Rectangle(extent = {{-94,-20},{96,-90}}, lineColor = {0,127,0},
                    lineThickness =                                                                                                   0.5),Rectangle(extent = {{-94,96},{96,22}}, lineColor = {255,0,0},
                    lineThickness =                                                                                                   0.5),Text(extent = {{-202,20},{46,18}}, lineColor = {255,0,0},
                    fillPattern =                                                                                                   FillPattern.Solid, textString = "Inverse simulation"),Text(extent = {{-202,-16},{46,-18}}, lineColor = {0,127,0},
                    fillPattern =                                                                                                   FillPattern.Solid, textString = "Direct simulation")}));
        end hyst_test2;
        annotation(Icon(graphics={  Rectangle(extent = {{-90,20},{90,0}}, lineColor = {0,0,0}),Line(points = {{-40,-30},{40,-30}}, color = {0,0,0}),Line(points = {{-40,-16},{40,-16}}, color = {0,0,0}, pattern = LinePattern.Dot),Line(points = {{0,-30},{0,-80}}, color = {0,0,0}),Polygon(points = {{-62,-2},{66,-2},{66,-62},{76,-62},{56,-82},{36,-62},{46,-62},{46,-12},{-60,-12},{-64,-2},{-62,-2}}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None),Polygon(points = {{-46,-2},{-46,-2},{-46,-62},{-36,-62},{-56,-82},{-76,-62},{-66,-62},{-66,-12},{-66,-2},{-46,-2},{-46,-2}}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None),Rectangle(extent = {{-100,110},{100,-90}}, pattern = LinePattern.None, lineColor = {215,215,215})}));
      end Friction_hysteresis_rotational_test;

      package Friction_lossyGearModelica
        model lossygear_test
          Modelica.Blocks.Sources.Sine Couple2(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-80,-66})));
          Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-50,-66})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left1 annotation(Placement(transformation(extent = {{-34,-76},{-14,-56}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right1 annotation(Placement(transformation(extent = {{20,-76},{42,-56}})));
          Modelica.Mechanics.Rotational.Components.LossyGear lossygear2(ratio = 1, lossTable = [0,0.5,0.35,0,0]) annotation(Placement(transformation(extent = {{-8,-76},{12,-56}})));
          Modelica.Mechanics.Rotational.Components.Damper damper(d = 1) annotation(Placement(transformation(extent = {{48,-76},{68,-56}})));
          Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{68,-78},{88,-58}})));
          Modelica.Blocks.Sources.Sine Couple1(freqHz = 2, phase = 1.5707963267949) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-82,40})));
          Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-52,40})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Left2 annotation(Placement(transformation(extent = {{-36,30},{-16,50}})));
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor_Right2 annotation(Placement(transformation(extent = {{18,30},{40,50}})));
          Modelica.Mechanics.Rotational.Components.LossyGear lossygear1(ratio = 1, lossTable = [0,0.5,0.35,0,0]) annotation(Placement(transformation(extent = {{-10,30},{10,50}})));
          Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 10) annotation(Placement(transformation(extent = {{48,30},{68,50}})));
        equation
          connect(powerSensor_Left1.flange_b,lossygear2.flange_a) annotation(Line(points = {{-14,-66},{-8,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(lossygear2.flange_b,powerSensor_Right1.flange_a) annotation(Line(points = {{12,-66},{20,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(Couple2.y,torque.tau) annotation(Line(points = {{-69,-66},{-62,-66}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque.flange,powerSensor_Left1.flange_a) annotation(Line(points = {{-40,-66},{-34,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(damper.flange_b,fixed.flange) annotation(Line(points = {{68,-66},{73,-66},{73,-68},{78,-68}}, color = {0,0,0}, smooth = Smooth.None));
          connect(damper.flange_a,powerSensor_Right1.flange_b) annotation(Line(points = {{48,-66},{42,-66}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Left2.flange_b,lossygear1.flange_a) annotation(Line(points = {{-16,40},{-10,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(lossygear1.flange_b,powerSensor_Right2.flange_a) annotation(Line(points = {{10,40},{18,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(Couple1.y,torque1.tau) annotation(Line(points = {{-71,40},{-64,40}}, color = {0,0,127}, smooth = Smooth.None));
          connect(torque1.flange,powerSensor_Left2.flange_a) annotation(Line(points = {{-42,40},{-36,40}}, color = {0,0,0}, smooth = Smooth.None));
          connect(powerSensor_Right2.flange_b,inertia.flange_a) annotation(Line(points = {{40,40},{48,40}}, color = {0,0,0}, smooth = Smooth.None));
          annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(extent = {{-100,-100},{100,100}})));
        end lossygear_test;
        annotation(Icon(graphics={  Rectangle(extent = {{-90,20},{90,0}}, lineColor = {0,0,0}),Line(points = {{-40,-30},{40,-30}}, color = {0,0,0}),Line(points = {{-40,-16},{40,-16}}, color = {0,0,0}, pattern = LinePattern.Dot),Line(points = {{0,-30},{0,-80}}, color = {0,0,0}),Polygon(points = {{-62,-2},{66,-2},{66,-62},{76,-62},{56,-82},{36,-62},{46,-62},{46,-12},{-60,-12},{-64,-2},{-62,-2}}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None),Polygon(points = {{-46,-2},{-46,-2},{-46,-62},{-36,-62},{-56,-82},{-76,-62},{-66,-62},{-66,-12},{-66,-2},{-46,-2},{-46,-2}}, fillColor = {255,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None),Rectangle(extent = {{-100,110},{100,-90}}, pattern = LinePattern.None, lineColor = {215,215,215})}));
      end Friction_lossyGearModelica;

      model Test_power_conservation
        LossModel.SensorSources.Real_to_mechRotational real_to_mechrotational1 annotation(Placement(visible = true, transformation(origin = {-76.4388,11.9784}, extent = {{-10.7554,-10.7554},{10.7554,10.7554}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorLeft annotation(Placement(visible = true, transformation(origin = {-37.9856,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        LossModel.FrictionModels.Friction_hysteresis_rotational friction_hysteresis_rotational1 annotation(Placement(visible = true, transformation(origin = {0.863309,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorRight annotation(Placement(visible = true, transformation(origin = {42.5899,12.0863}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        LossModel.SensorSources.mechRotational_to_Real mechrotational_to_real1 annotation(Placement(visible = true, transformation(origin = {82.3022,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Blocks.Sources.Sine Speed(amplitude = 50, freqHz = 0.3, startTime = 2) annotation(Placement(visible = true, transformation(origin = {-114.23,0.662125}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Blocks.Sources.Sine Torque(amplitude = 500, freqHz = 0.5, startTime = 2) annotation(Placement(visible = true, transformation(origin = {-113.129,41.4749}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        connect(Torque.y,real_to_mechrotational1.torque_input) annotation(Line(points={{
                -102.129,41.4749},{-88.6331,41.4749},{-88.6331,16.2806},{-86.1187,
                16.2806}}));
        connect(Speed.y,real_to_mechrotational1.phi_input) annotation(Line(points={{-103.23,
                0.662125},{-88.0576,0.662125},{-88.0576,7.67624},{-86.1187,
                7.67624}}));
        connect(powersensorRight.flange_b,mechrotational_to_real1.flange) annotation(Line(points={{52.5899,
                12.0863},{71.9424,12.0863},{71.9424,11.7986},{72.3022,11.7986}}));
        connect(friction_hysteresis_rotational1.flange_b,powersensorRight.flange_a) annotation(Line(points={{10.8633,
                11.7986},{32.518,11.7986},{32.518,12.0863},{32.5899,12.0863}}));
        connect(powersensorLeft.flange_b,friction_hysteresis_rotational1.flange_a) annotation(Line(points={{
                -27.9856,11.7986},{-8.92086,11.7986},{-8.92086,11.7986},{-9.13669,
                11.7986}}));
        connect(real_to_mechrotational1.flange,powersensorLeft.flange_a) annotation(Line(points={{
                -65.8985,11.9784},{-47.482,11.9784},{-47.482,11.7986},{-47.9856,
                11.7986}}));
        annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), experiment(StartTime = 0.0, StopTime = 15, Tolerance = 0.000001));
      end Test_power_conservation;

      model Test_power_conservation_inverse
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorLeft annotation(Placement(visible = true, transformation(origin = {-37.9856,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        FrictionModels.Friction_hysteresis_rotational           friction_hysteresis_rotational1 annotation(Placement(visible = true, transformation(origin = {0.863309,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorRight annotation(Placement(visible = true, transformation(origin = {42.5899,12.0863}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        LossModel.SensorSources.mechRotational_to_Real mechrotational_to_real1 annotation(Placement(visible = true, transformation(origin = {-79.7122,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 180)));
        LossModel.SensorSources.Real_to_mechRotational real_to_mechrotational1 annotation(Placement(visible = true, transformation(origin = {80.3957,12.2662}, extent = {{-10.7554,10.7554},{10.7554,-10.7554}}, rotation = 180)));
        Modelica.Blocks.Sources.Sine Torque(amplitude = 500, freqHz = 0.5, startTime = 2) annotation(Placement(visible = true, transformation(origin = {121.116,41.7627}, extent = {{-10,-10},{10,10}}, rotation = 180)));
        Modelica.Blocks.Sources.Sine Speed(amplitude = 50, freqHz = 0.3, startTime = 2) annotation(Placement(visible = true, transformation(origin = {122.029,5.55421}, extent = {{-10,-10},{10,10}}, rotation = 180)));
        Modelica.Blocks.Math.Division Rendement_direct
          annotation (Placement(transformation(extent={{56,-44},{76,-24}})));
        PasseSaufZero passeSaufZero(eps=1e-5)
          annotation (Placement(transformation(extent={{2,-50},{22,-30}})));
        Modelica.Blocks.Math.Division Rendement_inverse annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={-76,68})));
        PasseSaufZero passeSaufZero1(eps=1e-5) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-12,66})));
      equation
        connect(powersensorRight.flange_b,real_to_mechrotational1.flange) annotation(Line(points={{52.5899,
                12.0863},{69.3525,12.0863},{69.3525,12.2662},{69.8554,12.2662}}));
        connect(mechrotational_to_real1.flange,powersensorLeft.flange_a) annotation(Line(points={{
                -69.7122,11.7986},{-49.2086,11.7986},{-49.2086,11.7986},{-47.9856,
                11.7986}}));
        connect(Speed.y,real_to_mechrotational1.phi_input) annotation(Line(points={{111.029,
                5.55421},{92.0863,5.55421},{92.0863,7.96404},{90.0756,7.96404}}));
        connect(Torque.y,real_to_mechrotational1.torque_input) annotation(Line(points={{110.116,
                41.7627},{91.7986,41.7627},{91.7986,16.5684},{90.0756,16.5684}}));
        connect(friction_hysteresis_rotational1.flange_b,powersensorRight.flange_a) annotation(Line(points={{10.8633,
                11.7986},{32.518,11.7986},{32.518,12.0863},{32.5899,12.0863}}));
        connect(powersensorLeft.flange_b,friction_hysteresis_rotational1.flange_a) annotation(Line(points={{
                -27.9856,11.7986},{-9.13669,11.7986}}));
        connect(Rendement_direct.u1, powersensorRight.power) annotation (Line(
            points={{54,-28},{44,-28},{44,1.0863},{34.5899,1.0863}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(passeSaufZero.y, Rendement_direct.u2) annotation (Line(
            points={{23,-40},{54,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(passeSaufZero.u, powersensorLeft.power) annotation (Line(
            points={{0,-40},{-45.9856,-40},{-45.9856,0.7986}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(powersensorRight.power, passeSaufZero1.u) annotation (Line(
            points={{34.5899,1.0863},{24,1.0863},{24,66},{0,66}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(passeSaufZero1.y, Rendement_inverse.u2) annotation (Line(
            points={{-23,66},{-42,66},{-42,62},{-64,62}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(powersensorLeft.power, Rendement_inverse.u1) annotation (Line(
            points={{-45.9856,0.7986},{-45.9856,74},{-64,74}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent={{-100,
                  -100},{100,100}},                                                                                                    preserveAspectRatio=false,  initialScale = 0.1, grid = {2,2}),
              graphics={Text(
                extent={{-22,34},{-2,28}},
                lineColor={0,0,255},
                textString="Si P>0 , flux de puissance -->
et rendement 0.9 (rendement direct)
"),   Text(     extent={{-12,-10},{8,-16}},
                lineColor={0,0,255},
                textString="Si P<0 , flux de puissance <--
et rendement 0.8 dans ce sens (rendement inverse)
")}),                                                                                                    experiment(StartTime = 0.0, StopTime = 15.0, Tolerance = 0.000001));
      end Test_power_conservation_inverse;

      model Test_power_conservation_tanh
        LossModel.SensorSources.Real_to_mechRotational real_to_mechrotational1 annotation(Placement(visible = true, transformation(origin = {-76.4388,11.9784}, extent = {{-10.7554,-10.7554},{10.7554,10.7554}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorLeft annotation(Placement(visible = true, transformation(origin = {-37.9856,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        FrictionModels.Friction_tanh_rotational                 friction_hysteresis_rotational1 annotation(Placement(visible = true, transformation(origin = {0.863309,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorRight annotation(Placement(visible = true, transformation(origin = {42.5899,12.0863}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        LossModel.SensorSources.mechRotational_to_Real mechrotational_to_real1 annotation(Placement(visible = true, transformation(origin = {82.3022,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Blocks.Sources.Sine Speed(amplitude = 50, freqHz = 0.3, startTime = 2) annotation(Placement(visible = true, transformation(origin = {-114.23,0.662125}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Blocks.Sources.Sine Torque(amplitude = 500, freqHz = 0.5, startTime = 2) annotation(Placement(visible = true, transformation(origin = {-113.129,41.4749}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        connect(Torque.y,real_to_mechrotational1.torque_input) annotation(Line(points={{
                -102.129,41.4749},{-88.6331,41.4749},{-88.6331,16.2806},{-86.1187,
                16.2806}}));
        connect(Speed.y,real_to_mechrotational1.phi_input) annotation(Line(points={{-103.23,
                0.662125},{-88.0576,0.662125},{-88.0576,7.67624},{-86.1187,
                7.67624}}));
        connect(powersensorRight.flange_b,mechrotational_to_real1.flange) annotation(Line(points={{52.5899,
                12.0863},{71.9424,12.0863},{71.9424,11.7986},{72.3022,11.7986}}));
        connect(friction_hysteresis_rotational1.flange_b,powersensorRight.flange_a) annotation(Line(points={{10.8633,
                11.7986},{32.518,11.7986},{32.518,12.0863},{32.5899,12.0863}}));
        connect(powersensorLeft.flange_b,friction_hysteresis_rotational1.flange_a) annotation(Line(points={{
                -27.9856,11.7986},{-9.13669,11.7986},{-9.13669,11.7986}}));
        connect(real_to_mechrotational1.flange,powersensorLeft.flange_a) annotation(Line(points={{
                -65.8985,11.9784},{-47.482,11.9784},{-47.482,11.7986},{-47.9856,
                11.7986}}));
        annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), experiment(StartTime = 0.0, StopTime = 15, Tolerance = 0.000001));
      end Test_power_conservation_tanh;

      model Test_power_conservation_inverse_tanh
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorLeft annotation(Placement(visible = true, transformation(origin = {-37.9856,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        FrictionModels.Friction_tanh_rotational                 friction_hysteresis_rotational1(
            eta_d_input=0.9, eta_i_input=0.8)                                                   annotation(Placement(visible = true, transformation(origin = {0.863309,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powersensorRight annotation(Placement(visible = true, transformation(origin = {42.5899,12.0863}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        LossModel.SensorSources.mechRotational_to_Real mechrotational_to_real1 annotation(Placement(visible = true, transformation(origin = {-79.7122,11.7986}, extent = {{-10,-10},{10,10}}, rotation = 180)));
        LossModel.SensorSources.Real_to_mechRotational real_to_mechrotational1 annotation(Placement(visible = true, transformation(origin = {80.3957,12.2662}, extent = {{-10.7554,10.7554},{10.7554,-10.7554}}, rotation = 180)));
        Modelica.Blocks.Sources.Sine Torque(amplitude = 500, freqHz = 0.5, startTime = 2) annotation(Placement(visible = true, transformation(origin = {121.116,41.7627}, extent = {{-10,-10},{10,10}}, rotation = 180)));
        Modelica.Blocks.Sources.Sine Speed(amplitude = 50, freqHz = 0.3, startTime = 2) annotation(Placement(visible = true, transformation(origin = {122.029,5.55421}, extent = {{-10,-10},{10,10}}, rotation = 180)));
      equation
        connect(powersensorRight.flange_b,real_to_mechrotational1.flange) annotation(Line(points={{52.5899,
                12.0863},{69.3525,12.0863},{69.3525,12.2662},{69.8554,12.2662}}));
        connect(mechrotational_to_real1.flange,powersensorLeft.flange_a) annotation(Line(points={{
                -69.7122,11.7986},{-49.2086,11.7986},{-49.2086,11.7986},{-47.9856,
                11.7986}}));
        connect(Speed.y,real_to_mechrotational1.phi_input) annotation(Line(points={{111.029,
                5.55421},{92.0863,5.55421},{92.0863,7.96404},{90.0756,7.96404}}));
        connect(Torque.y,real_to_mechrotational1.torque_input) annotation(Line(points={{110.116,
                41.7627},{91.7986,41.7627},{91.7986,16.5684},{90.0756,16.5684}}));
        connect(friction_hysteresis_rotational1.flange_b,powersensorRight.flange_a) annotation(Line(points={{10.8633,
                11.7986},{32.518,11.7986},{32.518,12.0863},{32.5899,12.0863}}));
        connect(powersensorLeft.flange_b,friction_hysteresis_rotational1.flange_a) annotation(Line(points={{
                -27.9856,11.7986},{-9.13669,11.7986}}));
        annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), experiment(StartTime = 0.0, StopTime = 15.0, Tolerance = 0.000001));
      end Test_power_conservation_inverse_tanh;
      annotation(Icon(graphics={  Rectangle(extent = {{-100,100},{100,-100}}, fillColor = {255,255,255},
                fillPattern =                                                                                          FillPattern.Solid, lineColor = {215,215,215}),Rectangle(extent = {{0,92},{86,6}}, lineColor = {0,127,0}, fillColor = {170,255,85},
                fillPattern =                                                                                                   FillPattern.Solid),Ellipse(extent = {{-80,60},{28,-40}}, lineColor = {147,0,0}, fillColor = {255,0,0},
                fillPattern =                                                                                                   FillPattern.Solid),Polygon(points = {{-26,6},{-70,-90},{90,-90},{-26,6}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {0,128,255},
                fillPattern =                                                                                                   FillPattern.Solid)}));
    end FrictionTest;

    package SensorSources "Mechanical sensor source components"
      model Real_to_mechTranslational
        "Creation of translational force acting on a drive train element from input signals [Real]"
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        import SI = Modelica.SIunits;
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
          "1D translation"                                                             annotation(Placement(transformation(extent = {{90,-10},{110,10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput f
          "driving force as input signal [Real]"                                      annotation(Placement(transformation(extent = {{-110,39},{-70,79}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput x
          "position as input signal [Real]"                                      annotation(Placement(transformation(extent = {{-110,-89},{-70,-49}}, rotation = 0)));
        // initial equation
        //   x=0;
      equation
        //Position signal
        flange_b.s = x;
        //Force signal
        0 = flange_b.f + f;
        annotation(Window(x = 0.05, y = 0.01, width = 0.69, height = 0.83), Documentation(info = "<html>
<p>
The input signal (represented by a real number for the force and another real number for the position)  characterizes an <i>external
force</i> which acts (with positive sign) at a flange,
i.e., the component connected to the flange is driven by force f and translated by x.
</p>
<p>
 According to modelica <b>sign conventions</b>,
 <pre>
   f_output[N] = - f_input[Real]
   x_output[m] = x_input[Real]
 </pre>
</p>
<p><u>Examples:</u><br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Translational_Test_1\">Real_Translational_Test_1</a> <br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Translational_Test_2\">Real_Translational_Test_2</a>
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Torque1D)</i> </li>
</ul>
</html>"),   Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Polygon(points = {{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},{-100,10}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {255,0,0}),Text(extent = {{-72,81},{-12,41}}, textString = "f"),Text(extent = {{-74,-46},{-14,-85}}, textString = "x"),Line(points = {{-100,-1},{37,-1},{37,10},{57,0},{37,-10},{37,-1}}, color = {0,0,0}, thickness = 0.5),Line(points = {{-30,20},{-30,-20}}, color = {0,0,0}, thickness = 0.5),Polygon(points = {{37,-10},{37,10},{57,0},{37,-10}}, lineColor = {0,0,0}, lineThickness = 0.5, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0,0,0}),Text(extent = {{-64,124},{129,72}}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Polygon(points = {{50,-90},{20,-80},{20,-100},{50,-90}}, lineColor = {128,128,128}, fillColor = {128,128,128}, fillPattern = FillPattern.Solid),Line(points = {{-60,-90},{20,-90}}, color = {0,0,0}),Polygon(points = {{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},{-100,10}}, lineColor = {0,127,0}, fillColor = {0,127,0}, fillPattern = FillPattern.Solid)}));
      end Real_to_mechTranslational;

      model mechTranslational_to_Real
        "1D translational sensor for inverse simulation"
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        extends Modelica.Icons.TranslationalSensor;
        import SI = Modelica.SIunits;
        // Output
        Modelica.Blocks.Interfaces.RealOutput outPort_f "Force [Real]" annotation(Placement(transformation(extent = {{80,50},{100,70}}, rotation = 0), iconTransformation(extent = {{80,50},{100,70}})));
        Modelica.Blocks.Interfaces.RealOutput outPort_x "Position [Real]" annotation(Placement(transformation(extent = {{80,-10},{100,10}}, rotation = 0), iconTransformation(extent = {{80,-10},{100,10}})));
        Modelica.Blocks.Interfaces.RealOutput outPort_v "Speed [Real]" annotation(Placement(transformation(extent = {{80,-70},{100,-50}}, rotation = 0), iconTransformation(extent = {{80,-70},{100,-50}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
          "1D Translation"                                                             annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}, rotation = 0), iconTransformation(extent = {{-110,-10},{-90,10}})));
      equation
        outPort_x = flange_a.s;
        outPort_v = der(flange_a.s);
        outPort_f = -flange_a.f;
        connect(outPort_x,outPort_x) annotation(Line(points = {{90,0},{85,0},{85,0},{90,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Documentation(info = "<html>
<p>
This sensor is used for <b>inverse simulation</b>.
</p>
<p>
 This block must be placed instead of the 1D translational source that needs to be power sized.
 The outputs represent the <b>Force</b>, <b>Position</b> and <b>Speed</b> to be applied to the source component in order to generate the wanted profile.
</p>
<p>
 According to modelica <b>sign conventions</b>,
 <pre>
   f_output[Real] = - f_input[N]
   x_output[Real] = x_input[m]
 </pre>
</p>
<p><u>Examples:</u><br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Translational_Test_1\">Real_Translational_Test_1</a> <br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Translational_Test_2\">Real_Translational_Test_2</a>
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version by Jonathan Liscouet and Marc Budinger</i> </li>
</ul>
</html>"),   Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Rectangle(extent = {{-70,70},{80,-70}}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,127,0}),Rectangle(extent = {{-102,10},{-62,-10}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {175,175,175}),Text(extent = {{40,72},{94,46}}, lineColor = {0,0,0}, textString = "F"),Text(extent = {{34,12},{84,-10}}, lineColor = {0,0,0}, textString = "pos"),Text(extent = {{14,-50},{88,-70}}, lineColor = {0,0,0}, textString = "Speed", fillColor = {0,127,0}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-65,39},{15,-41}}, lineColor = {0,127,0}, fillPattern = FillPattern.Solid, fillColor = {255,255,255}),Line(points = {{-60,6},{-54,4}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-56,14},{-51,11}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-50,23},{-46,19}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-41,29},{-38,24}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-32,32},{-31,27}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-25,33},{-25,28}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-18,32},{-19,27}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-10,29},{-13,25}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-6,19},{-2,23}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{0,11},{5,15}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{5,4},{10,6}}, color = {0,127,0}, smooth = Smooth.None),Polygon(points = {{-16,23},{-31,-5},{-22,-9},{-16,23}}, lineColor = {0,127,0}, smooth = Smooth.None, fillPattern = FillPattern.Solid, fillColor = {0,127,0}),Ellipse(extent = {{-32,2},{-19,-11}}, lineColor = {0,127,0}, fillPattern = FillPattern.Solid, fillColor = {0,127,0}),Ellipse(extent = {{-29,-1},{-22,-8}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-54,134},{139,82}}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics));
      end mechTranslational_to_Real;

      model Real_to_mechRotational
        "Creation of rotational force acting on a drive train element from input torque and angular position signals [Real]"
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        //    Inputs
        Modelica.Blocks.Interfaces.RealInput torque_input
          "Torque input signal [Real]"                                                 annotation(Placement(transformation(extent = {{-120,60},{-80,100}}, rotation = 0), iconTransformation(extent = {{-100,30},{-80,50}})));
        Modelica.Blocks.Interfaces.RealInput phi_input
          "Angular position input signal [Real]"                                              annotation(Placement(transformation(extent = {{-120,20},{-80,60}}, rotation = 0), iconTransformation(extent = {{-100,-50},{-80,-30}})));
        //     Outputs
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange "1D rotation" annotation(Placement(transformation(extent = {{90,-10},{110,10}}, rotation = 0), iconTransformation(extent = {{88,-10},{108,10}})));
      equation
        // Torque Signal
        flange.tau = -torque_input;
        // Angular Position Signal
        flange.phi = phi_input;
        annotation(Documentation(info = "<html>
<p>
The input signal (represented by a real number for the torque and another real number for the angular position)  characterizes an <i>external
force</i> which acts at a flange,
i.e., the component connected to the flange is driven by the torque with given angular position.
</p>
<p>
According to modelica <b>sign conventions</b>,
 <pre>
   tau_output[N.m] = - tau_input[Real]
   phi_output[rad] = phi_input[Real]
 </pre>
</p>
<p><u>Examples:</u><br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Rotational_Test_1\">Real_Rotational_Test_1</a> <br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Rotational_Test_2\">Real_Rotational_Test_2</a>
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version by Jonathan Liscouet and Marc Budinger</i> </li>
</ul>
</html>"),   Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={  Rectangle(extent = {{-80,80},{80,-80}}, pattern = LinePattern.None, lineColor = {255,255,255}, fillColor = {255,255,255},
                  fillPattern =                                                                                                   FillPattern.Solid),Ellipse(extent = {{-12,10},{-32,-10}}, lineColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {156,156,156}),Polygon(points = {{48,20},{63,10},{63,27},{48,20}}, lineColor = {255,0,0},
                  lineThickness =                                                                                                   0.5, fillColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Text(extent = {{-76,60},{-16,20}}, textString = "tau"),Text(extent = {{-76,-20},{-16,-60}}, textString = "phi"),Rectangle(extent = {{-22,10},{98,-10}}, lineColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Text(extent = {{-98,-100},{100,-130}}, textString = "%name"),Line(points = {{-34,6},{-36,6},{-64,6},{-76,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,-6},{-36,-6},{-64,-6},{-76,-40}}, color = {0,0,0}, smooth = Smooth.None),Ellipse(extent = {{-12,39},{64,-38}}, lineColor = {255,0,0},
                  lineThickness =                                                                                                   0.5),Ellipse(extent = {{-12,39},{64,-38}}, lineColor = {0,0,0}),Polygon(points = {{48,20},{63,10},{63,27},{48,20}}, lineColor = {0,0,0}, fillColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Line(points = {{26,42},{26,36}}, color = {0,0,0}),Rectangle(extent = {{58,10},{80,-10}}, lineColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Line(points = {{14,14},{38,14}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{14,-14},{38,-14}}, color = {0,0,0}, smooth = Smooth.None)}), Diagram(graphics));
      end Real_to_mechRotational;

      model Real_to_mechRot_tw
        "Creation of rotational force acting on a drive train element from input torque and angular speed signals [Real]"
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        // Internal variables
        Modelica.SIunits.Angle phi "absolute rotation angle of flange flange_b";
        Modelica.SIunits.AngularVelocity w
          "absolute angular velocity of flange flange_b";
        Modelica.SIunits.AngularAcceleration a
          "absolute angular acceleration of flange flange_b";
        // Inputs
        Modelica.Blocks.Interfaces.RealInput inPort_tau "Torque input signal" annotation(Placement(transformation(extent = {{-100,20},{-60,60}}, rotation = 0), iconTransformation(extent = {{-100,30},{-80,50}})));
        Modelica.Blocks.Interfaces.RealInput inPort_speed
          "Angular position input signal"                                                 annotation(Placement(transformation(extent = {{-120,-86},{-80,-46}}, rotation = 0), iconTransformation(extent = {{-100,-50},{-80,-30}})));
        // Outputs
        output Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_b
          "(Right) flange"                                                                 annotation(Placement(transformation(extent = {{88,-12},{108,8}}, rotation = 0), iconTransformation(extent = {{88,-12},{108,8}})));
      protected
        Modelica.Blocks.Interfaces.RealInput inPort_speed1
          "Angular position input signal"                                                  annotation(Placement(transformation(extent = {{-94,-60},{-90,-56}})));
      initial equation
        phi = 0;
      equation
        // Torque Signal
        flange_b.tau = -inPort_tau;
        // Speed Signal
        flange_b.phi = phi;
        w = der(phi);
        a = der(w);
        w = inPort_speed;
        connect(inPort_speed,inPort_speed1) annotation(Line(points = {{-100,-66},{-98,-66},{-98,-54},{-92,-54},{-92,-58}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Documentation(info = "<html>
<p>
The input signal (represented by a real number for the torque and another real number for the angular position)  characterizes an <i>external
force</i> which acts at a flange,
i.e., the component connected to the flange is driven by the torque with given angular position.
</p>
<p>
According to modelica <b>sign conventions</b>,
 <pre>
   tau_output[N.m] = - tau_input[Real]
   phi_output[rad] = phi_input[Real]
 </pre>
</p>
<p><u>Examples:</u><br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Rot_tw_Test_1\">Real_Rot_tw_Test_1</a> <br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Rot_tw_Test_2\">Real_Rot_tw_Test_2</a>
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version by Jonathan Liscouet and Marc Budinger</i> </li>
</ul>
</html>"),   Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-80,80},{-20,-80}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-10,37},{66,-40}}, lineColor = {255,0,0}, lineThickness = 0.5),Polygon(points = {{50,18},{65,8},{65,25},{50,18}}, lineColor = {255,0,0}, lineThickness = 0.5, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-80,62},{-20,22}}, textString = "tau"),Text(extent = {{-80,-19},{-20,-58}}, textString = "w"),Rectangle(extent = {{-20,8},{100,-12}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Text(extent = {{-156,136},{166,102}}, textString = "%name"),Ellipse(extent = {{-10,37},{66,-40}}, lineColor = {0,0,0}),Polygon(points = {{50,18},{65,8},{65,25},{50,18}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Rectangle(extent = {{60,8},{82,-12}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Line(points = {{28,48},{28,26}}, color = {0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Real_to_mechRot_tw;

      model mechRotational_to_Real
        "1D rotational sensor for inverse simulation"
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        extends Modelica.Icons.RotationalSensor;
        import SI = Modelica.SIunits;
        //    Outputs
        Modelica.Blocks.Interfaces.RealOutput outPort_tau
          "Inverse torque [Real]"                                                 annotation(Placement(transformation(extent = {{80,50},{100,70}}, rotation = 0), iconTransformation(extent = {{80,50},{100,70}})));
        Modelica.Blocks.Interfaces.RealOutput outPort_w "Speed [Real]" annotation(Placement(transformation(extent = {{78,-70},{98,-50}}, rotation = 0), iconTransformation(extent = {{80,-70},{100,-50}})));
        Modelica.Blocks.Interfaces.RealOutput outPort_phi
          "Absolute Angle [Real]"                                                 annotation(Placement(transformation(extent = {{80,-10},{100,10}}, rotation = 0), iconTransformation(extent = {{80,-10},{100,10}})));
        //   Inputs
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
          "1D rotational"                                                        annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}, rotation = 0)));
      equation
        outPort_phi = flange.phi;
        outPort_w = der(flange.phi);
        outPort_tau = -flange.tau;
        annotation(Documentation(info = "<html>
<p>
This sensor is used for <b>inverse simulation</b>.
</p>
<p>
 This block must be placed instead of the 1D rotational source that needs to be power sized.
 The outputs represent the <b>Torque</b>, <b>Angular position</b> and <b>Angular speed</b> to be applied to the source component in order to generate the wanted profile.
</p>
<p>
 According to modelica <b>sign conventions</b>,
 <pre>
   tau_output[Real] = - tau_input[N.m]
   phi_output[Real] = phi_input[rad]
 </pre>
</p>
<p><u>Examples:</u><br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Rotational_Test_1\">Real_Rotational_Test_1</a> <br>
<a href=\"modelica://ICA_PreliminaryDesign_Actuation2015.Examples.ComponentTests.Mechanical.SensorSources.Real_Rotational_Test_2\">Real_Rotational_Test_2</a>
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version by Jonathan Liscouet and Marc Budinger</i> </li>
</ul>
</html>"),   Icon(graphics={  Rectangle(extent = {{-100,10},{-70,-10}}, lineColor = {0,127,0},
                  fillPattern =                                                                              FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-70,-60},{70,20}}, lineColor = {0,127,0}, fillColor = {255,255,255},
                  fillPattern =                                                                                                   FillPattern.Solid),Line(points = {{-70,0},{0,0}}, color = {0,127,0}),Line(points = {{-50,-40},{-50,-60}}, color = {0,127,0}),Line(points = {{-30,-40},{-30,-60}}, color = {0,127,0}),Rectangle(extent = {{-70,70},{80,-70}}, fillColor = {255,255,255},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,127,0}),Rectangle(extent = {{-102,10},{-62,-10}}, lineColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.HorizontalCylinder, fillColor = {175,175,175}),Ellipse(extent = {{-65,39},{15,-41}}, lineColor = {0,127,0},
                  fillPattern =                                                                                                   FillPattern.Solid, fillColor = {255,255,255}),Line(points = {{-60,6},{-54,4}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-56,14},{-51,11}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-50,23},{-46,19}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-41,29},{-38,24}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-32,32},{-31,27}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-25,33},{-25,28}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-18,32},{-19,27}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-10,29},{-13,25}}, color = {0,127,0}, smooth = Smooth.None),Polygon(points = {{-16,23},{-31,-5},{-22,-9},{-16,23}}, lineColor = {0,127,0}, smooth = Smooth.None,
                  fillPattern =                                                                                                   FillPattern.Solid, fillColor = {0,127,0}),Ellipse(extent = {{-32,2},{-19,-11}}, lineColor = {0,127,0},
                  fillPattern =                                                                                                   FillPattern.Solid, fillColor = {95,95,95}),Ellipse(extent = {{-29,-1},{-22,-8}}, lineColor = {0,0,0}, fillColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Text(extent = {{30,72},{90,50}}, lineColor = {0,0,0}, textString = "tau"),Text(extent = {{32,12},{88,-12}}, lineColor = {0,0,0}, textString = "phi"),Text(extent = {{36,-46},{92,-70}}, lineColor = {0,0,0}, textString = "w"),Line(points = {{-8,21},{-4,25}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{-2,13},{3,17}}, color = {0,127,0}, smooth = Smooth.None),Line(points = {{3,6},{8,8}}, color = {0,127,0}, smooth = Smooth.None),Text(extent = {{-54,134},{139,82}}, textString = "%name")}), Diagram(graphics));
      end mechRotational_to_Real;

      model Thermal_to_Real
        "Sensor to measure thermal flux for inverse simulation"
        extends Modelica.Icons.RotationalSensor;
        //extends ICA_PreliminaryDesign_Actuation2015.Status_Badges.Operational;
        import SI = Modelica.SIunits;
        parameter SI.Temperature Tamb = SI.Conversions.from_degC(20)
          "Ambiant temperature";
        parameter SI.Energy W0 = 0 "Initial thermal energy";
        // Input
        input Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_a
          "measured flange [Thermal flux]"                                                                annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}, rotation = 0)));
        // Output
        Modelica.Blocks.Interfaces.RealOutput outPort_Q_flow
          "Thermal flow [Real]"                                                    annotation(Placement(transformation(extent = {{80,30},{100,50}}, rotation = 0), iconTransformation(extent = {{80,30},{100,50}})));
        Modelica.Blocks.Interfaces.RealOutput outPort_W "Thermal energy [Real]" annotation(Placement(transformation(extent = {{80,-50},{100,-30}}, rotation = 0), iconTransformation(extent = {{80,-50},{100,-30}})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor annotation(Placement(transformation(origin = {-80,-24}, extent = {{-10,-10},{10,10}}, rotation = 270)));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = Tamb) annotation(Placement(transformation(origin = {-80,-64}, extent = {{-10,-10},{10,10}}, rotation = 90)));
      initial equation
        outPort_W = 0;
      equation
        der(outPort_W) = heatFlowSensor.Q_flow;
        outPort_Q_flow = heatFlowSensor.Q_flow;
        connect(port_a,heatFlowSensor.port_a) annotation(Line(points = {{-100,0},{-80,0},{-80,-14}}, color = {191,0,0}));
        connect(heatFlowSensor.port_b,fixedTemperature.port) annotation(Line(points = {{-80,-34},{-80,-54}}, color = {191,0,0}));
        annotation(Documentation(info = "<html>
<p>
This sensor is used for <b>inverse simulation</b>.
</p>
<p>
 This block must be placed where a heat flow needs to be measured.
 The outputs represent the <b>Thermal Flow</b> and <b>Thermal Energy</b> generated by the component.
</p>
</HTML>
<html><p><b>revisions</b></p></html><html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>R3ASC case in June 12, 2012 by Marc Budinger, Aurelien Reysset, Thomas Ros</i> </li>
<li><i>Verified on May 16, 2012 by Thomas Ros</i> </li>
<li><i>First Version by Jonathan Liscouet and Marc Budinger</i> </li>
</ul>
</html>"),   Icon(graphics={  Text(extent = {{-162,138},{168,102}}, lineColor = {0,0,0}, textString = "%name"),Line(points = {{-90,0},{-70,0}}, color = {0,0,0}),Ellipse(extent = {{-70,70},{70,-70}}, lineColor = {0,0,0}, fillColor = {255,255,255},
                  fillPattern =                                                                                                   FillPattern.Solid),Line(points = {{0,70},{0,40}}, color = {0,0,0}),Line(points = {{22.9,32.8},{40.2,57.3}}, color = {0,0,0}),Line(points = {{-22.9,32.8},{-40.2,57.3}}, color = {0,0,0}),Line(points = {{-37.6,13.7},{-65.8,23.9}}, color = {0,0,0}),Line(points = {{0,0},{9.02,28.6}}, color = {0,0,0}),Polygon(points = {{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}}, lineColor = {0,0,0}, fillColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Ellipse(extent = {{-5,5},{5,-5}}, lineColor = {0,0,0}, fillColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Rectangle(extent = {{-70,-60},{70,20}}, lineColor = {0,0,0}, fillColor = {255,255,255},
                  fillPattern =                                                                                                   FillPattern.Solid),Polygon(points = {{0,-40},{-10,-16},{10,-16},{0,-40}}, lineColor = {0,0,0}, fillColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Line(points = {{0,0},{0,-16}}, color = {0,0,0}),Line(points = {{-70,0},{0,0}}, color = {0,0,0}),Line(points = {{-50,-40},{-50,-60}}, color = {0,0,0}),Line(points = {{-30,-40},{-30,-60}}, color = {0,0,0}),Line(points = {{-10,-40},{-10,-60}}, color = {0,0,0}),Line(points = {{10,-40},{10,-60}}, color = {0,0,0}),Rectangle(extent = {{-78,70},{80,-72}}, fillColor = {255,255,255},
                  fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None),Line(points = {{-60,6},{-54,4}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-56,14},{-51,11}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-50,23},{-46,19}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-41,29},{-38,24}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-32,32},{-31,27}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-25,33},{-25,28}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-18,32},{-19,27}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-10,29},{-13,25}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{-6,19},{-2,23}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{0,11},{5,15}}, color = {127,0,0}, smooth = Smooth.None),Line(points = {{5,4},{10,6}}, color = {127,0,0}, smooth = Smooth.None),Polygon(points = {{-16,23},{-31,-5},{-22,-9},{-16,23}}, lineColor = {127,0,0}, smooth = Smooth.None,
                  fillPattern =                                                                                                   FillPattern.Solid, fillColor = {127,0,0}),Ellipse(extent = {{-32,2},{-19,-11}}, lineColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid, fillColor = {127,0,0}),Ellipse(extent = {{-29,-1},{-22,-8}}, lineColor = {0,0,0}, fillColor = {0,0,0},
                  fillPattern =                                                                                                   FillPattern.Solid),Text(extent = {{32,56},{88,20}}, lineColor = {0,0,0}, textString = "Q"),Text(extent = {{36,-24},{90,-58}}, lineColor = {0,0,0}, textString = "W"),Line(points = {{-66,0},{-90,0}}, color = {127,0,0}),Ellipse(extent = {{-65,39},{15,-41}}, lineColor = {127,0,0})}), Diagram(graphics));
      end Thermal_to_Real;
      annotation(Icon(graphics={  Rectangle(extent = {{-100,100},{100,-100}}, fillColor = {255,255,255},
                fillPattern =                                                                                          FillPattern.Solid, lineColor = {254,254,254}),Polygon(points = {{-72,70},{-32,70},{-12,50},{-32,30},{-72,30},{-72,70}}, smooth = Smooth.None, fillColor = {0,127,0},
                fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,0,0}),Polygon(points = {{72,70},{12,70},{32,50},{12,30},{72,30},{72,70}}, smooth = Smooth.None, fillColor = {0,0,0},
                fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,0,0}),Polygon(points = {{-20,20},{20,20},{40,0},{20,-20},{-20,-20},{-20,20}}, smooth = Smooth.None, origin = {54,-50}, rotation = 180, fillColor = {0,127,0},
                fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,0,0}),Polygon(points = {{16,20},{-40,20},{-20,-0.000000000000000979716},{-40,-20},{16,-20},{16,20}}, smooth = Smooth.None, origin = {-56,-50}, rotation = 180,
                fillPattern =                                                                                                   FillPattern.Solid, fillColor = {0,0,0}, pattern = LinePattern.None, lineColor = {0,0,0})}));
    end SensorSources;

    model PasseSaufZero

    extends Modelica.Blocks.Interfaces.SISO;

    parameter Real eps=1e-8;

      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=eps, uHigh=-eps)
        annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
      Modelica.Blocks.Nonlinear.DeadZone deadZone(uMax=eps)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{64,-10},{84,10}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{14,-70},{34,-50}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=eps)
        annotation (Placement(transformation(extent={{-22,-48},{-2,-28}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=-eps)
        annotation (Placement(transformation(extent={{-22,-94},{-2,-74}})));
    equation
      connect(hysteresis.u, u) annotation (Line(
          points={{-42,-60},{-72,-60},{-72,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(u, deadZone.u) annotation (Line(
          points={{-120,0},{-42,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(deadZone.y, add.u1) annotation (Line(
          points={{-19,0},{0,0},{0,6},{62,6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(hysteresis.y, switch1.u2) annotation (Line(
          points={{-19,-60},{12,-60}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(realExpression.y, switch1.u1) annotation (Line(
          points={{-1,-38},{2,-38},{2,-52},{12,-52}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realExpression1.y, switch1.u3) annotation (Line(
          points={{-1,-84},{2,-84},{2,-68},{12,-68}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y, y) annotation (Line(
          points={{85,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(switch1.y, add.u2) annotation (Line(
          points={{35,-60},{46,-60},{46,-6},{62,-6}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end PasseSaufZero;

    model TestPasseTout
      PasseSaufZero passeSaufZero(eps=1e-1)
        annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
      Modelica.Blocks.Sources.Sine Torque(
        amplitude=1,
        freqHz=1,
        startTime=0)                                                                    annotation(Placement(visible = true, transformation(origin={-51.129,
                -0.5251},                                                                                                    extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(Torque.y, passeSaufZero.u) annotation (Line(
          points={{-40.129,-0.5251},{-16,0},{-20,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics));
    end TestPasseTout;
    annotation ();
  end LossModel;

  model Transient_Resonance
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{-14,-46},{6,-26}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(                    w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={52,-36})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-114,-46},{-94,-26}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-96,-60})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan(J=3000)
      annotation (Placement(transformation(extent={{12,-46},{32,-26}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor(J=1.72)
      annotation (Placement(transformation(extent={{-76,-46},{-56,-26}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper
                                                    spring(c=866, d=866/100/
          sqrt(886/1.7))
      annotation (Placement(transformation(extent={{-48,-46},{-28,-26}})));
    Modelica.Blocks.Tables.CombiTable1D TorqueSpeed(table=[0,454; 80,579; 160,
          784; 220,997; 240,1057; 250,1071; 260,1060; 280,919; 300,500; 314,0],
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
      annotation (Placement(transformation(extent={{-148,-46},{-128,-26}})));
  equation
    connect(speedSensor.flange, torque.flange) annotation (Line(
        points={{-96,-50},{-96,-44},{-94,-44},{-94,-36}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear.flange_b, inertia_fan.flange_a) annotation (Line(
        points={{6,-36},{12,-36}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan.flange_b, quadraticSpeedDependentTorque.flange)
      annotation (Line(
        points={{32,-36},{42,-36}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, inertia_motor.flange_a) annotation (Line(
        points={{-94,-36},{-76,-36}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_motor.flange_b, spring.flange_a) annotation (Line(
        points={{-56,-36},{-48,-36}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring.flange_b, lossyGear.flange_a) annotation (Line(
        points={{-28,-36},{-14,-36}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(TorqueSpeed.y[1], torque.tau) annotation (Line(
        points={{-127,-36},{-116,-36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.w, TorqueSpeed.u[1]) annotation (Line(
        points={{-96,-71},{-96,-80},{-164,-80},{-164,-36},{-150,-36}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,
              -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={
              {-180,-100},{100,100}})));
  end Transient_Resonance;

  model Transient_SpeedControler
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{36,42},{56,62}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(                    w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={102,52})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-58,42},{-38,62}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan(J=3000)
      annotation (Placement(transformation(extent={{62,42},{82,62}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor(J=1.72)
      annotation (Placement(transformation(extent={{-34,42},{-14,62}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper
                                                    spring(c=866, d=866/100/
          sqrt(886/1.7))
      annotation (Placement(transformation(extent={{2,42},{22,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=2*3.14*800, D=1)
      annotation (Placement(transformation(extent={{-94,42},{-74,62}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-8,30})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 10,300; 20,300])
      annotation (Placement(transformation(extent={{-206,42},{-186,62}})));
    Modelica.Blocks.Continuous.PI PI(T=0.1, k=10000)
      annotation (Placement(transformation(extent={{-126,42},{-106,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder1(D=1, w=2*3.14*0.5)
      annotation (Placement(transformation(extent={{-178,42},{-158,62}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(
                                                                 ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{36,-50},{56,-30}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque1(                   w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={102,-40})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1
      annotation (Placement(transformation(extent={{-58,-50},{-38,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan1(
                                                                 J=3000)
      annotation (Placement(transformation(extent={{62,-50},{82,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor1(
                                                                   J=1.72)
      annotation (Placement(transformation(extent={{-32,-50},{-12,-30}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper
                                                    spring1(c=866, d=866/100/
          sqrt(886/1.7))
      annotation (Placement(transformation(extent={{2,-50},{22,-30}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-8,-62})));
    Modelica.Blocks.Sources.TimeTable timeTable1(table=[0,0; 10,300; 20,300])
      annotation (Placement(transformation(extent={{-206,-50},{-186,-30}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder3(D=1, w=2*3.14*0.5)
      annotation (Placement(transformation(extent={{-178,-50},{-158,-30}})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{-148,-50},{-128,-30}})));
    Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
      annotation (Placement(transformation(extent={{-112,-52},{-72,-28}})));
    Modelica.Blocks.Sources.RealExpression realExpression annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-90,-40})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-152,42},{-132,62}})));
  equation
    connect(lossyGear.flange_b, inertia_fan.flange_a) annotation (Line(
        points={{56,52},{62,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan.flange_b, quadraticSpeedDependentTorque.flange)
      annotation (Line(
        points={{82,52},{92,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, inertia_motor.flange_a) annotation (Line(
        points={{-38,52},{-34,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring.flange_b, lossyGear.flange_a) annotation (Line(
        points={{22,52},{36,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder.y, torque.tau) annotation (Line(
        points={{-73,52},{-60,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia_motor.flange_b, spring.flange_a) annotation (Line(
        points={{-14,52},{2,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speedSensor.flange, inertia_motor.flange_b) annotation (Line(
        points={{-8,40},{-8,52},{-14,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder.u, PI.y) annotation (Line(
        points={{-96,52},{-105,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timeTable.y, secondOrder1.u) annotation (Line(
        points={{-185,52},{-180,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lossyGear1.flange_b, inertia_fan1.flange_a)
                                                      annotation (Line(
        points={{56,-40},{62,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan1.flange_b, quadraticSpeedDependentTorque1.flange)
      annotation (Line(
        points={{82,-40},{92,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque1.flange, inertia_motor1.flange_a)
                                                   annotation (Line(
        points={{-38,-40},{-32,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring1.flange_b, lossyGear1.flange_a)
                                                 annotation (Line(
        points={{22,-40},{36,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_motor1.flange_b, spring1.flange_a) annotation (Line(
        points={{-12,-40},{2,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speedSensor1.flange, inertia_motor1.flange_b) annotation (Line(
        points={{-8,-52},{-8,-40},{-12,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(timeTable1.y, secondOrder3.u) annotation (Line(
        points={{-185,-40},{-180,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(secondOrder3.y, feedback.u1) annotation (Line(
        points={{-157,-40},{-146,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback.u2, speedSensor1.w) annotation (Line(
        points={{-138,-48},{-138,-86},{-8,-86},{-8,-73}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback.y, inverseBlockConstraints.u1) annotation (Line(
        points={{-129,-40},{-114,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseBlockConstraints.y1, torque1.tau) annotation (Line(
        points={{-71,-40},{-60,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, inverseBlockConstraints.u2) annotation (Line(
        points={{-101,-40},{-103.5,-40},{-103.5,-40},{-108,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.y, PI.u) annotation (Line(
        points={{-133,52},{-128,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u1, secondOrder1.y) annotation (Line(
        points={{-150,52},{-157,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u2, speedSensor.w) annotation (Line(
        points={{-142,44},{-142,2},{-8,2},{-8,19}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -120},{140,100}}),      graphics), Icon(coordinateSystem(extent={{-220,
              -120},{140,100}})));
  end Transient_SpeedControler;

  model Transient_SpeedControler2
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{36,42},{56,62}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(                    w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={102,52})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-58,42},{-38,62}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan(J=3000)
      annotation (Placement(transformation(extent={{62,42},{82,62}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor(J=1.72)
      annotation (Placement(transformation(extent={{-34,42},{-14,62}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper
                                                    spring(d=866/100/sqrt(886/
          1.7), c=866e3)
      annotation (Placement(transformation(extent={{2,42},{22,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=2*3.14*800, D=1)
      annotation (Placement(transformation(extent={{-94,42},{-74,62}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-8,30})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 10,300; 20,300])
      annotation (Placement(transformation(extent={{-206,42},{-186,62}})));
    Modelica.Blocks.Continuous.PI PI(T=0.1, k=10000)
      annotation (Placement(transformation(extent={{-126,42},{-106,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder1(D=1, w=2*3.14*0.5)
      annotation (Placement(transformation(extent={{-178,42},{-158,62}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(
                                                                 ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{36,-50},{56,-30}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque1(                   w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={102,-40})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1
      annotation (Placement(transformation(extent={{-58,-50},{-38,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan1(
                                                                 J=3000)
      annotation (Placement(transformation(extent={{62,-50},{82,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor1(
                                                                   J=1.72)
      annotation (Placement(transformation(extent={{-32,-50},{-12,-30}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper
                                                    spring1(d=866/100/sqrt(886/
          1.7), c=866e3)
      annotation (Placement(transformation(extent={{2,-50},{22,-30}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-8,-62})));
    Modelica.Blocks.Sources.TimeTable timeTable1(table=[0,0; 10,300; 20,300])
      annotation (Placement(transformation(extent={{-206,-50},{-186,-30}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder3(D=1, w=2*3.14*0.5)
      annotation (Placement(transformation(extent={{-178,-50},{-158,-30}})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{-148,-50},{-128,-30}})));
    Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
      annotation (Placement(transformation(extent={{-112,-52},{-72,-28}})));
    Modelica.Blocks.Sources.RealExpression realExpression annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-90,-40})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-152,42},{-132,62}})));
  equation
    connect(lossyGear.flange_b, inertia_fan.flange_a) annotation (Line(
        points={{56,52},{62,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan.flange_b, quadraticSpeedDependentTorque.flange)
      annotation (Line(
        points={{82,52},{92,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, inertia_motor.flange_a) annotation (Line(
        points={{-38,52},{-34,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring.flange_b, lossyGear.flange_a) annotation (Line(
        points={{22,52},{36,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder.y, torque.tau) annotation (Line(
        points={{-73,52},{-60,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia_motor.flange_b, spring.flange_a) annotation (Line(
        points={{-14,52},{2,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speedSensor.flange, inertia_motor.flange_b) annotation (Line(
        points={{-8,40},{-8,52},{-14,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder.u, PI.y) annotation (Line(
        points={{-96,52},{-105,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timeTable.y, secondOrder1.u) annotation (Line(
        points={{-185,52},{-180,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lossyGear1.flange_b, inertia_fan1.flange_a)
                                                      annotation (Line(
        points={{56,-40},{62,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan1.flange_b, quadraticSpeedDependentTorque1.flange)
      annotation (Line(
        points={{82,-40},{92,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque1.flange, inertia_motor1.flange_a)
                                                   annotation (Line(
        points={{-38,-40},{-32,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring1.flange_b, lossyGear1.flange_a)
                                                 annotation (Line(
        points={{22,-40},{36,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_motor1.flange_b, spring1.flange_a) annotation (Line(
        points={{-12,-40},{2,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speedSensor1.flange, inertia_motor1.flange_b) annotation (Line(
        points={{-8,-52},{-8,-40},{-12,-40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(timeTable1.y, secondOrder3.u) annotation (Line(
        points={{-185,-40},{-180,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(secondOrder3.y, feedback.u1) annotation (Line(
        points={{-157,-40},{-146,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback.u2, speedSensor1.w) annotation (Line(
        points={{-138,-48},{-138,-86},{-8,-86},{-8,-73}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback.y, inverseBlockConstraints.u1) annotation (Line(
        points={{-129,-40},{-114,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseBlockConstraints.y1, torque1.tau) annotation (Line(
        points={{-71,-40},{-60,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, inverseBlockConstraints.u2) annotation (Line(
        points={{-101,-40},{-103.5,-40},{-103.5,-40},{-108,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.y, PI.u) annotation (Line(
        points={{-133,52},{-128,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u1, secondOrder1.y) annotation (Line(
        points={{-150,52},{-157,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u2, speedSensor.w) annotation (Line(
        points={{-142,44},{-142,2},{-8,2},{-8,19}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -120},{140,100}}),      graphics), Icon(coordinateSystem(extent={{-220,
              -120},{140,100}})));
  end Transient_SpeedControler2;

  model Transient_SpeedControlerRigid
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{36,42},{56,62}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(                    w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={102,52})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-58,42},{-38,62}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan(J=3000)
      annotation (Placement(transformation(extent={{62,42},{82,62}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor(J=1.72)
      annotation (Placement(transformation(extent={{-34,42},{-14,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=2*3.14*800, D=1)
      annotation (Placement(transformation(extent={{-94,42},{-74,62}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-8,30})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 10,300; 20,300])
      annotation (Placement(transformation(extent={{-206,42},{-186,62}})));
    Modelica.Blocks.Continuous.PI PI(T=0.1, k=10000)
      annotation (Placement(transformation(extent={{-126,42},{-106,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder1(D=1, w=2*3.14*0.5)
      annotation (Placement(transformation(extent={{-178,42},{-158,62}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-152,42},{-132,62}})));
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(
                                                                 ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{36,-54},{56,-34}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque1(                   w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={102,-44})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1
      annotation (Placement(transformation(extent={{-58,-54},{-38,-34}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_fan1(
                                                                 J=3000)
      annotation (Placement(transformation(extent={{62,-54},{82,-34}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor1(
                                                                   J=1.72)
      annotation (Placement(transformation(extent={{-34,-54},{-14,-34}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper
                                                    spring(c=866, d=866/100/
          sqrt(886/1.7))
      annotation (Placement(transformation(extent={{2,-54},{22,-34}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder2(
                                                       w=2*3.14*800, D=1)
      annotation (Placement(transformation(extent={{-94,-54},{-74,-34}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1
                                                                  annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-8,-66})));
    Modelica.Blocks.Sources.TimeTable timeTable1(
                                                table=[0,0; 10,300; 20,300])
      annotation (Placement(transformation(extent={{-206,-54},{-186,-34}})));
    Modelica.Blocks.Continuous.PI PI1(
                                     T=0.1, k=10000)
      annotation (Placement(transformation(extent={{-126,-54},{-106,-34}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder3(D=1, w=2*3.14*0.5)
      annotation (Placement(transformation(extent={{-178,-54},{-158,-34}})));
    Modelica.Blocks.Math.Feedback feedback2
      annotation (Placement(transformation(extent={{-152,-54},{-132,-34}})));
  equation
    connect(lossyGear.flange_b, inertia_fan.flange_a) annotation (Line(
        points={{56,52},{62,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan.flange_b, quadraticSpeedDependentTorque.flange)
      annotation (Line(
        points={{82,52},{92,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, inertia_motor.flange_a) annotation (Line(
        points={{-38,52},{-34,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder.y, torque.tau) annotation (Line(
        points={{-73,52},{-60,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.flange, inertia_motor.flange_b) annotation (Line(
        points={{-8,40},{-8,52},{-14,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder.u, PI.y) annotation (Line(
        points={{-96,52},{-105,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timeTable.y, secondOrder1.u) annotation (Line(
        points={{-185,52},{-180,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.y, PI.u) annotation (Line(
        points={{-133,52},{-128,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u1, secondOrder1.y) annotation (Line(
        points={{-150,52},{-157,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u2, speedSensor.w) annotation (Line(
        points={{-142,44},{-142,2},{-8,2},{-8,19}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lossyGear.flange_a, inertia_motor.flange_b) annotation (Line(
        points={{36,52},{-14,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear1.flange_b, inertia_fan1.flange_a) annotation (Line(
        points={{56,-44},{62,-44}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_fan1.flange_b, quadraticSpeedDependentTorque1.flange)
      annotation (Line(
        points={{82,-44},{92,-44}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque1.flange, inertia_motor1.flange_a) annotation (Line(
        points={{-38,-44},{-34,-44}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(spring.flange_b, lossyGear1.flange_a) annotation (Line(
        points={{22,-44},{36,-44}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder2.y, torque1.tau) annotation (Line(
        points={{-73,-44},{-60,-44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia_motor1.flange_b, spring.flange_a) annotation (Line(
        points={{-14,-44},{2,-44}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speedSensor1.flange, inertia_motor1.flange_b) annotation (Line(
        points={{-8,-56},{-8,-44},{-14,-44}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(secondOrder2.u, PI1.y) annotation (Line(
        points={{-96,-44},{-105,-44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timeTable1.y, secondOrder3.u) annotation (Line(
        points={{-185,-44},{-180,-44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback2.y, PI1.u) annotation (Line(
        points={{-133,-44},{-128,-44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback2.u1,secondOrder3. y) annotation (Line(
        points={{-150,-44},{-157,-44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback2.u2, speedSensor1.w) annotation (Line(
        points={{-142,-52},{-142,-94},{-8,-94},{-8,-77}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -120},{140,100}}),      graphics), Icon(coordinateSystem(extent={{-220,
              -120},{140,100}})));
  end Transient_SpeedControlerRigid;

  model Activity_Index_controller
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear(ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{36,42},{56,62}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque(                    w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={102,52})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-62,42},{-42,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=2*3.14*800, D=1)
      annotation (Placement(transformation(extent={{-94,42},{-74,62}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-8,30})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 20,300; 30,300])
      annotation (Placement(transformation(extent={{-206,42},{-186,62}})));
    Modelica.Blocks.Continuous.PI PI(T=0.1, k=10000)
      annotation (Placement(transformation(extent={{-126,42},{-106,62}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder1(D=1, w=2*3.14*0.5)
      annotation (Placement(transformation(extent={{-178,42},{-158,62}})));
    Modelica.Blocks.Math.Feedback feedback1
      annotation (Placement(transformation(extent={{-152,42},{-132,62}})));
    ActivityIndex.Mechanics.Rotational.Components.Inertia_AI inertia_AI(J=1.72)
      annotation (Placement(transformation(extent={{-36,42},{-16,62}})));
    ActivityIndex.Mechanics.Rotational.Components.SpringDamper_AI
      springDamper_AI(c=866, d=866/100/sqrt(886/1.7))
      annotation (Placement(transformation(extent={{4,42},{24,62}})));
    ActivityIndex.ActivityIndex activityIndex(nu=3, fileName=
          "Ai_controleur.txt")
      annotation (Placement(transformation(extent={{84,6},{104,26}})));
    ActivityIndex.Mechanics.Rotational.Components.Inertia_AI inertia_AI1(J=3000)
      annotation (Placement(transformation(extent={{64,42},{84,62}})));
  equation
    connect(secondOrder.y, torque.tau) annotation (Line(
        points={{-73,52},{-64,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(secondOrder.u, PI.y) annotation (Line(
        points={{-96,52},{-105,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timeTable.y, secondOrder1.u) annotation (Line(
        points={{-185,52},{-180,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.y, PI.u) annotation (Line(
        points={{-133,52},{-128,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u1, secondOrder1.y) annotation (Line(
        points={{-150,52},{-157,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u2, speedSensor.w) annotation (Line(
        points={{-142,44},{-142,2},{-8,2},{-8,19}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque.flange, inertia_AI.flange_a) annotation (Line(
        points={{-42,52},{-36,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(springDamper_AI.flange_b, lossyGear.flange_a) annotation (Line(
        points={{24,52},{30,52},{30,52},{36,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(springDamper_AI.flange_a, inertia_AI.flange_b) annotation (Line(
        points={{4,52},{-16,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(speedSensor.flange, inertia_AI.flange_b) annotation (Line(
        points={{-8,40},{-8,52},{-16,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_AI1.flange_b, quadraticSpeedDependentTorque.flange)
      annotation (Line(
        points={{84,52},{92,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_AI1.flange_a, lossyGear.flange_b) annotation (Line(
        points={{64,52},{56,52}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(activityIndex.u[1], inertia_AI1.activity) annotation (Line(
        points={{85,14.1},{85,29.15},{74,29.15},{74,43}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(activityIndex.u[2], springDamper_AI.activity) annotation (Line(
        points={{85,16.3},{49.5,16.3},{49.5,43},{14,43}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(activityIndex.u[3], inertia_AI.activity) annotation (Line(
        points={{85,18.5},{-26,18.5},{-26,43}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -120},{140,100}}),      graphics), Icon(coordinateSystem(extent={{-220,
              -120},{140,100}})));
  end Activity_Index_controller;

  model Activity_Index_direct
    Modelica.Mechanics.Rotational.Components.LossyGear lossyGear1(
                                                                 ratio=16,
        lossTable=[0,0.94,0.94,0,0])
      annotation (Placement(transformation(extent={{-12,10},{8,30}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      quadraticSpeedDependentTorque1(                   w_nominal(displayUnit=
            "rad/s") = 19.373154697137,
      TorqueDirection=false,
      tau_nominal=-7742.6)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={54,20})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1
      annotation (Placement(transformation(extent={{-112,10},{-92,30}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1
                                                                  annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-94,-4})));
    Modelica.Blocks.Tables.CombiTable1D TorqueSpeed(table=[0,454; 80,579; 160,
          784; 220,997; 240,1057; 250,1071; 260,1060; 280,919; 300,500; 314,0],
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
      annotation (Placement(transformation(extent={{-146,10},{-126,30}})));
    ActivityIndex.ActivityIndex activityIndex(nu=3, fileName="Ai_direct.txt")
      annotation (Placement(transformation(extent={{52,-22},{72,-2}})));
    ActivityIndex.Mechanics.Rotational.Components.Inertia_AI inertia_AI2(J=1.72)
      annotation (Placement(transformation(extent={{-76,10},{-56,30}})));
    ActivityIndex.Mechanics.Rotational.Components.SpringDamper_AI
      springDamper_AI1(c=866, d=866/100/sqrt(886/1.7))
      annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
    ActivityIndex.Mechanics.Rotational.Components.Inertia_AI inertia_AI3(J=3000)
      annotation (Placement(transformation(extent={{14,10},{34,30}})));
  equation
    connect(speedSensor1.flange, torque1.flange) annotation (Line(
        points={{-94,6},{-94,12},{-92,12},{-92,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(TorqueSpeed.y[1], torque1.tau) annotation (Line(
        points={{-125,20},{-114,20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor1.w, TorqueSpeed.u[1]) annotation (Line(
        points={{-94,-15},{-94,-24},{-162,-24},{-162,20},{-148,20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia_AI3.flange_b, quadraticSpeedDependentTorque1.flange)
      annotation (Line(
        points={{34,20},{44,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_AI3.flange_a, lossyGear1.flange_b) annotation (Line(
        points={{14,20},{8,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(lossyGear1.flange_a, springDamper_AI1.flange_b) annotation (Line(
        points={{-12,20},{-26,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(springDamper_AI1.flange_a, inertia_AI2.flange_b) annotation (Line(
        points={{-46,20},{-56,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_AI2.flange_a, torque1.flange) annotation (Line(
        points={{-76,20},{-92,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(activityIndex.u[1], inertia_AI3.activity) annotation (Line(
        points={{53,-13.9},{38.5,-13.9},{38.5,11},{24,11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(activityIndex.u[2], springDamper_AI1.activity) annotation (Line(
        points={{53,-11.7},{8.5,-11.7},{8.5,11},{-36,11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(activityIndex.u[3], inertia_AI2.activity) annotation (Line(
        points={{53,-9.5},{-6.5,-9.5},{-6.5,11},{-66,11}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -120},{140,100}}),      graphics), Icon(coordinateSystem(extent={{-220,
              -120},{140,100}})));
  end Activity_Index_direct;

  package ActivityIndex

    block ActivityIndex "Activity Index"

    //  replaceable type SignalType = Real "type of input and output signal";

      parameter Integer nu(min=0)=0 "Number of input connections" annotation(Dialog(connectorSizing=true), HideResult=false);
    parameter input String fileName="myResultFile.txt" "Name of the file";

      Modelica.Blocks.Interfaces.RealVectorInput u[nu]
        "Connector with an input signal of type SignalType" annotation (Placement(
            transformation(extent={{-118,-52},{-78,52}},  rotation=0),
            iconTransformation(extent={{-100,-30},{-80,36}})));

    equation
      when (terminal()) then
        Modelica.Utilities.Streams.print("Printing");
        ActivitySensor(fileName, u);
      end when;
        annotation (extent=[-
            140, -20; -100, 20], Diagram(graphics),
                  Icon(graphics={Rectangle(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,20},{80,-20}},
              lineColor={0,0,0},
              textString="Activity Index"),
            Rectangle(
              extent={{-80,80},{80,60}},
              lineColor={0,0,0},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,-60},{80,-80}},
              lineColor={0,0,0},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid)}),
                                 Diagram,
        Placement(transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
    end ActivityIndex;

    function ActivitySensor
      "Generating a txt file that sort the different sensor by activity level."
      import Modelica.Utilities.Streams.*;
      import Modelica.Utilities.Strings.*;
      import Modelica.Utilities.Types.*;
      import Modelica.Utilities.System.*;
      import Modelica.Utilities.Files.*;
      import SI = Modelica.SIunits;
      import Modelica.SIunits.Conversions.*;

    parameter input String resultFileName="activity_index.txt"
        "Name of the result file";

    parameter input Real max[:];

    //protected
      Integer n= size(max,1) "number of components";
      String sensorList[n,3]
        "vector of strings including the sensor components and its info";
      Real sum "sum of all the max values";
      Real temp;
      String originalDirectory= Modelica.Utilities.System.getWorkDirectory();
      String fileName=originalDirectory+resultFileName
        "Name of the file that shall be read";

    algorithm
        //*************Calculation of the sum of all max values for
        sum:=0;
        for i in 1:n loop
          temp:=sum;
          sum:=temp+max[i];
        end for;
        for i in 1:n loop
          sensorList[i,1]:="Component " + String(i);
          sensorList[i,2]:=String(max[i]);
          sensorList[i,3]:=String(max[i]/sum);
        end for;
        //***********Writing in file****************

        Modelica.Utilities.Files.remove(resultFileName);
        Modelica.Utilities.Streams.print("Sensor\t\tMax Value\tPercentage", resultFileName);
        for i in 1:n loop
          Modelica.Utilities.Streams.print(sensorList[i,1]+"\t"+sensorList[i,2]+"\t\t"+sensorList[i,3], resultFileName);
        end for;
      Modelica.Utilities.Streams.close(resultFileName);
      cd(originalDirectory);
    end ActivitySensor;

    package Mechanics

      package Rotational

        package Components
          model Spring_AI "Linear 1D rotational spring with activity index"
            import SI = Modelica.SIunits;
            parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5)
              "Spring constant";
            parameter SI.Angle phi_rel0=0 "Unstretched spring angle";
            Modelica.Mechanics.Rotational.Components.Spring spring(c=c, phi_rel0=phi_rel0)
              annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
            Sensors.ActivityIndex_MechaRSensor activityIndex_MechaRSensor
              annotation (Placement(transformation(extent={{-22,-10},{18,10}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
              annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
              annotation (Placement(transformation(extent={{90,-10},{110,10}})));
            Modelica.Blocks.Interfaces.RealOutput activity
              "Activity in flange flange_a"
               annotation (Placement(transformation(
                  origin={-80,-106},
                  extent={{10,-10},{-10,10}},
                  rotation=90), iconTransformation(
                  extent={{10,-10},{-10,10}},
                  rotation=90,
                  origin={0,-90})));
          equation

            connect(activityIndex_MechaRSensor.flange_a2, spring.flange_a) annotation (
                Line(
                points={{-18,0},{-12,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(spring.flange_b, activityIndex_MechaRSensor.flange_b1) annotation (
                Line(
                points={{8,0},{14,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.flange_a1, flange_a) annotation (Line(
                points={{-22,0},{-100,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.flange_b2, flange_b) annotation (Line(
                points={{18,0},{100,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.activity, activity) annotation (Line(
                points={{-15,-11},{-15,-55.5},{-80,-55.5},{-80,-106}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Diagram(graphics), Icon(graphics={
                  Line(
                    points={{-102,0},{-60,0},{-45,-30},{-15,30},{15,-30},{45,30},{60,0},{98,
                        0}},
                    color={0,0,0},
                    pattern=LinePattern.Solid,
                    thickness=0.25,
                    arrow={Arrow.None,Arrow.None}), Text(
                    extent={{-86,-54},{82,-76}},
                    lineColor={0,0,255},
                    textString="Activity")}));
          end Spring_AI;

          model Inertia_AI
            "1D-rotational component with inertia and activity index"
            import SI = Modelica.SIunits;
            parameter SI.Inertia J(min=0, start=1) "Moment of inertia";
            parameter StateSelect stateSelect=StateSelect.default
              "Priority to use phi and w as states" annotation(HideResult=true,Dialog(tab="Advanced"));

            Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J)
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

            Sensors.ActivityIndex_MechaRSensor activityIndex_MechaRSensor
              annotation (Placement(transformation(extent={{-23,-15},{24,12}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
              annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
              annotation (Placement(transformation(extent={{90,-10},{110,10}})));
            Modelica.Blocks.Interfaces.RealOutput activity
              "Activity in flange flange_a"
               annotation (Placement(transformation(
                  origin={-80,-106},
                  extent={{10,-10},{-10,10}},
                  rotation=90), iconTransformation(
                  extent={{10,-10},{-10,10}},
                  rotation=90,
                  origin={0,-90})));
          equation
            connect(activityIndex_MechaRSensor.flange_a2, inertia.flange_a) annotation (
                Line(
                points={{-18.3,-1.5},{-14.15,-1.5},{-14.15,0},{-10,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(inertia.flange_b, activityIndex_MechaRSensor.flange_b1) annotation (
                Line(
                points={{10,0},{15,0},{15,-1.5},{19.3,-1.5}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.activity, activity) annotation (Line(
                points={{-14.775,-16.35},{-14.775,-57.175},{-80,-57.175},{-80,-106}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.flange_a1, flange_a) annotation (Line(
                points={{-23,-1.5},{-60,-1.5},{-60,0},{-100,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.flange_b2, flange_b) annotation (Line(
                points={{24,-1.5},{63,-1.5},{63,0},{100,0}},
                color={0,0,0},
                smooth=Smooth.None));
            annotation (
              Documentation(info="<html>
<p>
Rotational component with <b>inertia</b> and two rigidly connected flanges.
</p>

</HTML>
"),           Icon(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}},
                  grid={1,1}), graphics={
                  Rectangle(
                    extent={{-100,10},{-50,-10}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={192,192,192}),
                  Rectangle(
                    extent={{50,10},{100,-10}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={192,192,192}),
                  Line(points={{-80,-25},{-60,-25}}, color={0,0,0}),
                  Line(points={{60,-25},{80,-25}}, color={0,0,0}),
                  Line(points={{-70,-25},{-70,-70}}, color={0,0,0}),
                  Line(points={{70,-25},{70,-70}}, color={0,0,0}),
                  Line(points={{-80,25},{-60,25}}, color={0,0,0}),
                  Line(points={{60,25},{80,25}}, color={0,0,0}),
                  Line(points={{-70,45},{-70,25}}, color={0,0,0}),
                  Line(points={{70,45},{70,25}}, color={0,0,0}),
                  Line(points={{-70,-70},{70,-70}}, color={0,0,0}),
                  Rectangle(
                    extent={{-50,50},{50,-50}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={192,192,192}),       Text(
                    extent={{-84,-56},{84,-78}},
                    lineColor={0,0,255},
                    textString="Activity")}),
              Diagram(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}},
                  grid={1,1}), graphics));
          end Inertia_AI;

          model SpringDamper_AI
            "Linear 1D rotational spring and damper in parallel with activity index"
            import SI = Modelica.SIunits;
            parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5)
              "Spring constant";
            parameter SI.RotationalDampingConstant d(final min=0, start=0)
              "Damping constant";
            parameter SI.Angle phi_rel0=0 "Unstretched spring angle";
            Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(
              c=c,
              d=d,
              phi_rel0=phi_rel0)
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
              annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
            Modelica.Blocks.Interfaces.RealOutput activity
              "Activity in flange flange_a"
               annotation (Placement(transformation(
                  origin={-80,-106},
                  extent={{10,-10},{-10,10}},
                  rotation=90), iconTransformation(
                  extent={{10,-10},{-10,10}},
                  rotation=90,
                  origin={0,-90})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
              annotation (Placement(transformation(extent={{90,-10},{110,10}})));
            Sensors.ActivityIndex_MechaRSensor activityIndex_MechaRSensor(Rigid=false)
              annotation (Placement(transformation(extent={{-32,-18},{28,14}})));
          equation
            connect(springDamper.flange_a, activityIndex_MechaRSensor.flange_a2)
              annotation (Line(
                points={{-10,0},{-18,0},{-18,-2},{-26,-2}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.flange_b2, flange_b) annotation (Line(
                points={{28,-2},{64,-2},{64,0},{100,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(springDamper.flange_b, activityIndex_MechaRSensor.flange_b1)
              annotation (Line(
                points={{10,0},{16,0},{16,-2},{22,-2}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.flange_a1, flange_a) annotation (Line(
                points={{-32,-2},{-64,-2},{-64,0},{-100,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaRSensor.activity, activity) annotation (Line(
                points={{-21.5,-19.6},{-21.5,-57.8},{-80,-57.8},{-80,-106}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Icon(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}},
                  grid={1,1}), graphics={
                  Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{
                        60,40},{80,40}}, color={0,0,0}),
                  Line(points={{-80,40},{-80,-40}}, color={0,0,0}),
                  Line(points={{-80,-40},{-50,-40}}, color={0,0,0}),
                  Rectangle(
                    extent={{-50,-10},{40,-70}},
                    lineColor={0,0,0},
                    fillColor={192,192,192},
                    fillPattern=FillPattern.Solid),
                  Line(points={{-50,-10},{70,-10}}, color={0,0,0}),
                  Line(points={{-50,-70},{70,-70}}, color={0,0,0}),
                  Line(points={{40,-40},{80,-40}}, color={0,0,0}),
                  Line(points={{80,40},{80,-40}}, color={0,0,0}),
                  Line(points={{-90,0},{-80,0}}, color={0,0,0}),
                  Line(points={{80,0},{90,0}}, color={0,0,0}),
                                                    Text(
                    extent={{-84,-57},{84,-79}},
                    lineColor={0,0,255},
                    textString="Activity")}),
              Diagram(graphics));
          end SpringDamper_AI;
        end Components;

        package Sensors
          model ActivityIndex_MechaRSensor

            parameter Boolean Rigid=true
              "= true, if differential speed mesurement, otherwise absolute speed mesurement"
                annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

            Modelica.Blocks.Math.Abs abs
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-40,-74})));
            Modelica.Blocks.Continuous.Integrator integrator
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-80,-72})));
            Modelica.Blocks.Interfaces.RealOutput activity
              "Activity in flange flange_a"
               annotation (Placement(transformation(
                  origin={-120,-110},
                  extent={{10,-10},{-10,10}},
                  rotation=90), iconTransformation(
                  extent={{10,-10},{-10,10}},
                  rotation=90,
                  origin={-130,-110})));
            Modelica.Blocks.Math.Product product
              annotation (Placement(transformation(
                    origin={-40,-40},
                    extent={{-10,-10},{10,10}},
                    rotation=270)));
            Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a1
              annotation (Placement(transformation(extent={{-210,-10},{-190,10}}),
                  iconTransformation(extent={{-210,-10},{-190,10}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a2
              annotation (Placement(transformation(extent={{-170,-10},{-150,10}}),
                  iconTransformation(extent={{-170,-10},{-150,10}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1 annotation (
                Placement(transformation(extent={{150,-10},{170,10}}), iconTransformation(
                    extent={{150,-10},{170,10}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b2 annotation (
                Placement(transformation(extent={{190,-10},{210,10}}), iconTransformation(
                    extent={{190,-10},{210,10}})));
            Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-46,-10})));
            Modelica.Blocks.Sources.RealExpression realExpression if not Rigid
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=180,
                  origin={40,20})));
            Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=180,
                  origin={-2,14})));
            Modelica.Blocks.Sources.RealExpression realExpression1(y=1) if
                                                                     Rigid
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=180,
                  origin={40,36})));
            Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
              annotation (Placement(transformation(extent={{-190,-10},{-170,10}})));
            Modelica.Mechanics.Rotational.Sensors.RelSpeedSensor relSpeedSensor if not Rigid
              annotation (Placement(transformation(extent={{-92,48},{-72,68}})));
            Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor if Rigid annotation (
                Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={116,-42})));
            Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor1
              annotation (Placement(transformation(extent={{172,-10},{192,10}})));
          equation
            connect(abs.y, integrator.u) annotation (Line(
                points={{-40,-85},{-40,-92},{-60,-92},{-60,-52},{-80,-52},{-80,-60}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(abs.u, product.y) annotation (Line(
                points={{-40,-62},{-40,-51}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(flange_b1, flange_b1) annotation (Line(
                points={{160,0},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(integrator.y, activity) annotation (Line(
                points={{-80,-83},{-80,-96},{-120,-96},{-120,-110}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(feedback.y, product.u2) annotation (Line(
                points={{-46,-19},{-46,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product1.y, feedback.u1) annotation (Line(
                points={{-13,14},{-46,14},{-46,-2}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(realExpression.y, product1.u2) annotation (Line(
                points={{29,20},{10,20}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(realExpression1.y, product1.u2) annotation (Line(
                points={{29,36},{20,36},{20,20},{10,20}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(torqueSensor.flange_a, flange_a1) annotation (Line(
                points={{-190,0},{-200,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(torqueSensor.flange_b, flange_a2) annotation (Line(
                points={{-170,0},{-160,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(torqueSensor.tau, feedback.u2) annotation (Line(
                points={{-188,-11},{-188,-26},{-96,-26},{-96,-10},{-54,-10}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(relSpeedSensor.w_rel, product.u1) annotation (Line(
                points={{-82,47},{-82,26},{-34,26},{-34,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(flange_b1, speedSensor.flange) annotation (Line(
                points={{160,0},{160,-32},{116,-32}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(speedSensor.w, product.u1) annotation (Line(
                points={{116,-53},{116,-64},{8,-64},{8,-12},{-34,-12},{-34,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(torqueSensor1.flange_a, flange_b1) annotation (Line(
                points={{172,0},{168,0},{168,0},{160,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(torqueSensor1.flange_b, flange_b2) annotation (Line(
                points={{192,0},{200,0}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(torqueSensor1.tau, product1.u1) annotation (Line(
                points={{174,-11},{174,-20},{26,-20},{26,8},{10,8}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(flange_a2, relSpeedSensor.flange_a) annotation (Line(
                points={{-160,0},{-132,0},{-132,58},{-92,58}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(relSpeedSensor.flange_b, flange_b1) annotation (Line(
                points={{-72,58},{160,58},{160,0}},
                color={0,0,0},
                smooth=Smooth.None));
            annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-200,
                      -100},{200,100}}),
                                graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                    extent={{-200,-100},{200,100}}),
                                                graphics={
                                                    Text(
                    extent={{-230,-78},{-62,-100}},
                    lineColor={0,0,255},
                    textString="Activity"),
                  Line(
                    points={{-192,0},{-170,0},{-172,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Line(
                    points={{170,0},{190,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Rectangle(
                    extent={{-180,100},{180,-100}},
                    lineColor={0,0,0},
                    pattern=LinePattern.Dash)}));
          end ActivityIndex_MechaRSensor;
        end Sensors;
      end Rotational;

      package Translational

        package Components

          model Spring_AI "Linear 1D translational spring with activity index"
            parameter Modelica.SIunits.TranslationalSpringConstant c(final min=0, start=1)
              "Spring constant ";
            parameter Modelica.SIunits.Distance s_rel0=0
              "Unstretched spring length";

            Sensors.ActivityIndex_MechaTSensor activityIndex_MechaTSensor(Rigid=
                  false)
              annotation (Placement(transformation(extent={{-76,-28},{76,28}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
              annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
              annotation (Placement(transformation(extent={{92,-10},{112,10}})));
            Modelica.Mechanics.Translational.Components.Spring spring(c=c, s_rel0=
                  s_rel0)
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
            Modelica.Blocks.Interfaces.RealOutput activity "Activity Index"
              annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-60,-110}), iconTransformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={0,-90})));
          equation
            connect(activityIndex_MechaTSensor.flange_a1, flange_a) annotation (
                Line(
                points={{-76,3.55271e-015},{-88,3.55271e-015},{-88,0},{-100,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.flange_b2, flange_b) annotation (
                Line(
                points={{76,3.55271e-015},{89,3.55271e-015},{89,0},{102,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.flange_a2, spring.flange_a)
              annotation (Line(
                points={{-60.8,3.55271e-015},{-35.4,3.55271e-015},{-35.4,0},{-10,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(spring.flange_b, activityIndex_MechaTSensor.flange_b1)
              annotation (Line(
                points={{10,0},{35.4,0},{35.4,3.55271e-015},{60.8,3.55271e-015}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.activity, activity) annotation (Line(
                points={{-49.4,-30.8},{-49.4,-65.4},{-60,-65.4},{-60,-110}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                      {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(
                    preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                  graphics={
                  Line(points={{-98,0},{-60,0},{-44,-30},{-16,30},{14,-30},{44,30},
                        {60,0},{100,0}},
                                       color={0,0,0}),
                                                    Text(
                    extent={{-86,-54},{82,-76}},
                    lineColor={0,0,255},
                    textString="Activity")}));
          end Spring_AI;

          model Mass_AI "Linear 1D translational mass with activity index"

            parameter Modelica.SIunits.Mass m(min=0, start=1)
              "Mass of the sliding mass";
            parameter StateSelect stateSelect=StateSelect.default;

            Sensors.ActivityIndex_MechaTSensor activityIndex_MechaTSensor
              annotation (Placement(transformation(extent={{-76,-28},{76,28}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
              annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
              annotation (Placement(transformation(extent={{92,-10},{112,10}})));
            Modelica.Blocks.Interfaces.RealOutput activity "Activity Index" annotation (
                Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-60,-110}), iconTransformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={0,-90})));
            Modelica.Mechanics.Translational.Components.Mass mass(m=m)
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          equation
            connect(activityIndex_MechaTSensor.flange_a1, flange_a) annotation (Line(
                points={{-76,3.55271e-015},{-88,3.55271e-015},{-88,0},{-100,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.flange_b2, flange_b) annotation (Line(
                points={{76,3.55271e-015},{89,3.55271e-015},{89,0},{102,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.activity, activity) annotation (Line(
                points={{-49.4,-30.8},{-49.4,-65.4},{-60,-65.4},{-60,-110}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(mass.flange_a, activityIndex_MechaTSensor.flange_a2) annotation (Line(
                points={{-10,0},{-35.4,0},{-35.4,3.55271e-015},{-60.8,3.55271e-015}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(mass.flange_b, activityIndex_MechaTSensor.flange_b1) annotation (Line(
                points={{10,0},{35.4,0},{35.4,3.55271e-015},{60.8,3.55271e-015}},
                color={0,127,0},
                smooth=Smooth.None));
            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                      -100},{100,100}}), graphics), Icon(coordinateSystem(
                    preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                  Rectangle(
                    extent={{-53,-30},{57,30}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.Sphere,
                    fillColor={255,255,255}),
                  Line(points={{57,0},{102,0}}, color={0,127,0}),
                  Line(points={{-98,0},{-53,0}},  color={0,127,0}),
                                                    Text(
                    extent={{-84,-54},{84,-76}},
                    lineColor={0,0,255},
                    textString="Activity")}));
          end Mass_AI;

          model SpringDamper_AI
            "Linear 1D translational spring with activity index"
            parameter Modelica.SIunits.TranslationalSpringConstant c(final min=0, start=1)
              "Spring constant ";
            parameter Modelica.SIunits.Distance s_rel0=0
              "Unstretched spring length";
            parameter Modelica.SIunits.TranslationalDampingConstant d(final min=0, start = 1)
              "Damping constant";

            Sensors.ActivityIndex_MechaTSensor activityIndex_MechaTSensor(Rigid=
                  false)
              annotation (Placement(transformation(extent={{-76,-28},{76,28}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
              annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
              annotation (Placement(transformation(extent={{92,-10},{112,10}})));
            Modelica.Mechanics.Translational.Components.SpringDamper spring(c=c, s_rel0=
                  s_rel0,
              d=d)
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
            Modelica.Blocks.Interfaces.RealOutput activity "Activity Index" annotation (
                Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-60,-110}), iconTransformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={0,-90})));
          equation
            connect(activityIndex_MechaTSensor.flange_a1, flange_a) annotation (Line(
                points={{-76,3.55271e-015},{-88,3.55271e-015},{-88,0},{-100,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.flange_b2, flange_b) annotation (Line(
                points={{76,3.55271e-015},{89,3.55271e-015},{89,0},{102,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.flange_a2, spring.flange_a) annotation (
                Line(
                points={{-60.8,3.55271e-015},{-35.4,3.55271e-015},{-35.4,0},{-10,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(spring.flange_b, activityIndex_MechaTSensor.flange_b1) annotation (
                Line(
                points={{10,0},{35.4,0},{35.4,3.55271e-015},{60.8,3.55271e-015}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(activityIndex_MechaTSensor.activity, activity) annotation (Line(
                points={{-49.4,-30.8},{-49.4,-65.4},{-60,-65.4},{-60,-110}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                      -100},{100,100}}), graphics), Icon(coordinateSystem(
                    preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                  Line(points={{-90,0},{-80,0}}, color={0,0,0}),
                  Line(points={{-80,60},{-80,-40}}, color={0,0,0}),
                  Line(points={{-80,-40},{-60,-40},{-45,-70},{-15,-10},{15,-70},{45,
                        -10},{60,-40},{80,-40}},
                                         color={0,0,0}),
                  Line(points={{-80,60},{-52,60}},   color={0,0,0}),
                  Line(points={{-40,60},{80,60}},   color={0,0,0}),
                  Line(points={{26,39},{68,39}},   color={0,0,0}),
                  Rectangle(
                    extent={{-52,81},{38,39}},
                    lineColor={0,0,0},
                    fillColor={192,192,192},
                    fillPattern=FillPattern.Solid),
                  Line(points={{-51,81},{69,81}},   color={0,0,0}),
                  Line(points={{80,0},{90,0}}, color={0,0,0}),
                  Line(points={{80,60},{80,-40}}, color={0,0,0}),
                                                    Text(
                    extent={{-86,-56},{82,-78}},
                    lineColor={0,0,255},
                    textString="Activity")}));
          end SpringDamper_AI;
        end Components;

        package Sensors
          model ActivityIndex_MechaTSensor

            parameter Boolean Rigid=true
              "= true, if differential speed mesurement, otherwise absolute speed mesurement"
                annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

            Modelica.Blocks.Math.Abs abs
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-178,-86})));
            Modelica.Blocks.Continuous.Integrator integrator
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-144,-86})));
            Modelica.Blocks.Interfaces.RealOutput activity
              "Activity in flange flange_a"
               annotation (Placement(transformation(
                  origin={-120,-110},
                  extent={{10,-10},{-10,10}},
                  rotation=90), iconTransformation(
                  extent={{10,-10},{-10,10}},
                  rotation=90,
                  origin={-130,-110})));
            Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor_b
              annotation (Placement(transformation(extent={{172,-10},{192,10}})));
            Modelica.Mechanics.Translational.Sensors.RelSpeedSensor relSpeedSensor if not Rigid
              annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-86,50})));
            Modelica.Blocks.Math.Product product
              annotation (Placement(transformation(
                    origin={-40,-40},
                    extent={{-10,-10},{10,10}},
                    rotation=270)));
            Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor if Rigid annotation (
                Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={120,-38})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a1
              annotation (Placement(transformation(extent={{-210,-10},{-190,10}}),
                  iconTransformation(extent={{-210,-10},{-190,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a2
              annotation (Placement(transformation(extent={{-170,-10},{-150,10}}),
                  iconTransformation(extent={{-170,-10},{-150,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b1 annotation (
                Placement(transformation(extent={{150,-10},{170,10}}), iconTransformation(
                    extent={{150,-10},{170,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b2 annotation (
                Placement(transformation(extent={{190,-10},{210,10}}), iconTransformation(
                    extent={{190,-10},{210,10}})));
            Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor_a
              annotation (Placement(transformation(extent={{-192,-10},{-172,10}})));
            Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-46,-11})));
            Modelica.Blocks.Sources.RealExpression realExpression if not Rigid
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=180,
                  origin={40,20})));
            Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=180,
                  origin={-2,14})));
            Modelica.Blocks.Sources.RealExpression realExpression1(y=1) if
                                                                     Rigid
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=180,
                  origin={40,36})));
          equation
            connect(flange_b1, flange_b1) annotation (Line(
                points={{160,0},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(flange_a1, forceSensor_a.flange_a) annotation (Line(
                points={{-200,0},{-192,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(forceSensor_a.flange_b, flange_a2) annotation (Line(
                points={{-172,0},{-160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(flange_b1, forceSensor_b.flange_a) annotation (Line(
                points={{160,0},{172,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(forceSensor_b.flange_b, flange_b2) annotation (Line(
                points={{192,0},{200,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(relSpeedSensor.flange_a, flange_a2) annotation (Line(
                points={{-96,50},{-160,50},{-160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(relSpeedSensor.flange_b, flange_b1) annotation (Line(
                points={{-76,50},{160,50},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(speedSensor.flange, flange_b1) annotation (Line(
                points={{120,-28},{120,0},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(integrator.y, activity) annotation (Line(
                points={{-133,-86},{-120,-86},{-120,-110}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(feedback.y, product.u2) annotation (Line(
                points={{-46,-20},{-46,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(feedback.u2, forceSensor_a.f) annotation (Line(
                points={{-54,-11},{-190,-11}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product.u1, relSpeedSensor.v_rel) annotation (Line(
                points={{-34,-28},{-34,39},{-86,39}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(speedSensor.v, product.u1) annotation (Line(
                points={{120,-49},{120,-58},{-10,-58},{-10,-18},{-34,-18},{-34,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product1.y, feedback.u1) annotation (Line(
                points={{-13,14},{-46,14},{-46,-3}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(forceSensor_b.f, product1.u1) annotation (Line(
                points={{174,-11},{174,-18},{18,-18},{18,8},{10,8}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(realExpression.y, product1.u2) annotation (Line(
                points={{29,20},{10,20}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(realExpression1.y, product1.u2) annotation (Line(
                points={{29,36},{20,36},{20,20},{10,20}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(abs.y, integrator.u) annotation (Line(
                points={{-167,-86},{-156,-86}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product.y, abs.u) annotation (Line(
                points={{-40,-51},{-40,-60},{-198,-60},{-198,-86},{-190,-86}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
                      -100},{200,100}}),
                                graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                    extent={{-200,-100},{200,100}}),
                                                graphics={
                                                    Text(
                    extent={{-230,-78},{-62,-100}},
                    lineColor={0,0,255},
                    textString="Activity"),
                  Line(
                    points={{-192,0},{-170,0},{-172,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Line(
                    points={{170,0},{190,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Rectangle(
                    extent={{-180,100},{180,-100}},
                    lineColor={0,0,0},
                    pattern=LinePattern.Dash)}));
          end ActivityIndex_MechaTSensor;

          model ActivityIndex_MechaTSensor_Rigid

            parameter Boolean Rigid=true
              "= true, if differential speed mesurement, otherwise absolute speed mesurement"
                annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

            Modelica.Blocks.Math.Abs abs
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-178,-86})));
            Modelica.Blocks.Continuous.Integrator integrator
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-144,-86})));
            Modelica.Blocks.Interfaces.RealOutput activity
              "Activity in flange flange_a"
               annotation (Placement(transformation(
                  origin={-120,-110},
                  extent={{10,-10},{-10,10}},
                  rotation=90), iconTransformation(
                  extent={{10,-10},{-10,10}},
                  rotation=90,
                  origin={-130,-110})));
            Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor_b
              annotation (Placement(transformation(extent={{172,-10},{192,10}})));
            Modelica.Blocks.Math.Product product
              annotation (Placement(transformation(
                    origin={-40,-40},
                    extent={{-10,-10},{10,10}},
                    rotation=270)));
            Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor if Rigid annotation (
                Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={120,-38})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a1
              annotation (Placement(transformation(extent={{-210,-10},{-190,10}}),
                  iconTransformation(extent={{-210,-10},{-190,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a2
              annotation (Placement(transformation(extent={{-170,-10},{-150,10}}),
                  iconTransformation(extent={{-170,-10},{-150,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b1 annotation (
                Placement(transformation(extent={{150,-10},{170,10}}), iconTransformation(
                    extent={{150,-10},{170,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b2 annotation (
                Placement(transformation(extent={{190,-10},{210,10}}), iconTransformation(
                    extent={{190,-10},{210,10}})));
            Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor_a
              annotation (Placement(transformation(extent={{-192,-10},{-172,10}})));
            Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=270,
                  origin={-46,-11})));
          equation
            connect(flange_b1, flange_b1) annotation (Line(
                points={{160,0},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(flange_a1, forceSensor_a.flange_a) annotation (Line(
                points={{-200,0},{-192,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(forceSensor_a.flange_b, flange_a2) annotation (Line(
                points={{-172,0},{-160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(flange_b1, forceSensor_b.flange_a) annotation (Line(
                points={{160,0},{172,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(forceSensor_b.flange_b, flange_b2) annotation (Line(
                points={{192,0},{200,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(speedSensor.flange, flange_b1) annotation (Line(
                points={{120,-28},{120,0},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(integrator.y, activity) annotation (Line(
                points={{-133,-86},{-120,-86},{-120,-110}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(feedback.y, product.u2) annotation (Line(
                points={{-46,-20},{-46,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(feedback.u2, forceSensor_a.f) annotation (Line(
                points={{-54,-11},{-190,-11}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(speedSensor.v, product.u1) annotation (Line(
                points={{120,-49},{120,-58},{-10,-58},{-10,-18},{-34,-18},{-34,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(abs.y, integrator.u) annotation (Line(
                points={{-167,-86},{-156,-86}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product.y, abs.u) annotation (Line(
                points={{-40,-51},{-40,-60},{-198,-60},{-198,-86},{-190,-86}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(forceSensor_b.f, feedback.u1) annotation (Line(
                points={{174,-11},{174,-20},{70,-20},{70,6},{-46,6},{-46,-3}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
                      -100},{200,100}}),
                                graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                    extent={{-200,-100},{200,100}}),
                                                graphics={
                                                    Text(
                    extent={{-230,-78},{-62,-100}},
                    lineColor={0,0,255},
                    textString="Activity"),
                  Line(
                    points={{-192,0},{-170,0},{-172,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Line(
                    points={{170,0},{190,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Rectangle(
                    extent={{-180,100},{180,-100}},
                    lineColor={0,0,0},
                    pattern=LinePattern.Dash)}));
          end ActivityIndex_MechaTSensor_Rigid;

          model ActivityIndex_MechaTSensor_NoRigid

            parameter Boolean Rigid=true
              "= true, if differential speed mesurement, otherwise absolute speed mesurement"
                annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

            Modelica.Blocks.Math.Abs abs
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-178,-86})));
            Modelica.Blocks.Continuous.Integrator integrator
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-144,-86})));
            Modelica.Blocks.Interfaces.RealOutput activity
              "Activity in flange flange_a"
               annotation (Placement(transformation(
                  origin={-120,-110},
                  extent={{10,-10},{-10,10}},
                  rotation=90), iconTransformation(
                  extent={{10,-10},{-10,10}},
                  rotation=90,
                  origin={-130,-110})));
            Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor_b
              annotation (Placement(transformation(extent={{172,-10},{192,10}})));
            Modelica.Mechanics.Translational.Sensors.RelSpeedSensor relSpeedSensor if not Rigid
              annotation (Placement(transformation(
                  extent={{-10,-10},{10,10}},
                  rotation=0,
                  origin={-86,50})));
            Modelica.Blocks.Math.Product product
              annotation (Placement(transformation(
                    origin={-40,-40},
                    extent={{-10,-10},{10,10}},
                    rotation=270)));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a1
              annotation (Placement(transformation(extent={{-210,-10},{-190,10}}),
                  iconTransformation(extent={{-210,-10},{-190,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a2
              annotation (Placement(transformation(extent={{-170,-10},{-150,10}}),
                  iconTransformation(extent={{-170,-10},{-150,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b1 annotation (
                Placement(transformation(extent={{150,-10},{170,10}}), iconTransformation(
                    extent={{150,-10},{170,10}})));
            Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b2 annotation (
                Placement(transformation(extent={{190,-10},{210,10}}), iconTransformation(
                    extent={{190,-10},{210,10}})));
            Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor_a
              annotation (Placement(transformation(extent={{-192,-10},{-172,10}})));
          equation
            connect(flange_b1, flange_b1) annotation (Line(
                points={{160,0},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(flange_a1, forceSensor_a.flange_a) annotation (Line(
                points={{-200,0},{-192,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(forceSensor_a.flange_b, flange_a2) annotation (Line(
                points={{-172,0},{-160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(flange_b1, forceSensor_b.flange_a) annotation (Line(
                points={{160,0},{172,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(forceSensor_b.flange_b, flange_b2) annotation (Line(
                points={{192,0},{200,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(relSpeedSensor.flange_a, flange_a2) annotation (Line(
                points={{-96,50},{-160,50},{-160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(relSpeedSensor.flange_b, flange_b1) annotation (Line(
                points={{-76,50},{160,50},{160,0}},
                color={0,127,0},
                smooth=Smooth.None));
            connect(integrator.y, activity) annotation (Line(
                points={{-133,-86},{-120,-86},{-120,-110}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product.u1, relSpeedSensor.v_rel) annotation (Line(
                points={{-34,-28},{-34,39},{-86,39}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(abs.y, integrator.u) annotation (Line(
                points={{-167,-86},{-156,-86}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(product.y, abs.u) annotation (Line(
                points={{-40,-51},{-40,-60},{-198,-60},{-198,-86},{-190,-86}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(forceSensor_a.f, product.u2) annotation (Line(
                points={{-190,-11},{-190,-18},{-46,-18},{-46,-28}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
                      -100},{200,100}}),
                                graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                    extent={{-200,-100},{200,100}}),
                                                graphics={
                                                    Text(
                    extent={{-230,-78},{-62,-100}},
                    lineColor={0,0,255},
                    textString="Activity"),
                  Line(
                    points={{-192,0},{-170,0},{-172,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Line(
                    points={{170,0},{190,0}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Rectangle(
                    extent={{-180,100},{180,-100}},
                    lineColor={0,0,0},
                    pattern=LinePattern.Dash)}));
          end ActivityIndex_MechaTSensor_NoRigid;
        end Sensors;
      end Translational;
    end Mechanics;

    package Electrical
      package Components
      end Components;

      package Sensors
        model ActivityIndex_ElecSensor "Sensor to measure the activity index"

          Modelica.Electrical.Analog.Interfaces.PositivePin pc
            "Positive pin, current path"
            annotation (Placement(transformation(extent={{-90,-10},{-110,10}}, rotation=
                     0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin nc
            "Negative pin, current path"
            annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=0)));
          Modelica.Electrical.Analog.Interfaces.PositivePin pv
            "Positive pin, voltage path"
            annotation (Placement(transformation(extent={{-10,110},{10,90}}, rotation=0)));
          Modelica.Electrical.Analog.Interfaces.NegativePin nv
            "Negative pin, voltage path"
            annotation (Placement(transformation(extent={{10,-110},{-10,-90}}, rotation=
                     0)));
          Modelica.Blocks.Interfaces.RealOutput activity
            annotation (Placement(transformation(
                  origin={-80,-110},
                  extent={{-10,10},{10,-10}},
                  rotation=270)));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
            annotation (Placement(transformation(
                  origin={0,-30},
                  extent={{10,-10},{-10,10}},
                  rotation=90)));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}}, rotation=
                      0)));
          Modelica.Blocks.Math.Product product
            annotation (Placement(transformation(
                  origin={-30,-50},
                  extent={{-10,-10},{10,10}},
                  rotation=270)));

          Modelica.Blocks.Math.Abs abs
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-30,-80})));
          Modelica.Blocks.Continuous.Integrator integrator
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-80,-80})));
        equation
          connect(pv, voltageSensor.p) annotation (Line(points={{0,100},{0,-20},{
                  6.12323e-016,-20}},   color={0,0,255}));
          connect(voltageSensor.n, nv) annotation (Line(points={{-6.12323e-016,-40},{
                  -6.12323e-016,-63},{0,-63},{0,-100}},   color={0,0,255}));
          connect(pc, currentSensor.p)
            annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
          connect(currentSensor.n, nc)
            annotation (Line(points={{-30,0},{100,0}}, color={0,0,255}));
          connect(currentSensor.i, product.u2) annotation (Line(points={{-40,-10},{-40,
                    -30},{-36,-30},{-36,-38}}, color={0,0,127}));
          connect(voltageSensor.v, product.u1) annotation (Line(points={{10,-30},{-24,
                  -30},{-24,-38}},   color={0,0,127}));
          connect(abs.u, product.y) annotation (Line(
              points={{-30,-68},{-30,-66.25},{-30,-66.25},{-30,-64.5},{-30,-61},{-30,
                  -61}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(abs.y, integrator.u) annotation (Line(
              points={{-30,-91},{-30,-94},{-60,-94},{-60,-56},{-80,-56},{-80,-68}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(integrator.y, activity)
                                       annotation (Line(
              points={{-80,-91},{-80,-110}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Icon(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}},
                  grid={2,2}), graphics={
                  Ellipse(
                    extent={{-70,70},{70,-70}},
                    lineColor={0,0,0},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),
                  Line(points={{0,100},{0,70}}, color={0,0,255}),
                  Line(points={{0,-70},{0,-100}}, color={0,0,255}),
                  Line(points={{-80,-100},{-80,0}}, color={0,0,255}),
                  Line(points={{-100,0},{100,0}}, color={0,0,255}),
                  Text(
                    extent={{150,120},{-150,160}},
                    textString="%name",
                    lineColor={0,0,255}),
                  Line(points={{0,70},{0,40}}, color={0,0,0}),
                  Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
                  Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
                  Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
                  Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
                  Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
                  Polygon(
                    points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),
                  Ellipse(
                    extent={{-5,5},{5,-5}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-29,-11},{30,-70}},
                    lineColor={0,0,0},
                    textString="P"),              Text(
                  extent={{-160,-76},{8,-98}},
                  lineColor={0,0,255},
                  textString="Activity")}),
            Diagram(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-100,-100},{100,100}},
                  grid={2,2}), graphics),
            Documentation(info="<html>
<p>This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are pv and nv, the pins of the current path are pc and nc. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.</p>
</html>",         revisions="<html>
<ul>
<li><i>January 12, 2006</i> by Anton Haumer implemented</li>
</ul>
</html>"));
        end ActivityIndex_ElecSensor;
      end Sensors;
    end Electrical;

    package Examples
      model Mass_gravity "Sliding mass with inertia under gravity"
        parameter Modelica.SIunits.Mass m(min=0, start=1)
          "mass of the sliding mass";
        parameter Modelica.SIunits.Acceleration g=9.81 "gravity coefficient";

        parameter StateSelect stateSelect=StateSelect.default
          "Priority to use s and v as states" annotation(Dialog(tab="Advanced"));
        extends Modelica.Mechanics.Translational.Interfaces.PartialRigid(L=0, s(start=
               0, stateSelect=stateSelect));
        Modelica.SIunits.Velocity v(start=0, stateSelect=stateSelect)
          "absolute velocity of component";
        Modelica.SIunits.Acceleration a(start=0)
          "absolute acceleration of component";

      equation
        v = der(s);
        a = der(v);
        m*a = flange_a.f + flange_b.f-m*g;
        annotation (
          Documentation(info="<html>
<p>
Sliding mass with <i>inertia, without friction</i> and two rigidly connected flanges.
</p>
<p>
The sliding mass has the length L, the position coordinate s is in the middle.
Sign convention: A positive force at flange flange_a moves the sliding mass in the positive direction.
A negative force at flange flange_a moves the sliding mass to the negative direction.
</p>

</html>
"),       Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Line(points={{-100,0},{-55,0}}, color={0,127,0}),
              Line(points={{55,0},{100,0}}, color={0,127,0}),
              Rectangle(
                extent={{-55,-30},{56,30}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={255,255,255}),
              Polygon(
                points={{50,-90},{20,-80},{20,-100},{50,-90}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Line(points={{-60,-90},{20,-90}}, color={0,0,0}),
              Text(
                extent={{0,100},{0,40}},
                textString="%name",
                lineColor={0,0,255}),
              Text(
                extent={{-100,-40},{100,-80}},
                lineColor={0,0,255},
                textString="m=%m")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Line(points={{-100,0},{-55,0}}, color={0,127,0}),
              Line(points={{55,0},{100,0}}, color={0,127,0}),
              Rectangle(
                extent={{-55,-30},{55,30}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={255,255,255}),
              Polygon(
                points={{50,-90},{20,-80},{20,-100},{50,-90}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Line(points={{-60,-90},{20,-90}}, color={0,0,0}),
              Line(points={{-100,-29},{-100,-61}}, color={0,0,0}),
              Line(points={{100,-61},{100,-28}}, color={0,0,0}),
              Line(points={{-98,-60},{98,-60}}, color={0,0,0}),
              Polygon(
                points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{100,-60},{95,-61},{95,-59},{100,-60}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-44,-41},{51,-57}},
                textString="Length L",
                lineColor={0,0,255}),
              Line(points={{0,30},{0,53}}, color={0,0,0}),
              Line(points={{-72,40},{1,40}}, color={0,0,0}),
              Polygon(
                points={{-7,42},{-7,38},{-1,40},{-7,42}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-61,53},{-9,42}},
                textString="Position s",
                lineColor={0,0,255}),
              Polygon(
                points={{15,0},{-15,10},{-15,-10},{15,0}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid,
                origin={-75,80},
                rotation=180),
              Line(points={{-40,0},{40,0}},     color={0,0,0},
                origin={-20,80},
                rotation=180),
              Text(
                extent={{-31,92},{21,81}},
                lineColor={0,0,255},
                textString="gravite")}));
      end Mass_gravity;

      model SuspensionTest

        Mass_gravity
          massCar(
          m=250,
          v(fixed=false),
          s(fixed=true, start=-0.21417))
                         annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=90,
              origin={0,106})));
        Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
                     d=1000, c=12262.5)
                             annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=90,
              origin={0,54})));
        Mass_gravity
          massTire(
          m=10,
          v(fixed=false),
          s(fixed=true, start=-0.01417))                             annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,2})));
        Modelica.Mechanics.Translational.Components.SpringDamper springTire(c=
              180000, d=100) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-48})));
        Modelica.Mechanics.Translational.Sources.Position position annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={2,-88})));
        Modelica.Blocks.Sources.Sine sine(
          amplitude=0.025,
          startTime=0,
          freqHz=1/1.8)
          annotation (Placement(transformation(extent={{-66,-96},{-46,-76}})));
        ActivityIndex activityIndex(nu=4, fileName="myResultFile2.txt")
          annotation (Placement(transformation(extent={{64,4},{84,24}})));
        Mechanics.Translational.Sensors.ActivityIndex_MechaTSensor
          activityIndex_MechaTSensor(Rigid=false) annotation (Placement(
              transformation(
              extent={{-22,-16},{22,16}},
              rotation=90,
              origin={2,-46})));
        Mechanics.Translational.Sensors.ActivityIndex_MechaTSensor
          activityIndex_MechaTSensor1 annotation (Placement(transformation(
              extent={{-20,-11},{20,11}},
              rotation=90,
              origin={0,3})));
        Mechanics.Translational.Sensors.ActivityIndex_MechaTSensor
          activityIndex_MechaTSensor2(Rigid=false) annotation (Placement(
              transformation(
              extent={{-24,-23},{24,23}},
              rotation=90,
              origin={1,54})));
        Mechanics.Translational.Sensors.ActivityIndex_MechaTSensor
          activityIndex_MechaTSensor3 annotation (Placement(transformation(
              extent={{-25,-16},{25,16}},
              rotation=90,
              origin={-1.77636e-015,107})));
      equation
        connect(sine.y, position.s_ref) annotation (Line(
            points={{-45,-86},{-16,-86},{-16,-100},{2,-100}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(springTire.flange_a, activityIndex_MechaTSensor.flange_a2)
          annotation (Line(
            points={{-6.12323e-016,-58},{0,-58},{0,-63.6},{2,-63.6}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor.flange_a1, position.flange) annotation (
            Line(
            points={{2,-68},{2,-78}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(springTire.flange_b, activityIndex_MechaTSensor.flange_b1)
          annotation (Line(
            points={{6.12323e-016,-38},{2,-38},{2,-28.4}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor3.flange_a2, massCar.flange_a) annotation (
            Line(
            points={{-1.22465e-015,87},{-1.22465e-015,89.2},{9.19104e-016,89.2},{
                9.19104e-016,92}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(massCar.flange_b, activityIndex_MechaTSensor3.flange_b1) annotation (
            Line(
            points={{2.63361e-015,120},{1.22465e-015,120},{1.22465e-015,127}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor3.flange_a1, activityIndex_MechaTSensor2.flange_b2)
          annotation (Line(
            points={{-1.53081e-015,82},{0,82},{0,78},{1,78}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor2.flange_b1, springDamper.flange_b)
          annotation (Line(
            points={{1,73.2},{1,69.7},{2.63361e-015,69.7},{2.63361e-015,68}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(springDamper.flange_a, activityIndex_MechaTSensor2.flange_a2)
          annotation (Line(
            points={{9.19104e-016,40},{1,40},{1,34.8}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor2.flange_a1, activityIndex_MechaTSensor1.flange_b2)
          annotation (Line(
            points={{1,30},{1.22465e-015,30},{1.22465e-015,23}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor1.flange_b1, massTire.flange_b) annotation (
           Line(
            points={{9.79717e-016,19},{9.79717e-016,15.5},{6.12323e-016,15.5},{
                6.12323e-016,12}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(massTire.flange_a, activityIndex_MechaTSensor1.flange_a2) annotation (
           Line(
            points={{-6.12323e-016,-8},{-9.79717e-016,-8},{-9.79717e-016,-13}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor1.flange_a1, activityIndex_MechaTSensor.flange_b2)
          annotation (Line(
            points={{-1.22465e-015,-17},{-1.22465e-015,-20.5},{2,-20.5},{2,-24}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor.activity, activityIndex.u[1]) annotation (
            Line(
            points={{19.6,-60.3},{19.6,-24.15},{65,-24.15},{65,11.825}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor1.activity, activityIndex.u[2]) annotation (
           Line(
            points={{12.1,-10},{38,-10},{38,13.475},{65,13.475}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor2.activity, activityIndex.u[3]) annotation (
           Line(
            points={{26.3,38.4},{45.15,38.4},{45.15,15.125},{65,15.125}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(activityIndex_MechaTSensor3.activity, activityIndex.u[4]) annotation (
           Line(
            points={{17.6,90.75},{17.6,52.375},{65,52.375},{65,16.775}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                            graphics={Line(
                points={{40,60},{40,40}},
                color={0,0,255},
                smooth=Smooth.None,
                arrow={Arrow.None,Arrow.Filled}), Text(
                extent={{42,56},{50,48}},
                lineColor={0,0,255},
                textString="g")}));
      end SuspensionTest;

      model SuspensionTest_2

        Mechanics.Translational.Components.Mass_AI
          massCar(
          m=250)         annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=90,
              origin={0,80})));
        Mechanics.Translational.Components.SpringDamper_AI       springDamper(
                     d=1000, c=12262.5)
                             annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=90,
              origin={0,42})));
        Mechanics.Translational.Components.Mass_AI
          massTire(
          m=10)                                                      annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,2})));
        Mechanics.Translational.Components.SpringDamper_AI       springTire(c=
              180000, d=100) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-30})));
        Modelica.Mechanics.Translational.Sources.Position position annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-60})));
        Modelica.Blocks.Sources.Sine sine(
          amplitude=0.025,
          startTime=0,
          freqHz=1/1.8)
          annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
        ActivityIndex activityIndex(      fileName="myResultFile2.txt", nu=4)
          annotation (Placement(transformation(extent={{64,4},{84,24}})));
      equation
        connect(sine.y, position.s_ref) annotation (Line(
            points={{-49,-72},{0,-72}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(position.flange, springTire.flange_a) annotation (Line(
            points={{0,-50},{0,-40}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(springTire.flange_b, massTire.flange_a) annotation (Line(
            points={{0,-19.8},{0,-8}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(massTire.flange_b, springDamper.flange_a) annotation (Line(
            points={{0,12.2},{0,28}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(springDamper.flange_b, massCar.flange_a) annotation (Line(
            points={{0,56.28},{0,66},{8.88178e-016,66}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(massCar.activity, activityIndex.u[1]) annotation (Line(
            points={{12.6,80},{38,80},{38,11.825},{65,11.825}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(springDamper.activity, activityIndex.u[2]) annotation (Line(
            points={{12.6,42},{38,42},{38,13.475},{65,13.475}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(massTire.activity, activityIndex.u[3]) annotation (Line(
            points={{9,2},{38,2},{38,15.125},{65,15.125}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(springTire.activity, activityIndex.u[4]) annotation (Line(
            points={{9,-30},{38,-30},{38,16.775},{65,16.775}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                            graphics));
      end SuspensionTest_2;

      model SuspensionTest_3_Simplify

        Mechanics.Translational.Components.Mass_AI
          massCar(
          m=250)         annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=90,
              origin={0,80})));
        Mechanics.Translational.Components.SpringDamper_AI       springDamper(
                     d=1000, c=12262.5)
                             annotation (Placement(transformation(
              extent={{-14,-14},{14,14}},
              rotation=90,
              origin={0,42})));
        Modelica.Mechanics.Translational.Sources.Position position annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-60})));
        Modelica.Blocks.Sources.Sine sine(
          amplitude=0.025,
          startTime=0,
          freqHz=1/1.8)
          annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
        ActivityIndex activityIndex(      fileName="myResultFile2.txt", nu=2)
          annotation (Placement(transformation(extent={{64,4},{84,24}})));
      equation
        connect(sine.y, position.s_ref) annotation (Line(
            points={{-49,-72},{0,-72}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(springDamper.flange_b, massCar.flange_a) annotation (Line(
            points={{0,56.28},{0,66},{8.88178e-016,66}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(massCar.activity, activityIndex.u[1]) annotation (Line(
            points={{12.6,80},{38,80},{38,12.65},{65,12.65}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(springDamper.activity, activityIndex.u[2]) annotation (Line(
            points={{12.6,42},{38,42},{38,15.95},{65,15.95}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(position.flange, springDamper.flange_a) annotation (Line(
            points={{0,-50},{0,28}},
            color={0,127,0},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                            graphics));
      end SuspensionTest_3_Simplify;
    end Examples;
    annotation ();
  end ActivityIndex;
  annotation (uses(Modelica(version="3.2.2")));
end Chap3_CoolingTowerFan;
