// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ScoreScreen extends StatelessWidget {
  final double bmiScore;
  final int age;
  String? bmiStatus;
  String? bmiInterpretation;
  Color? bmiStatusColor;

  ScoreScreen({Key? key, required this.bmiScore, required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Score"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Card(
          elevation: 12,
          shape: const RoundedRectangleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Your Score",
                style: TextStyle(fontSize: 30, color: Colors.brown),
              ),
              const SizedBox(
                height: 10,
              ),

              PrettyGauge(
                gaugeSize: 300,
                minValue: 10,
                maxValue: 50,
                segments: [
                  GaugeSegment('Severe undernourishment', 5.9, const Color.fromARGB(255, 166, 42, 232)),
                  GaugeSegment('Medium undernourishment', 1.0, const Color.fromARGB(255, 17, 2, 151)),
                  GaugeSegment('Slight undernourishment', 1.5, Colors.blue),
                  GaugeSegment('Normal nutrition state', 6.5, Colors.green), 
                  GaugeSegment('Overweight', 5.0, Colors.yellow),
                  GaugeSegment('Obesity', 10.0, Colors.orange),
                  GaugeSegment('Pathological Obesity', 10.1, Colors.red),
                ],
                valueWidget: Text(
                  bmiScore.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 40),
                ),
                currentValue: bmiScore.toDouble(),
                needleColor: Colors.brown,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                bmiStatus ?? '',
                style: TextStyle(fontSize: 20, color: bmiStatusColor ?? Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                bmiInterpretation ?? '',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Re-calculate"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Share.share("Your BMI is ${bmiScore.toStringAsFixed(1)} at age $age");
                    },
                    child: const Text("Share"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore < 16.0) {
      bmiStatus = "Severe undernourishment";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = const Color.fromARGB(255, 166, 42, 232);
    } else if (bmiScore >= 16.0 && bmiScore < 16.9) {
      bmiStatus = "Medium undernourishment";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Color.fromARGB(255, 17, 2, 151);
    } else if (bmiScore >= 17.0 && bmiScore < 18.4) {
      bmiStatus = "Slight undernourishment";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.blue;
    } else if (bmiScore >= 18.5 && bmiScore < 24.9) {
      bmiStatus = "Normal nutrition state";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (bmiScore >= 25.0 && bmiScore < 29.9) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.yellow;
    } else if (bmiScore >= 30.0 && bmiScore < 39.9) {
      bmiStatus = "Obesity";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore > 40.0) {
      bmiStatus = "Pathological Obesity";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.red;
    }
  }
}
