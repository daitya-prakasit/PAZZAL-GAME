import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/puzzle_board.dart';
import '../widgets/puzzle_tile.dart';
import '../widgets/timer_widget.dart';
import '../widgets/score_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PuzzleBoard>().shufflePuzzle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAZZAL', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () => context.read<PuzzleBoard>().shufflePuzzle(),
          ),
        ],
      ),
      body: Consumer<PuzzleBoard>(
        builder: (context, puzzle, _) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ScoreWidget(moves: puzzle.moves),
                  const TimerWidget(),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: puzzle.isGameComplete
                    ? _buildWinScreen(context, puzzle)
                    : _buildPuzzleGrid(puzzle),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPuzzleGrid(PuzzleBoard puzzle) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: puzzle.gridSize,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: puzzle.tiles.length,
        itemBuilder: (context, index) {
          if (puzzle.tiles[index] == puzzle.tiles.length - 1) {
            return const SizedBox.shrink();
          }
          return PuzzleTile(
            number: puzzle.tiles[index] + 1,
            onTap: () => puzzle.moveTile(index),
          );
        },
      ),
    );
  }

  Widget _buildWinScreen(BuildContext context, PuzzleBoard puzzle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
        const SizedBox(height: 20),
        Text(
          'PUZZLE SOLVED!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
            shadows: [Shadow(color: Colors.green, blurRadius: 10)],
          ),
        ),
        const SizedBox(height: 20),
        Text('Moves: ${puzzle.moves}', style: const TextStyle(fontSize: 22, color: Colors.white)),
        Text('Time: ${puzzle.timeElapsed}s', style: const TextStyle(fontSize: 22, color: Colors.white)),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => puzzle.shufflePuzzle(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          child: const Text('PLAY AGAIN', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}