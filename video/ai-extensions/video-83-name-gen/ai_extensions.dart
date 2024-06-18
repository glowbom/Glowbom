// File: ai_extensions.dart

// This is a designated area where the OpenAI model can add or modify code.
// Please refer to the README for detailed instructions.

import 'package:flutter/material.dart';
import 'dart:math';

class GlowbyScreen extends StatelessWidget {
  // To enable the screen, set this value to true
  // If it is false, the screen won't be visible in the app
  static const enabled = true;

  // Change the title according to the assigned task
  // This will be the name of the screen in the app
  static const title = 'Name Generator';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 360.0,
        ),
        child: NameGenerator(),
      ),
    );
  }
}

class NameGenerator extends StatefulWidget {
  @override
  _NameGeneratorState createState() => _NameGeneratorState();
}

class _NameGeneratorState extends State<NameGenerator> {
  final Map<String, List<String>> names = {
    'character': ["Aragorn", "Hermione", "Frodo", "Daenerys", "Gandalf"],
    'business': [
      "TechCorp",
      "InnovateX",
      "EcoSolutions",
      "HealthPlus",
      "EduWorld"
    ],
    'product': [
      "SmartWidget",
      "EcoBottle",
      "HealthTracker",
      "EduApp",
      "TechGadget"
    ],
    'username': [
      "CoolCat123",
      "TechGuru",
      "NatureLover",
      "HealthFanatic",
      "EduMaster"
    ]
  };

  String selectedCategory = 'character';
  String result = 'Result';

  void generateName() {
    final random = Random();
    final randomName = names[selectedCategory]![
        random.nextInt(names[selectedCategory]!.length)];
    setState(() {
      result = randomName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Name Gen',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
            items: <String>['character', 'business', 'product', 'username']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              result,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: generateName,
            child: Text('Gen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.0),
              textStyle: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
