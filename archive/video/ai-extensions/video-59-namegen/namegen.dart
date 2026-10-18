import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Generator App',
      home: NameGenerator(),
    );
  }
}

class NameGenerator extends StatefulWidget {
  @override
  _NameGeneratorState createState() => _NameGeneratorState();
}

class _NameGeneratorState extends State<NameGenerator> {
  final List<String> _names = [
    "Innova",
    "Creativio",
    "IdeaStorm",
    "Conceptualize",
    "Brainwave"
  ];
  List<String> _generatedNames = [];
  final _random = Random();

  void _generateNames() {
    setState(() {
      _generatedNames =
          List.generate(5, (_) => _names[_random.nextInt(_names.length)]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter idea',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateNames,
              child: Text('Generate'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _generatedNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_generatedNames[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
