import 'package:flutter/material.dart';

// GlowbomScreen for Two Sum
class GlowbyScreen extends StatelessWidget {
  // Enabling the screen
  static const enabled = true;
  // Title for the screen
  static const title = 'Two Sum';

  final List<int> nums;
  final int target;

  // Providing default values for nums and target
  GlowbyScreen({this.nums = const [2, 7, 11, 15], this.target = 9});

  List<int> twoSum() {
    final Map<int, int> numMap = {};

    for (int i = 0; i < nums.length; i++) {
      int difference = target - nums[i];
      if (numMap.containsKey(difference)) {
        return [numMap[difference]!, i];
      }
      numMap[nums[i]] = i;
    }
    throw Exception('No solution found!');
  }

  @override
  Widget build(BuildContext context) {
    List<int> result;
    try {
      result = twoSum();
    } catch (e) {
      return Center(child: Text("Error: $e"));
    }
    return Center(
      child: Container(
        width: 360.0,
        child: Text('Indices: ${result[0]}, ${result[1]}'),
      ),
    );
  }
}
