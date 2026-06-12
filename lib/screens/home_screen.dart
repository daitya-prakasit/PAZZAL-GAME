import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/puzzle_board.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PAZZAL',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                  letterSpacing: 12,
                  shadows: [
                    Shadow(color: Colors.purple, blurRadius: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Master the Grid',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 60),
              _buildDifficultyButton(context, 'Easy', Colors.greenAccent),
              _buildDifficultyButton(context, 'Medium', Colors.orangeAccent),
              _buildDifficultyButton(context, 'Hard', Colors.redAccent),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GameScreen()),
                  );
                },
                icon: const Icon(Icons.play_arrow, size: 30),
                label: const Text('START GAME', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String level, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          context.read<PuzzleBoard>().setDifficulty(level);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.8),
          minimumSize: const Size(200, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(level.toUpperCase(), style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}