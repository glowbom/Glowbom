// File: ai_extensions.dart

// This is a designated area where the OpenAI model can add or modify code.
// Please refer to the README for detailed instructions.

import 'package:flutter/material.dart';
import 'dart:math';

class InspirationScreen extends StatefulWidget {
  const InspirationScreen({Key? key}) : super(key: key);

  @override
  _InspirationScreenState createState() => _InspirationScreenState();
}

class _InspirationScreenState extends State<InspirationScreen> {
  final _quotes = [
    "The only way to do great work is to love what you do.",
    "Believe you can and you're halfway there.",
    "Don’t wait. The time will never be just right.",
    "Everything you can imagine is real.",
    "Whatever you are, be a good one.",
  ];

  String? _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = _quotes[Random().nextInt(_quotes.length)];
  }

  void _getRandomQuote() {
    setState(() {
      _currentQuote = _quotes[Random().nextInt(_quotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_currentQuote != null)
                Text(
                  _currentQuote!,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _getRandomQuote,
                child: const Text('Get Inspiration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlowbyScreen extends StatelessWidget {
  static const enabled = true;
  static const title = 'Inspiration';

  const GlowbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InspirationScreen();
  }
}
