import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';

class HeartRatePage extends StatefulWidget {
  HeartRatePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HeartRatePage> createState() => _HeartRatePageState();
}

class _HeartRatePageState extends State<HeartRatePage> {
  
  List<SensorValue> data = [];

  /// variable to store measured BPM value
  int bpmValue = 0;

  bool isBPMEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart BPM Demo'),
      ),
      body: Column(
        children: [
          isBPMEnabled
              ? HeartBPMDialog(
                  context: context,
                  onRawData: (value) {
                    setState(() {
                      // add raw data points to the list
                      // with a maximum length of 100
                      if (data.length == 100) data.removeAt(0);
                      data.add(value);
                    });
                  },
                  onBPM: (value) => setState(() {
                    bpmValue = value;
                  }),
                )
              : const SizedBox(),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.favorite_rounded),
              label: Text(
                  isBPMEnabled ? "Stop measurement" : "Measure Heart Rate"),
              onPressed: () => setState(() => isBPMEnabled = !isBPMEnabled),
            ),
          ),
        ],
      ),
    );
  }
}
