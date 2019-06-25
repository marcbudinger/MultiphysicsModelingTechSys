within ;
package Chap6_PowerOffBrake

  model MagneticCircuit
    Modelica.Magnetic.FluxTubes.Sources.ConstantMagneticPotentialDifference
      MagneticSource(V_m=477.71) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-42,-20})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal1_AxialFlux(
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892)
      annotation (Placement(transformation(extent={{-14,-30},{6,-10}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal4_RadialFlux(
      l(displayUnit="mm") = 0.002,
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData())
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={68,14})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal2_AxialFlux(
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892)
      annotation (Placement(transformation(extent={{-16,30},{4,50}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal3_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      l(displayUnit="mm") = 0.00578,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData())
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-66,12})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Air1_AxialFlux(
      l(displayUnit="mm") = 0.00025,
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      nonLinearPermeability=false,
      mu_rConst=1)
      annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Air2_AxialFlux(
      l(displayUnit="mm") = 0.00025,
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      nonLinearPermeability=false,
      mu_rConst=1)
      annotation (Placement(transformation(extent={{24,30},{44,50}})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground
      annotation (Placement(transformation(extent={{-34,-56},{-14,-36}})));
  equation
    connect(MagneticSource.port_n, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-32,-20},{-14,-20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Steal3_RadialFlux.port_p, MagneticSource.port_p) annotation (Line(
        points={{-66,2},{-66,-20},{-52,-20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Steal3_RadialFlux.port_n, Steal2_AxialFlux.port_p) annotation (Line(
        points={{-66,22},{-66,40},{-16,40}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air1_AxialFlux.port_p, Steal1_AxialFlux.port_n) annotation (Line(
        points={{24,-20},{6,-20}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air1_AxialFlux.port_n, Steal4_RadialFlux.port_p) annotation (Line(
        points={{44,-20},{68,-20},{68,4}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air2_AxialFlux.port_p, Steal2_AxialFlux.port_n) annotation (Line(
        points={{24,40},{4,40}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air2_AxialFlux.port_n, Steal4_RadialFlux.port_n) annotation (Line(
        points={{44,40},{68,40},{68,24}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(ground.port, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-24,-36},{-24,-20},{-14,-20}},
        color={255,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end MagneticCircuit;

  model ElectroMagneticCircuit
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal1_AxialFlux(
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892)
      annotation (Placement(transformation(extent={{-22,18},{-2,38}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal4_RadialFlux(
      l(displayUnit="mm") = 0.002,
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData())
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,54})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal2_AxialFlux(
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892)
      annotation (Placement(transformation(extent={{-24,70},{-4,90}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal3_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      l(displayUnit="mm") = 0.00578,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData())
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-74,52})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Air1_AxialFlux(
      l(displayUnit="mm") = 0.00025,
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      nonLinearPermeability=false,
      mu_rConst=1)
      annotation (Placement(transformation(extent={{14,18},{34,38}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Air2_AxialFlux(
      l(displayUnit="mm") = 0.00025,
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      nonLinearPermeability=false,
      mu_rConst=1)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground
      annotation (Placement(transformation(extent={{-38,-12},{-18,8}})));
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N=2836)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-52,18})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=142.49)
      annotation (Placement(transformation(extent={{-92,-2},{-72,18}})));
    Modelica.Electrical.Analog.Basic.Ground ground2
      annotation (Placement(transformation(extent={{-76,-64},{-56,-44}})));
    Modelica.Electrical.Analog.Sources.StepVoltage constantVoltage(
      V=24)         annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-94,-18})));
  equation
    connect(Steal3_RadialFlux.port_n, Steal2_AxialFlux.port_p) annotation (Line(
        points={{-74,62},{-74,80},{-24,80}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air1_AxialFlux.port_p, Steal1_AxialFlux.port_n) annotation (Line(
        points={{14,28},{-2,28}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air1_AxialFlux.port_n, Steal4_RadialFlux.port_p) annotation (Line(
        points={{34,28},{60,28},{60,44}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air2_AxialFlux.port_p, Steal2_AxialFlux.port_n) annotation (Line(
        points={{16,80},{-4,80}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(Air2_AxialFlux.port_n, Steal4_RadialFlux.port_n) annotation (Line(
        points={{36,80},{60,80},{60,64}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(ground.port, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-28,8},{-28,28},{-22,28}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(constantVoltage.p,resistor. p) annotation (Line(
        points={{-94,-8},{-94,8},{-92,8}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(resistor.n,converter. p) annotation (Line(
        points={{-72,8},{-58,8}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground2.p,constantVoltage. n) annotation (Line(
        points={{-66,-44},{-66,-28},{-94,-28}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.n,constantVoltage. n) annotation (Line(
        points={{-46,8},{-38,8},{-38,-28},{-94,-28}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.port_p, Steal3_RadialFlux.port_p) annotation (Line(
        points={{-58,28},{-68,28},{-68,42},{-74,42}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(converter.port_n, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-46,28},{-22,28}},
        color={255,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end ElectroMagneticCircuit;

  model EquivalentDC
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=142.49)
      annotation (Placement(transformation(extent={{-64,44},{-44,64}})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-86,-18},{-66,2}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=24)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-76,28})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L=6.612) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-26,32})));
  equation
    connect(constantVoltage.p, resistor.p) annotation (Line(
        points={{-76,38},{-76,54},{-64,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground1.p, constantVoltage.n) annotation (Line(
        points={{-76,2},{-76,18}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(inductor.p, resistor.n) annotation (Line(
        points={{-26,42},{-26,54},{-44,54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(inductor.n, constantVoltage.n) annotation (Line(
        points={{-26,22},{-26,8},{-76,8},{-76,18}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end EquivalentDC;

  model ElectroMagneticCircuit_Force
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal1_AxialFlux(
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892)
      annotation (Placement(transformation(extent={{-12,16},{8,36}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal4_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(),
      l(displayUnit="mm") = 0.00578) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,50})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal2_AxialFlux(
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892,
      material=
          Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.PureIron.VacoferS2())
      annotation (Placement(transformation(extent={{-24,66},{-4,86}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal3_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      l(displayUnit="mm") = 0.00578,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData())
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-74,52})));
    Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
      hollowCylinderAxialFlux(
      mu_r=1,
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      l(displayUnit="mm"))
      annotation (Placement(transformation(extent={{14,66},{34,86}})));
    Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
      hollowCylinderAxialFlux1(
      mu_r=1,
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      l(displayUnit="mm")) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={24,26})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N=2836)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-40,16})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=142.49)
      annotation (Placement(transformation(extent={{-82,-4},{-62,16}})));
    Modelica.Electrical.Analog.Basic.Ground ground2
      annotation (Placement(transformation(extent={{-104,-56},{-84,-36}})));
    Modelica.Electrical.Analog.Sources.StepVoltage constantVoltage(
      V=24)         annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-94,-12})));
    Modelica.Mechanics.Translational.Components.Fixed fixed(s0=0.00025)
      annotation (Placement(transformation(extent={{74,-30},{94,-10}})));
  equation
    connect(Steal3_RadialFlux.port_n, Steal2_AxialFlux.port_p) annotation (Line(
        points={{-74,62},{-74,76},{-24,76}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.port_p, Steal2_AxialFlux.port_n)
      annotation (Line(
        points={{14,76},{-4,76}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.port_n, Steal4_RadialFlux.port_n)
      annotation (Line(
        points={{34,76},{60,76},{60,60}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux1.port_p, Steal4_RadialFlux.port_p)
      annotation (Line(
        points={{34,26},{60,26},{60,40}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux1.port_n, Steal1_AxialFlux.port_n)
      annotation (Line(
        points={{14,26},{8,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.flange, hollowCylinderAxialFlux1.flange)
      annotation (Line(
        points={{24,86},{24,94},{84,94},{84,16},{24,16}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(constantVoltage.p, resistor.p) annotation (Line(
        points={{-94,-2},{-94,6},{-82,6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(resistor.n, converter.p) annotation (Line(
        points={{-62,6},{-46,6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground2.p, constantVoltage.n) annotation (Line(
        points={{-94,-36},{-94,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.n, constantVoltage.n) annotation (Line(
        points={{-34,6},{-34,-28},{-94,-28},{-94,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.port_p, Steal3_RadialFlux.port_p) annotation (Line(
        points={{-46,26},{-46,42},{-74,42}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(converter.port_n, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-34,26},{-12,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(ground1.port, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-20,10},{-20,26},{-12,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(fixed.flange, hollowCylinderAxialFlux1.flange) annotation (Line(
        points={{84,-20},{84,16},{24,16}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end ElectroMagneticCircuit_Force;

  model CompleteSystem
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal1_AxialFlux(
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892)
      annotation (Placement(transformation(extent={{-12,16},{8,36}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal4_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(),
      l(displayUnit="mm") = 0.00578) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,50})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal2_AxialFlux(
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892,
      material=
          Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.PureIron.VacoferS2())
      annotation (Placement(transformation(extent={{-12,66},{8,86}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal3_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      l(displayUnit="mm") = 0.00578,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData())
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-74,50})));
    Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
      hollowCylinderAxialFlux(
      mu_r=1,
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      l(displayUnit="mm"),
      dlBydx=1)
      annotation (Placement(transformation(extent={{14,66},{34,86}})));
    Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
      hollowCylinderAxialFlux1(
      mu_r=1,
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      l(displayUnit="mm"),
      dlBydx=1)            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={24,26})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N=2836)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-40,16})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=142)
      annotation (Placement(transformation(extent={{-76,-4},{-56,16}})));
    Modelica.Electrical.Analog.Basic.Ground ground2
      annotation (Placement(transformation(extent={{-98,-56},{-78,-36}})));
    Modelica.Electrical.Analog.Sources.StepVoltage constantVoltage(
      V=24, startTime=1,
      offset=0)     annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-88,-12})));
    Modelica.Mechanics.Translational.Components.Fixed fixed(s0=-10e-3)
                                                            annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-12,-42})));
    Modelica.Mechanics.Translational.Components.Spring spring(s_rel0=20e-3, c=
          250/(10e-3))
      annotation (Placement(transformation(extent={{-4,-52},{16,-32}})));
    Modelica.Mechanics.Translational.Components.Mass mass(m=0.1, s(start=
            0.25e-3))
      annotation (Placement(transformation(extent={{22,-52},{42,-32}})));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap(
      s_rel0=0,
      c=1e8,
      d=1e6) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={74,-42})));
    Modelica.Mechanics.Translational.Components.Fixed fixed1(s0=0.25e-3)
                                                            annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={88,-42})));
    Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor
      annotation (Placement(transformation(extent={{44,-50},{60,-34}})));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap1(
      s_rel0=0,
      c=1e8,
      d=1e6) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={6,-68})));
    Modelica.Mechanics.Translational.Components.Fixed fixed2(s0=0.1e-3)
                                                            annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,-68})));
  equation
    connect(Steal3_RadialFlux.port_n, Steal2_AxialFlux.port_p) annotation (Line(
        points={{-74,60},{-74,76},{-12,76}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.port_p, Steal2_AxialFlux.port_n)
      annotation (Line(
        points={{14,76},{8,76}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.port_n, Steal4_RadialFlux.port_n)
      annotation (Line(
        points={{34,76},{60,76},{60,60}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux1.port_p, Steal4_RadialFlux.port_p)
      annotation (Line(
        points={{34,26},{60,26},{60,40}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux1.port_n, Steal1_AxialFlux.port_n)
      annotation (Line(
        points={{14,26},{8,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.flange, hollowCylinderAxialFlux1.flange)
      annotation (Line(
        points={{24,86},{24,94},{84,94},{84,16},{24,16}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(constantVoltage.p, resistor.p) annotation (Line(
        points={{-88,-2},{-88,6},{-76,6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(resistor.n, converter.p) annotation (Line(
        points={{-56,6},{-46,6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground2.p, constantVoltage.n) annotation (Line(
        points={{-88,-36},{-88,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.n, constantVoltage.n) annotation (Line(
        points={{-34,6},{-34,-28},{-88,-28},{-88,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.port_p, Steal3_RadialFlux.port_p) annotation (Line(
        points={{-46,26},{-74,26},{-74,40}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(converter.port_n, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-34,26},{-12,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(ground1.port, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-20,10},{-20,26},{-12,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(fixed.flange, spring.flange_a) annotation (Line(
        points={{-12,-42},{-4,-42}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(mass.flange_a, spring.flange_b) annotation (Line(
        points={{22,-42},{16,-42}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(fixed1.flange, elastoGap.flange_b) annotation (Line(
        points={{88,-42},{84,-42}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(mass.flange_b, forceSensor.flange_a) annotation (Line(
        points={{42,-42},{44,-42}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(elastoGap.flange_a, forceSensor.flange_b) annotation (Line(
        points={{64,-42},{60,-42}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux1.flange, mass.flange_a) annotation (Line(
        points={{24,16},{24,-42},{22,-42}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(elastoGap1.flange_a, fixed2.flange) annotation (Line(
        points={{-4,-68},{-10,-68}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(elastoGap1.flange_b, mass.flange_a) annotation (Line(
        points={{16,-68},{22,-68},{22,-42}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end CompleteSystem;

  model ElectroMagnetTest
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal1_AxialFlux(
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892)
      annotation (Placement(transformation(extent={{-12,16},{8,36}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal4_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(),
      l(displayUnit="mm") = 0.00578) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,54})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux
      Steal2_AxialFlux(
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      nonLinearPermeability=false,
      mu_rConst=500,
      l(displayUnit="mm") = 0.01892,
      material=
          Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.PureIron.VacoferS2())
      annotation (Placement(transformation(extent={{-24,66},{-4,86}})));
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux
      Steal3_RadialFlux(
      r_i(displayUnit="mm") = 0.01328,
      r_o(displayUnit="mm") = 0.02589,
      l(displayUnit="mm") = 0.00578,
      nonLinearPermeability=false,
      mu_rConst=500,
      material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData())
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-74,52})));
    Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
      hollowCylinderAxialFlux(
      mu_r=1,
      r_i(displayUnit="mm") = 0.02589,
      r_o(displayUnit="mm") = 0.02812,
      l(displayUnit="mm"),
      dlBydx=-1)
      annotation (Placement(transformation(extent={{14,66},{34,86}})));
    Modelica.Magnetic.FluxTubes.Shapes.Force.HollowCylinderAxialFlux
      hollowCylinderAxialFlux1(
      mu_r=1,
      r_i(displayUnit="mm") = 0.0075,
      r_o(displayUnit="mm") = 0.01328,
      l(displayUnit="mm"),
      dlBydx=-1)           annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={24,26})));
    Modelica.Magnetic.FluxTubes.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N=2836)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-40,16})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R=142.49)
      annotation (Placement(transformation(extent={{-82,-4},{-62,16}})));
    Modelica.Electrical.Analog.Basic.Ground ground2
      annotation (Placement(transformation(extent={{-104,-56},{-84,-36}})));
    Modelica.Electrical.Analog.Sources.StepVoltage constantVoltage(
      V=24, startTime=1,
      offset=0)     annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-94,-12})));
    Modelica.Mechanics.Translational.Components.Fixed fixed(s0=0.25e-3)
      annotation (Placement(transformation(extent={{38,-36},{58,-16}})));
  equation
    connect(Steal3_RadialFlux.port_n, Steal2_AxialFlux.port_p) annotation (Line(
        points={{-74,62},{-74,76},{-24,76}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.port_p, Steal2_AxialFlux.port_n)
      annotation (Line(
        points={{14,76},{-4,76}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.port_n, Steal4_RadialFlux.port_n)
      annotation (Line(
        points={{34,76},{60,76},{60,64}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux1.port_p, Steal4_RadialFlux.port_p)
      annotation (Line(
        points={{34,26},{60,26},{60,44}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux1.port_n, Steal1_AxialFlux.port_n)
      annotation (Line(
        points={{14,26},{8,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(hollowCylinderAxialFlux.flange, hollowCylinderAxialFlux1.flange)
      annotation (Line(
        points={{24,86},{24,94},{84,94},{84,16},{24,16}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(constantVoltage.p, resistor.p) annotation (Line(
        points={{-94,-2},{-94,6},{-82,6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(resistor.n, converter.p) annotation (Line(
        points={{-62,6},{-46,6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground2.p, constantVoltage.n) annotation (Line(
        points={{-94,-36},{-94,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.n, constantVoltage.n) annotation (Line(
        points={{-34,6},{-34,-28},{-94,-28},{-94,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(converter.port_p, Steal3_RadialFlux.port_p) annotation (Line(
        points={{-46,26},{-46,26},{-76,26},{-76,26},{-76,26},{-76,42},{-74,42}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(converter.port_n, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-34,26},{-12,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(ground1.port, Steal1_AxialFlux.port_p) annotation (Line(
        points={{-20,10},{-20,26},{-12,26}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(fixed.flange, hollowCylinderAxialFlux1.flange) annotation (Line(
        points={{48,-26},{48,16},{24,16}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end ElectroMagnetTest;

  model SpringTest
    Modelica.Mechanics.Translational.Components.Fixed fixed1(s0=0.25e-3)
                                                            annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,0})));
    Modelica.Mechanics.Translational.Components.Spring spring(s_rel0=20e-3, c=
          250/(10e-3))
      annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
    Modelica.Mechanics.Translational.Components.Fixed fixed(s0=-10e-3)
                                                            annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-54,0})));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap(
      s_rel0=0,
      c=1e8,
      d=1e5) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={20,0})));
    Modelica.Mechanics.Translational.Components.Mass mass(m=0.1, s(start=0))
      annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
    Modelica.Mechanics.Translational.Components.ElastoGap elastoGap1(
      s_rel0=0,
      c=1e8,
      d=1e6) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-58})));
    Modelica.Mechanics.Translational.Components.Fixed fixed2(s0=0.05e-3)
                                                            annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-46,-58})));
  equation
    connect(fixed.flange, spring.flange_a) annotation (Line(
        points={{-54,0},{-46,0}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(elastoGap.flange_b, fixed1.flange) annotation (Line(
        points={{30,0},{50,0}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(mass.flange_b, elastoGap.flange_a) annotation (Line(
        points={{2,0},{10,0}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(spring.flange_b, mass.flange_a) annotation (Line(
        points={{-26,0},{-18,0}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(elastoGap1.flange_a, fixed2.flange) annotation (Line(
        points={{-40,-58},{-46,-58}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(elastoGap1.flange_b, mass.flange_a) annotation (Line(
        points={{-20,-58},{-20,0},{-18,0}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end SpringTest;
  annotation (uses(Modelica(version="3.2.2")));
end Chap6_PowerOffBrake;
