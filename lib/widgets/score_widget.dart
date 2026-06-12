import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int moves;

  const ScoreWidget({super.key, required this.moves});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.touch_app, color: Colors.white70),
          const SizedBox(width: 8),
          Text(
            'Moves: $moves',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}