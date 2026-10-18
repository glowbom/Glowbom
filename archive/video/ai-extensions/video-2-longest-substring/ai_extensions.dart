// File: ai_extensions.dart

// This is a designated area where the OpenAI model can add or modify code.
// Please refer to the README for detailed instructions.

import 'package:flutter/material.dart';
import 'dart:math';

class LongestSubstringWidget extends StatefulWidget {
  @override
  _LongestSubstringWidgetState createState() => _LongestSubstringWidgetState();
}

class _LongestSubstringWidgetState extends State<LongestSubstringWidget> {
  final TextEditingController controller = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter string',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            String inputString = controller.text;
            int maxLength =
                longestSubstringWithoutRepeatingCharacters(inputString);
            setState(() {
              result =
                  'The length of the longest substring without repeating characters is $maxLength.';
            });
          },
          child: Text('Calculate'),
        ),
        Text(result),
      ],
    );
  }

  int longestSubstringWithoutRepeatingCharacters(String s) {
    int start = 0, maxLength = 0;
    Map<String, int> map = {};

    for (int end = 0; end < s.length; end++) {
      String endChar = s[end];

      if (map.containsKey(endChar)) {
        start = max(start, map[endChar]! + 1);
      }

      map[endChar] = end;
      maxLength = max(maxLength, end - start + 1);
    }

    return maxLength;
  }
}

class GlowbyScreen extends StatelessWidget {
  // To enable the screen, set this value to true
  // If it is false, the screen won't be visible in the app
  static const enabled = true;

  // Change the title according to the assigned task
  // This will be the name of the screen in the app
  static const title =
      'Longest Substring'; // Update the title as per user request

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: new BoxConstraints(
          maxWidth: 360.0,
        ),
        child: LongestSubstringWidget(),
      ),
    );
  }
}
