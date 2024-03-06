// File: ai_extensions.dart

// This is a designated area where the OpenAI model can add or modify code.
// Please refer to the README for detailed instructions.

import 'package:flutter/material.dart';

class GlowbyScreen extends StatelessWidget {
  // To enable the screen, set this value to true
  // If it is false, the screen won't be visible in the app
  static const enabled = true;

  // Change the title according to the assigned task
  // This will be the name of the screen in the app
  static const title = 'Sign Up Form'; // Updated title for the sign up form

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: new BoxConstraints(
          maxWidth: 360.0,
        ),
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  'https://source.unsplash.com/random/300x100?sig=signup',
                  width: double.infinity,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 24.0),
                Text(
                  'Sign Up for My App',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    // Add your Flutter code here to handle the form submission
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Thank you for signing up!'),
                        );
                      },
                    );
                  },
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 36),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
