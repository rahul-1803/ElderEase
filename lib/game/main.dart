import 'package:dementia/game/views/start_game_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Memory Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartGameScreen(),
    );
  }
}
