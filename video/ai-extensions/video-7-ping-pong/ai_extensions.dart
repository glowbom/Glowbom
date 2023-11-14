import 'package:flutter/material.dart';
import 'dart:async';

class GlowbyScreen extends StatelessWidget {
  static const enabled = true;
  static const title = 'Ping Pong Game';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 360.0,
        ),
        child: PingPongGame(),
      ),
    );
  }
}

class PingPongGame extends StatefulWidget {
  @override
  _PingPongGameState createState() => _PingPongGameState();
}

class _PingPongGameState extends State<PingPongGame> {
  static const double maxWidth = 360.0; // Define maxWidth as a static constant
  double paddleWidth = 100.0;
  double paddleHeight = 20.0;
  double ballSize = 20.0;
  double posX = 0.0;
  double posY = 0.0;
  double velX = 5.0;
  double velY = 5.0;
  double player1Y = 0.0;
  double player2Y = 0.0;
  int score1 = 0;
  int score2 = 0;
  Timer? gameTimer;
  bool gameStarted = false;

  @override
  void initState() {
    super.initState();
    posX = posY = 0.0;
    player1Y = player2Y = 0.0;
  }

  void startGame() {
    if (!gameStarted) {
      gameTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
        updateState();
      });
      setState(() {
        gameStarted = true;
      });
    }
  }

  void updateState() {
    if (!mounted || !gameStarted) return;

    setState(() {
      posX += velX;
      posY += velY;

      // Collision detection with walls
      if (posX <= 0 || posX >= maxWidth - ballSize) {
        velX = -velX;
      }
      if (posY <= 0 || posY >= MediaQuery.of(context).size.height - ballSize) {
        velY = -velY;
      }

      // Collision detection with paddles
      if ((posY <= paddleHeight &&
              posX >= player2Y &&
              posX <= player2Y + paddleWidth) ||
          (posY >=
                  MediaQuery.of(context).size.height -
                      paddleHeight -
                      ballSize &&
              posX >= player1Y &&
              posX <= player1Y + paddleWidth)) {
        velY = -velY;
      }

      // Score updating
      if (posY <= 0) {
        score2++;
        resetBall();
      } else if (posY >= MediaQuery.of(context).size.height - ballSize) {
        score1++;
        resetBall();
      }
    });
  }

  void resetBall() {
    setState(() {
      posX = maxWidth / 2 - ballSize / 2;
      posY = MediaQuery.of(context).size.height / 2 - ballSize / 2;
      velX = 5;
      velY = -5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              player1Y = details.localPosition.dx - paddleWidth / 2;
              player2Y = details.localPosition.dx - paddleWidth / 2;
            });
          },
          child: MouseRegion(
            onHover: (event) {
              setState(() {
                player1Y = event.localPosition.dx - paddleWidth / 2;
                player2Y = event.localPosition.dx - paddleWidth / 2;
              });
            },
            child: Stack(
              children: [
                // Ball
                Positioned(
                  left: posX,
                  top: posY,
                  child: Container(
                    width: ballSize,
                    height: ballSize,
                    decoration: BoxDecoration(
                      color: Colors.yellow, // Changed for visibility
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Player 1 Paddle
                Positioned(
                  bottom: 0,
                  left: player1Y,
                  child: Container(
                    width: paddleWidth,
                    height: paddleHeight,
                    color: Colors.green,
                  ),
                ),
                // Player 2 Paddle
                Positioned(
                  top: 0,
                  left: player2Y,
                  child: Container(
                    width: paddleWidth,
                    height: paddleHeight,
                    color: Colors.red,
                  ),
                ),
                // Score Display
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 50,
                  right: 20,
                  child: Text("Player 1: $score1",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 50,
                  left: 20,
                  child: Text("Player 2: $score2",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
        if (!gameStarted)
          Center(
            child: ElevatedButton(
              onPressed: startGame,
              child: Text('Start Game'),
            ),
          ),
      ],
    );
  }
}
