import 'package:dementia/game/views/level1_screen.dart';
import 'package:dementia/game/views/level2_screen.dart';
import 'package:dementia/game/views/level3_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class StartGameScreen extends StatefulWidget {
  const StartGameScreen({super.key});

  @override
  State<StartGameScreen> createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Flutter Memory Game",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          LottieBuilder.asset(
            "assets/brain_animation.json",
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Level1Screen(),
                ),
              );
            },
            child: const Text("Level 1"),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Level2Screen(),
                ),
              );
            },
            child: const Text("Level 2"),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Level3Screen(),
                ),
              );
            },
            child: const Text("Level 3"),
          ),
          
        ],
      ),
    );
  }
}