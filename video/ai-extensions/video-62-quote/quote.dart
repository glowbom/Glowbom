import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(QuoteApp());

class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuotePage(),
    );
  }
}

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  List<Quote> quotes = [
    Quote(
        text: "Be yourself; everyone else is already taken.",
        author: "Oscar Wilde"),
    Quote(
        text:
            "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.",
        author: "Albert Einstein"),
    Quote(text: "So many books, so little time.", author: "Frank Zappa"),
    // Add more quotes as needed
  ];

  Quote get randomQuote => quotes[Random().nextInt(quotes.length)];

  Quote currentQuote;

  @override
  void initState() {
    super.initState();
    currentQuote = randomQuote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quote'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '"${currentQuote.text}"',
                style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              '- ${currentQuote.author}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 40.0),
            FlatButton(
              onPressed: () {
                setState(() {
                  currentQuote = randomQuote;
                });
              },
              color: Colors.blue,
              child: Text(
                'Show Another Quote',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Quote {
  String text;
  String author;

  Quote({this.text, this.author});
}
