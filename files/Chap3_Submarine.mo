within ;
package Chap3_Submarine
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

  model FullModel
    Modelica.Electrical.Analog.Basic.EMF emf(k=700/(120*2*3.14/60))
      annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-30,-8},{-10,12}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=8e-3)
      annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=20e-3)
      annotation (Placement(transformation(extent={{-46,44},{-26,64}})));
    Modelica.Electrical.Analog.Sources.TableVoltage tableVoltage(table=[0,0; 50,
          700; 100,700; 100,0; 150,0]) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,32})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-90,-8},{-70,12}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia_motor(J=3e3)
      annotation (Placement(transformation(extent={{2,20},{22,40}})));
    Modelica.Mechanics.Rotational.Components.Damper friction_motor(d=10)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,12})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper shaft_stiffness_loss(
        c=6.5e6, d=25000)
      annotation (Placement(transformation(extent={{32,20},{52,40}})));
    Modelica.Mechanics.Rotational.Components.Inertia Propeler_Inertia(J=150e3)
      annotation (Placement(transformation(extent={{92,16},{120,44}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction Propeler_friction(
        tau_pos=[0,9000])
      annotation (Placement(transformation(extent={{62,20},{82,40}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      Propeler_quadratic_torque(
      w_nominal=120*2*3.14/60,
      TorqueDirection=false,
      tau_nominal=-(1.75e5 - 9e3))
      annotation (Placement(transformation(extent={{156,19},{134,41}})));
  equation
    connect(emf.p, inductor.n) annotation (Line(
        points={{-20,40},{-20,54},{-26,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(emf.n, ground.p) annotation (Line(
        points={{-20,20},{-20,12}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(inductor.p, resistor.n) annotation (Line(
        points={{-46,54},{-54,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(tableVoltage.p, resistor.p) annotation (Line(
        points={{-80,42},{-80,54},{-74,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground1.p, tableVoltage.n) annotation (Line(
        points={{-80,12},{-80,22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(emf.flange, inertia_motor.flange_a) annotation (Line(
        points={{-10,30},{2,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(friction_motor.flange_b, inertia_motor.flange_a) annotation (Line(
        points={{0,22},{0,30},{2,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, friction_motor.flange_a) annotation (Line(
        points={{0,-2},{0,2}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_motor.flange_b, shaft_stiffness_loss.flange_a) annotation (
        Line(
        points={{22,30},{32,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(shaft_stiffness_loss.flange_b, Propeler_friction.flange_a)
      annotation (Line(
        points={{52,30},{62,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Propeler_friction.flange_b, Propeler_Inertia.flange_a) annotation (
        Line(
        points={{82,30},{92,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Propeler_quadratic_torque.flange, Propeler_Inertia.flange_b)
      annotation (Line(
        points={{134,30},{120,30}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-20},{180,100}}), graphics), Icon(coordinateSystem(extent={{
              -100,-20},{180,100}})));
  end FullModel;

  model ReducedModel
    Modelica.Electrical.Analog.Basic.EMF emf(k=700/(120*2*3.14/60))
      annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-30,-8},{-10,12}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=8e-3)
      annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=20e-3)
      annotation (Placement(transformation(extent={{-46,44},{-26,64}})));
    Modelica.Electrical.Analog.Sources.TableVoltage tableVoltage(table=[0,0; 50,
          700; 100,700; 100,0; 150,0]) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,32})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-90,-8},{-70,12}})));
    Modelica.Mechanics.Rotational.Components.Damper friction_motor(d=10)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,12})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
    Modelica.Mechanics.Rotational.Components.Inertia Propeler_Inertia(J=150e3)
      annotation (Placement(transformation(extent={{94,16},{122,44}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction Propeler_friction(
        tau_pos=[0,9000])
      annotation (Placement(transformation(extent={{62,20},{82,40}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      Propeler_quadratic_torque(
      w_nominal=120*2*3.14/60,
      tau_nominal=-1.75e5,
      TorqueDirection=true)
      annotation (Placement(transformation(extent={{156,19},{134,41}})));
  equation
    connect(emf.p, inductor.n) annotation (Line(
        points={{-20,40},{-20,54},{-26,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(emf.n, ground.p) annotation (Line(
        points={{-20,20},{-20,12}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(inductor.p, resistor.n) annotation (Line(
        points={{-46,54},{-54,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(tableVoltage.p, resistor.p) annotation (Line(
        points={{-80,42},{-80,54},{-74,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground1.p, tableVoltage.n) annotation (Line(
        points={{-80,12},{-80,22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(fixed.flange, friction_motor.flange_a) annotation (Line(
        points={{0,-2},{0,2}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Propeler_friction.flange_b, Propeler_Inertia.flange_a) annotation (
        Line(
        points={{82,30},{94,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(emf.flange, Propeler_friction.flange_a) annotation (Line(
        points={{-10,30},{62,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(friction_motor.flange_b, Propeler_friction.flange_a) annotation (
        Line(
        points={{4.44089e-016,22},{0,22},{0,30},{62,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Propeler_Inertia.flange_b, Propeler_quadratic_torque.flange)
      annotation (Line(
        points={{122,30},{134,30}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-20},{180,100}}), graphics), Icon(coordinateSystem(extent={{
              -100,-20},{180,100}})));
  end ReducedModel;

  model FullModel_AI
    Modelica.Electrical.Analog.Basic.EMF emf(k=700/(120*2*3.14/60))
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=8e-3)
      annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=20e-3)
      annotation (Placement(transformation(extent={{-26,44},{-6,64}})));
    Modelica.Electrical.Analog.Sources.TableVoltage tableVoltage(table=[0,0; 50,
          700; 100,700; 100,0; 150,0]) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,32})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-90,-8},{-70,12}})));
    ActivityIndex.Mechanics.Rotational.Components.Inertia_AI inertia_motor(J=
          3e3) annotation (Placement(transformation(extent={{22,20},{42,40}})));
    Modelica.Mechanics.Rotational.Components.Damper friction_motor(d=10)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,12})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{10,-12},{30,8}})));
    ActivityIndex.Mechanics.Rotational.Components.SpringDamper_AI
      shaft_stiffness_loss(c=6.5e6, d=25000)
      annotation (Placement(transformation(extent={{52,20},{72,40}})));
    ActivityIndex.Mechanics.Rotational.Components.Inertia_AI Propeler_Inertia(J=
         150e3)
      annotation (Placement(transformation(extent={{112,16},{140,44}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction Propeler_friction(
        tau_pos=[0,9000])
      annotation (Placement(transformation(extent={{82,20},{102,40}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
      Propeler_quadratic_torque(
      w_nominal=120*2*3.14/60,
      TorqueDirection=false,
      tau_nominal=-1.75e5)
      annotation (Placement(transformation(extent={{176,19},{154,41}})));
    ActivityIndex.Electrical.Sensors.ActivityIndex_ElecSensor
      activityIndex_ElecSensor
      annotation (Placement(transformation(extent={{-50,44},{-30,64}})));
    ActivityIndex.ActivityIndex activityIndex(nu=4)
      annotation (Placement(transformation(extent={{170,-34},{190,-14}})));
  equation
    connect(emf.p, inductor.n) annotation (Line(
        points={{0,40},{0,54},{-6,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(emf.n, ground.p) annotation (Line(
        points={{0,20},{0,12}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(tableVoltage.p, resistor.p) annotation (Line(
        points={{-80,42},{-80,54},{-74,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground1.p, tableVoltage.n) annotation (Line(
        points={{-80,12},{-80,22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(emf.flange, inertia_motor.flange_a) annotation (Line(
        points={{10,30},{22,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(friction_motor.flange_b, inertia_motor.flange_a) annotation (Line(
        points={{20,22},{20,30},{22,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, friction_motor.flange_a) annotation (Line(
        points={{20,-2},{20,2}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia_motor.flange_b, shaft_stiffness_loss.flange_a) annotation (
        Line(
        points={{42,30},{52,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(shaft_stiffness_loss.flange_b, Propeler_friction.flange_a)
      annotation (Line(
        points={{72,30},{82,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Propeler_friction.flange_b, Propeler_Inertia.flange_a) annotation (
        Line(
        points={{102,30},{112,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Propeler_quadratic_torque.flange, Propeler_Inertia.flange_b)
      annotation (Line(
        points={{154,30},{140,30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(resistor.n, activityIndex_ElecSensor.pc) annotation (Line(
        points={{-54,54},{-50,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(activityIndex_ElecSensor.nc, inductor.p) annotation (Line(
        points={{-30,54},{-26,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(activityIndex_ElecSensor.pv, inductor.p) annotation (Line(
        points={{-40,64},{-26,64},{-26,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(activityIndex_ElecSensor.nv, emf.p) annotation (Line(
        points={{-40,44},{-40,44},{-40,40},{-38,40},{-38,40},{-20,40},{-20,40},
            {0,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(activityIndex_ElecSensor.activity, activityIndex.u[1]) annotation (
        Line(
        points={{-48,43},{-48,-18},{171,-18},{171,-26.175}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia_motor.activity, activityIndex.u[2]) annotation (Line(
        points={{32,21},{32,-24.525},{171,-24.525}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(shaft_stiffness_loss.activity, activityIndex.u[3]) annotation (Line(
        points={{62,21},{64,21},{64,-22.875},{171,-22.875}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Propeler_Inertia.activity, activityIndex.u[4]) annotation (Line(
        points={{126,17.4},{128,17.4},{128,-28},{171,-28},{171,-21.225}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-40},{240,80}}), graphics), Icon(coordinateSystem(extent={{
              -100,-40},{240,80}})));
  end FullModel_AI;

  model DCmotor
    Modelica.Electrical.Analog.Basic.EMF K(k=700/(120*2*3.14/60))
      annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-16,-38},{4,-18}})));
    Modelica.Electrical.Analog.Basic.Resistor R(R=8e-3)
      annotation (Placement(transformation(extent={{-60,14},{-40,34}})));
    Modelica.Electrical.Analog.Basic.Inductor L(L=20e-3)
      annotation (Placement(transformation(extent={{-32,14},{-12,34}})));
    Modelica.Electrical.Analog.Sources.StepVoltage U
                                       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-66,2})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-76,-38},{-56,-18}})));
    Modelica.Mechanics.Rotational.Components.Inertia J(J=3e3)
      annotation (Placement(transformation(extent={{16,-10},{36,10}})));
    Modelica.Mechanics.Rotational.Components.Damper f(d=10)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={46,-10})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{36,-34},{56,-14}})));
  equation
    connect(K.p, L.n)          annotation (Line(
        points={{-6,10},{-6,24},{-12,24}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(K.n, ground.p)   annotation (Line(
        points={{-6,-10},{-6,-18}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(L.p, R.n)               annotation (Line(
        points={{-32,24},{-40,24}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(U.p, R.p)                   annotation (Line(
        points={{-66,12},{-66,24},{-60,24}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground1.p, U.n)            annotation (Line(
        points={{-66,-18},{-66,-8}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(K.flange, J.flange_a)               annotation (Line(
        points={{4,0},{16,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, f.flange_a)              annotation (Line(
        points={{46,-24},{46,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(J.flange_b, f.flange_b) annotation (Line(
        points={{36,0},{46,0}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end DCmotor;

  annotation (uses(Modelica(version="3.2.2")));
end Chap3_Submarine;
