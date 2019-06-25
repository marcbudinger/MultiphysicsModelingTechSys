within ;
package Chap6_Steering "Car steering"
  package Steering_components "Specific components of steering example"

    model SteeringWheel "Volant (Inertie et source de position)"
      Modelica.Mechanics.Rotational.Sources.Position position(
        exact=false,
        f_crit=50,
        w(start=0),
        a(start=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,46})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.023)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-42})));
      Modelica.Blocks.Interfaces.RealInput phi_ref1
        "Reference angle of flange with respect to support as input signal"
        annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,100})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a1
        "Left flange of shaft"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(d=0, c=
           10000)
               annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-2})));
    equation
      connect(position.phi_ref, phi_ref1) annotation (Line(
          points={{2.20436e-015,58},{2.20436e-015,67},{0,67},{0,100}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(inertia.flange_a, flange_a1) annotation (Line(
          points={{-6.12323e-016,-52},{0,-52},{0,-100}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(position.flange, springDamper.flange_b) annotation (Line(
          points={{-1.83697e-015,36},{6.12323e-016,36},{6.12323e-016,8}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper.flange_a, inertia.flange_b) annotation (Line(
          points={{-6.12323e-016,-12},{6.12323e-016,-12},{6.12323e-016,-32}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{
                -100,-100},{100,100}}),
                          graphics), Icon(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-120,46},{80,-50}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-106,36},{64,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-30,36},{-14,-40}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-106,-2},{66,-12}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-30,-6},{-10,-88},{6,-88},{-16,-6},{-30,-6}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.VerticalCylinder,
              lineThickness=0.5)}));
    end SteeringWheel;

    model Tire_init "Modele du pneu"

      import SI = Modelica.SIunits;

      parameter SI.RotationalSpringConstant K=3000
        "Raideur du pneu (en rotation)";
      parameter SI.RotationalDampingConstant f=28
        "Amortissment du pneu (en rotation)";
      parameter SI.Torque T=80 "Couple statique de frottement pneu/sol";
      parameter SI.Inertia J=1 "Inertie roue (jante)";
      parameter SI.Inertia Jp=0.1 "Inertie pneu (bande de roulement)";

      Modelica.Mechanics.Rotational.Components.BearingFriction
        bearingFriction(
          tau_pos=[0,T], peak=1)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={2,-58})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(c=K, d=f)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={2,-2})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia_jante(J=J)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={2,28})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia_pneu(J=Jp)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={2,-30})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1
                                              "Right flange of shaft" annotation (
          Placement(transformation(extent={{-70,-10},{-50,10}}), iconTransformation(
              extent={{-70,-10},{-50,10}})));
    equation
      connect(inertia_jante.flange_a, springDamper.flange_b) annotation (Line(
          points={{2,18},{2,8}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia_pneu.flange_b, springDamper.flange_a) annotation (Line(
          points={{2,-20},{2,-12}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia_pneu.flange_a, bearingFriction.flange_a) annotation (Line(
          points={{2,-40},{2,-48}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia_jante.flange_b, flange_b1) annotation (Line(points={{2,38},{2,
              60},{-80,60},{-80,0},{-60,0}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-40,80},{60,-80}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,100},{60,62}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-62},{68,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,40},{-60,-44}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end Tire_init;

    model RackPinion2Ports

        parameter Real ratio=1/0.01
                                "Transmission ratio (flange_a.phi/flange_b.s)";

      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_R annotation (
          Placement(transformation(extent={{-9,90},{11,110}}), iconTransformation(
              extent={{-9,90},{11,110}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a flange_Tg annotation (
          Placement(transformation(extent={{-100,-70},{-80,-50}}),
                                                                iconTransformation(
              extent={{-100,-70},{-80,-50}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_a flange_Td annotation (
          Placement(transformation(extent={{80,-70},{100,-50}}),
                                                              iconTransformation(
              extent={{80,-70},{100,-50}})));

      Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=
            ratio) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,32})));
    equation

      connect(idealGearR2T.flangeR, flange_R)
        annotation (Line(points={{0,42},{0,72},{0,100},{1,100}}, color={0,0,0}));
      connect(idealGearR2T.flangeT, flange_Tg)
        annotation (Line(points={{0,22},{0,-60},{-90,-60}}, color={0,127,0}));
      connect(idealGearR2T.flangeT, flange_Td)
        annotation (Line(points={{0,22},{0,-60},{90,-60}}, color={0,127,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
        Rectangle(origin={1.333,264},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-233.3333,-10.0},{-163.3333,10.0}},
              rotation=90),
        Rectangle(origin={-17.778,10},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          extent={{-82.222,-80},{117.78,-60}}),
        Polygon(origin={4.875,-40},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          points={{-84.375,-10.0},{-79.375,10.0},{-69.375,10.0},{-64.375,-10.0},{-54.375,-10.0},{-49.375,10.0},{-39.375,10.0},{-34.375,-10.0},{-24.375,-10.0},{-19.375,10.0},{-9.375,10.0},{-4.375,-10.0},{5.625,-10.0},{10.625,10.0},{20.625,10.0},{25.625,-10.0},{35.625,-10.0},{40.625,10.0},{50.625,10.0},{55.625,-10.0},{65.625,-10.0},{70.625,10.0},{78.125,10.0},{78.125,-10.0}}),
        Polygon(origin={2,10},
          rotation=55.0,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-5.0,45.0},{-10.0,10.0},{-45.0,5.0},{-45.0,-5.0},{-10.0,-10.0},{-5.0,-45.0},{5.0,-45.0},{10.0,-10.0},{45.0,-5.0},{45.0,5.0},{10.0,10.0},{5.0,45.0}}),
        Polygon(origin={2,10},
          rotation=10.0,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-5.0,45.0},{-10.0,10.0},{-45.0,5.0},{-45.0,-5.0},{-10.0,-10.0},{-5.0,-45.0},{5.0,-45.0},{10.0,-10.0},{45.0,-5.0},{45.0,5.0},{10.0,10.0},{5.0,45.0}})}));
    end RackPinion2Ports;

    model Bielette_init

      parameter Modelica.SIunits.Length b_levier=0.1 "bras de levier lineaire";

      Modelica.Mechanics.Translational.Interfaces.Flange_a flange_x annotation (
          Placement(transformation(extent={{-110,70},{-90,90}}), iconTransformation(
              extent={{-110,70},{-90,90}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_teta
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

      Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=1/
            b_levier)
        annotation (Placement(transformation(extent={{12,12},{-8,32}})));
    equation

      connect(idealGearR2T.flangeR, flange_teta)
        annotation (Line(points={{12,22},{56,22},{56,0},{100,0}}, color={0,0,0}));
      connect(idealGearR2T.flangeT, flange_x) annotation (Line(points={{-8,22},{-54,
              22},{-54,80},{-100,80}}, color={0,127,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Line(
              points={{-86,80},{40,60},{100,0}},
              color={0,0,0}),
            Ellipse(extent={{36,64},{44,56}}, lineColor={0,0,0}),
            Ellipse(extent={{-90,84},{-82,76}},
                                              lineColor={0,0,0})}), Diagram(
            graphics={
            Ellipse(extent={{-96,84},{-88,76}},
                                              lineColor={0,0,255})}));
    end Bielette_init;

    model Bielette_final

      parameter Modelica.SIunits.Length L = 35.6e-2 "Longueur bielle L";
      parameter Modelica.SIunits.Length R = 12e-2 "Longueur bielle R";
      parameter Modelica.SIunits.Length H = 14e-2 "Entre-axe port X - Teta";
      parameter Modelica.SIunits.Length D = 604e-3/2 "Demi cremaillere";
      parameter Modelica.SIunits.Length F = 1357e-3/2 "Demi voie";
      parameter Boolean RightTire = true "Choix de la roue";

      Modelica.SIunits.Position x "Position du port translation";
      Modelica.SIunits.Angle teta "Position du  port rotation";
      Modelica.SIunits.Length b_levier "bras de levier non lineaire";

      Modelica.Mechanics.Translational.Interfaces.Flange_a flange_x annotation (
          Placement(transformation(extent={{-110,70},{-90,90}}), iconTransformation(
              extent={{-110,70},{-90,90}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_teta
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

      Modelica.SIunits.Angle teta_i "Teta angle for x=F";

    equation
      x=D+R*sin(teta)+sqrt(L^2-(H-R*cos(teta))^2);
      b_levier=R*cos(teta)-R*sin(teta)*(H-R*cos(teta))/sqrt(L^2-(H-R*cos(teta))^2);

      F=D+R*sin(teta_i)+sqrt(L^2-(H-R*cos(teta_i))^2);

      flange_teta.tau = -b_levier * flange_x.f;

      if (RightTire==true) then
      flange_x.s=(F-x);
      flange_teta.phi = teta_i-teta;
      else
      flange_x.s=-(F-x);
      flange_teta.phi = -teta_i+teta;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Line(
              points={{-86,80},{40,60},{100,0}},
              color={0,0,0}),
            Ellipse(extent={{36,64},{44,56}}, lineColor={0,0,0}),
            Ellipse(extent={{-90,84},{-82,76}},
                                              lineColor={0,0,0})}), Diagram(
            graphics={
            Text(
              extent={{42,32},{62,14}},
              lineColor={0,0,255},
              textString="R"),
            Line(
              points={{80,0},{80,80}},
              color={0,0,255},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.Filled}),
            Ellipse(extent={{36,64},{44,56}}, lineColor={0,0,255}),
            Text(
              extent={{-36,90},{-16,72}},
              lineColor={0,0,255},
              textString="L"),
            Line(
              points={{100,-20},{-100,-20}},
              color={0,0,255},
              smooth=Smooth.None,
              arrow={Arrow.Filled,Arrow.Filled}),
            Text(
              extent={{-10,-24},{14,-48}},
              lineColor={0,0,255},
              textString="F"),
            Line(
              points={{-92,80},{40,60},{100,0}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{76,56},{100,32}},
              lineColor={0,0,255},
              textString="H"),
            Ellipse(extent={{-96,84},{-88,76}},
                                              lineColor={0,0,255})}));
    end Bielette_final;

    model Tire_final "Modele du pneu"

      import SI = Modelica.SIunits;

      parameter SI.RotationalSpringConstant K=3000
        "Raideur du pneu (en rotation)";
      parameter SI.RotationalDampingConstant f=28
        "Amortissment du pneu (en rotation)";
      parameter SI.Torque T=80 "Couple statique de frottement pneu/sol";
      parameter SI.Inertia J=1 "Inertie roue (jante)";
      parameter SI.Inertia Jp=0.1 "Inertie pneu (bande de roulement)";
        parameter SI.RotationalSpringConstant Kgr=7.95
        "Spring constant equivalent to gravity effect";

      Modelica.Mechanics.Rotational.Components.Spring spring(c=Kgr) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,30})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{-50,2},{-30,22}})));
      Modelica.Mechanics.Rotational.Components.BearingFriction
        bearingFriction(
          tau_pos=[0,T], peak=1)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={2,-58})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(c=K, d=f)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={2,-2})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia_jante(J=J)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={2,28})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia_pneu(J=Jp)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={2,-30})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1
                                              "Right flange of shaft" annotation (
          Placement(transformation(extent={{-70,-10},{-50,10}}), iconTransformation(
              extent={{-70,-10},{-50,10}})));
    equation
      connect(inertia_jante.flange_a, springDamper.flange_b) annotation (Line(
          points={{2,18},{2,8}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia_pneu.flange_b, springDamper.flange_a) annotation (Line(
          points={{2,-20},{2,-12}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia_pneu.flange_a, bearingFriction.flange_a) annotation (Line(
          points={{2,-40},{2,-48}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spring.flange_b, fixed.flange) annotation (Line(
          points={{-40,20},{-40,12}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia_jante.flange_b, flange_b1) annotation (Line(points={{2,38},{2,
              60},{-80,60},{-80,0},{-60,0}}, color={0,0,0}));
      connect(spring.flange_a, flange_b1) annotation (Line(points={{-40,40},{-40,60},
              {-80,60},{-80,0},{-60,0}}, color={0,0,0}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-40,80},{60,-80}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,100},{60,62}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-46,-62},{68,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,40},{-60,-44}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end Tire_final;
  end Steering_components;

  model Steering_mission

    Modelica.Blocks.Sources.Sine sine(
      freqHz=1/16,
      amplitude=2*3.14,
      phase=0)
      annotation (Placement(transformation(extent={{-70,48},{-50,68}})));
    Steering_components.SteeringWheel steeringWheel
      annotation (Placement(transformation(extent={{2,34},{22,54}})));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={12,16})));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
      annotation (Placement(transformation(extent={{26,16},{46,36}})));
    Steering_components.Tire_init tire_r
      annotation (Placement(transformation(extent={{54,-36},{74,-16}})));
    Steering_components.Tire_init tire_r1
      annotation (Placement(transformation(extent={{-26,-36},{-46,-16}})));
    Steering_components.Bielette_init bielette_init
      annotation (Placement(transformation(extent={{34,-36},{54,-16}})));
    Steering_components.Bielette_init bielette_init1
      annotation (Placement(transformation(extent={{-6,-36},{-26,-16}})));
    Steering_components.RackPinion2Ports rackPinion2Ports
      annotation (Placement(transformation(extent={{2,-22},{22,-2}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=10, D=1)
      annotation (Placement(transformation(extent={{-34,48},{-14,68}})));
  equation
    connect(steeringWheel.flange_a1, torqueSensor.flange_a) annotation (Line(
          points={{12,34},{12,26}},                color={0,0,0}));
    connect(torqueSensor.flange_a, angleSensor.flange)
      annotation (Line(points={{12,26},{26,26}},          color={0,0,0}));
    connect(tire_r.flange_b1, bielette_init.flange_teta)
      annotation (Line(points={{58,-26},{54,-26}}, color={0,0,0}));
    connect(tire_r1.flange_b1, bielette_init1.flange_teta)
      annotation (Line(points={{-30,-26},{-26,-26}}, color={0,0,0}));
    connect(bielette_init1.flange_x, rackPinion2Ports.flange_Tg)
      annotation (Line(points={{-6,-18},{3,-18}}, color={0,127,0}));
    connect(bielette_init.flange_x, rackPinion2Ports.flange_Td)
      annotation (Line(points={{34,-18},{21,-18}}, color={0,127,0}));
    connect(rackPinion2Ports.flange_R, torqueSensor.flange_b)
      annotation (Line(points={{12.1,-2},{12,-2},{12,6}}, color={0,0,0}));
    connect(secondOrder.u, sine.y)
      annotation (Line(points={{-36,58},{-49,58}}, color={0,0,127}));
    connect(secondOrder.y, steeringWheel.phi_ref1)
      annotation (Line(points={{-13,58},{12,58},{12,54}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})));
  end Steering_mission;

  model Steering_mission_G

    Steering_components.RackPinion2Ports
                                    idealGearR2T(ratio=1/0.01)   annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,-10})));
    Modelica.Blocks.Sources.Sine sine(
      phase=0,
      amplitude=2*3.14,
      freqHz=1/16)
      annotation (Placement(transformation(extent={{-76,68},{-56,88}})));
    Steering_components.SteeringWheel steeringWheel
      annotation (Placement(transformation(extent={{-10,42},{10,62}})));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
      annotation (Placement(transformation(extent={{12,20},{32,40}})));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,20})));
    Steering_components.Tire_final tire_r1(T=80, Kgr=25)
      annotation (Placement(transformation(extent={{44,-34},{64,-14}})));
    Steering_components.Bielette_init
                                 bielette_init
      annotation (Placement(transformation(extent={{24,-34},{44,-14}})));
    Steering_components.Bielette_init
                                 bielette_init1
      annotation (Placement(transformation(extent={{-20,-34},{-40,-14}})));
    Steering_components.Tire_final tire_r2
      annotation (Placement(transformation(extent={{-40,-34},{-60,-14}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=10, D=1)
      annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
  equation
    connect(torqueSensor.flange_a, steeringWheel.flange_a1) annotation (Line(
          points={{1.77636e-15,30},{1.77636e-15,36},{0,36},{0,42}}, color={0,0,
            0}));
    connect(torqueSensor.flange_b, idealGearR2T.flange_R) annotation (Line(
          points={{-1.77636e-15,10},{0,10},{0,0},{0.1,0}}, color={0,0,0}));
    connect(torqueSensor.flange_a, angleSensor.flange)
      annotation (Line(points={{1.77636e-15,30},{12,30}}, color={0,0,0}));
    connect(idealGearR2T.flange_Td, bielette_init.flange_x)
      annotation (Line(points={{9,-16},{24,-16}}, color={0,127,0}));
    connect(tire_r1.flange_b1, bielette_init.flange_teta)
      annotation (Line(points={{48,-24},{44,-24}}, color={0,0,0}));
    connect(idealGearR2T.flange_Tg, bielette_init1.flange_x)
      annotation (Line(points={{-9,-16},{-20,-16}}, color={0,127,0}));
    connect(bielette_init1.flange_teta, tire_r2.flange_b1)
      annotation (Line(points={{-40,-24},{-44,-24}}, color={0,0,0}));
    connect(secondOrder.y, steeringWheel.phi_ref1)
      annotation (Line(points={{-17,78},{0,78},{0,62}}, color={0,0,127}));
    connect(secondOrder.u, sine.y)
      annotation (Line(points={{-40,78},{-55,78}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})));
  end Steering_mission_G;

  model Steering_mission_GNL

    Steering_components.RackPinion2Ports
                                    idealGearR2T(ratio=1/0.01)   annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,-10})));
    Modelica.Blocks.Sources.Sine sine(
      phase=0,
      amplitude=2*3.14,
      freqHz=1/16)
      annotation (Placement(transformation(extent={{-76,68},{-56,88}})));
    Steering_components.SteeringWheel steeringWheel
      annotation (Placement(transformation(extent={{-10,42},{10,62}})));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
      annotation (Placement(transformation(extent={{12,20},{32,40}})));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,20})));
    Steering_components.Tire_final tire_r1
      annotation (Placement(transformation(extent={{48,-34},{68,-14}})));
    Steering_components.Bielette_final
                                 bielette_final
      annotation (Placement(transformation(extent={{24,-34},{44,-14}})));
    Steering_components.Bielette_final
                                 bielette_final1(RightTire=false)
      annotation (Placement(transformation(extent={{-20,-34},{-40,-14}})));
    Steering_components.Tire_final tire_r2
      annotation (Placement(transformation(extent={{-44,-34},{-64,-14}})));
    Modelica.Blocks.Continuous.SecondOrder secondOrder(w=10, D=1)
      annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
  equation
    connect(torqueSensor.flange_a, steeringWheel.flange_a1) annotation (Line(
          points={{1.77636e-15,30},{1.77636e-15,36},{0,36},{0,42}}, color={0,0,
            0}));
    connect(torqueSensor.flange_b, idealGearR2T.flange_R) annotation (Line(
          points={{-1.77636e-15,10},{0,10},{0,0},{0.1,0}}, color={0,0,0}));
    connect(torqueSensor.flange_a, angleSensor.flange)
      annotation (Line(points={{1.77636e-15,30},{12,30}}, color={0,0,0}));
    connect(idealGearR2T.flange_Td, bielette_final.flange_x)
      annotation (Line(points={{9,-16},{24,-16}}, color={0,127,0}));
    connect(idealGearR2T.flange_Tg, bielette_final1.flange_x)
      annotation (Line(points={{-9,-16},{-20,-16}}, color={0,127,0}));
    connect(secondOrder.y, steeringWheel.phi_ref1)
      annotation (Line(points={{-17,78},{0,78},{0,62}}, color={0,0,127}));
    connect(secondOrder.u, sine.y)
      annotation (Line(points={{-40,78},{-55,78}}, color={0,0,127}));
    connect(bielette_final.flange_teta, tire_r1.flange_b1)
      annotation (Line(points={{44,-24},{52,-24}}, color={0,0,0}));
    connect(bielette_final1.flange_teta, tire_r2.flange_b1)
      annotation (Line(points={{-40,-24},{-48,-24}}, color={0,0,0}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})));
  end Steering_mission_GNL;
  annotation (uses(Modelica(version="3.2.2")));
end Chap6_Steering;
