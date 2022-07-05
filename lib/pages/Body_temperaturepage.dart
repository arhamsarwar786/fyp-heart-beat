import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BodyTemperature extends StatefulWidget {
  const BodyTemperature({Key? key, required this.title}) : super(key: key);
  final String? title;

  @override
  State<BodyTemperature> createState() => _BodyTemperatureState();
}

class _BodyTemperatureState extends State<BodyTemperature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SfRadialGauge(
              title: GaugeTitle(
                  text: "BodyTemperature Meter",
                  textStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent)),
              enableLoadingAnimation: true,
              animationDuration: 4500,
              axes: <RadialAxis>[
                RadialAxis(
                  ticksPosition: ElementsPosition.outside,
                  labelsPosition: ElementsPosition.outside,
                  minorTicksPerInterval: 5,
                  axisLineStyle: AxisLineStyle(
                    thicknessUnit: GaugeSizeUnit.factor,
                    thickness: 0.1,
                  ),
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: -60,
                      endValue: 120,
                      startWidth: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      endWidth: 0.1,
                      gradient: SweepGradient(
                        stops: <double>[0.2, 0.5, 0.75],
                        colors: <Color>[
                          Colors.green,
                          Colors.yellow,
                          Colors.red
                        ],
                      ),
                    )
                  ],
                  axisLabelStyle:
                      GaugeTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  radiusFactor: 0.97,
                  majorTickStyle: MajorTickStyle(
                      length: 0.1,
                      thickness: 2,
                      lengthUnit: GaugeSizeUnit.factor),
                  minorTickStyle: MinorTickStyle(
                      length: 0.05,
                      thickness: 1.5,
                      lengthUnit: GaugeSizeUnit.factor),
                  minimum: -60,
                  maximum: 120,
                  interval: 20,
                  startAngle: 115,
                  endAngle: 65,
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Text(
                          '°F',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        positionFactor: 0.8,
                        angle: 90),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: 31.5,
                      enableAnimation: true,
                      needleColor: Colors.black,
                      tailStyle: TailStyle(
                          length: 0.18,
                          width: 8,
                          color: Colors.black,
                          lengthUnit: GaugeSizeUnit.factor),
                      needleLength: 0.68,
                      needleStartWidth: 1,
                      needleEndWidth: 8,
                      knobStyle: KnobStyle(
                          knobRadius: 0.07,
                          color: Colors.white,
                          borderWidth: 0.05,
                          borderColor: Colors.black),
                      lengthUnit: GaugeSizeUnit.factor,
                    ),
                  ],
                ),
                RadialAxis(
                  // backgroundImage: const AssetImage('images/light_frame.png'),
                  minimum: -50,
                  maximum: 50,
                  interval: 10,
                  radiusFactor: 0.5,
                  showAxisLine: false,
                  labelOffset: 5,
                  useRangeColorForAxis: true,
                  axisLabelStyle: GaugeTextStyle(fontWeight: FontWeight.bold),
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: -50,
                        endValue: -20,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: Colors.green,
                        endWidth: 0.03,
                        startWidth: 0.03),
                    GaugeRange(
                        startValue: -20,
                        endValue: 20,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: Colors.yellow,
                        endWidth: 0.03,
                        startWidth: 0.03),
                    GaugeRange(
                        startValue: 20,
                        endValue: 50,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: Colors.red,
                        endWidth: 0.03,
                        startWidth: 0.03),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Text(
                          '°C',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        positionFactor: 0.8,
                        angle: 90)
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
