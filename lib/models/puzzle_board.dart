import 'package:flutter/material.dart';
import '../utils/game_logic.dart';

class PuzzleBoard extends ChangeNotifier {
  late List<int> tiles;
  late int gridSize;
  int moves = 0;
  int timeElapsed = 0;
  bool isGameComplete = false;
  String difficulty = 'Easy'; // Easy: 3x3, Medium: 4x4, Hard: 5x5

  PuzzleBoard() {
    _initializeGame();
  }

  void _initializeGame() {
    gridSize = difficulty == 'Easy' ? 3 : difficulty == 'Medium' ? 4 : 5;
    tiles = GameLogic.generateSolvablePuzzle(gridSize);
    moves = 0;
    timeElapsed = 0;
    isGameComplete = false;
    notifyListeners();
  }

  void setDifficulty(String level) {
    difficulty = level;
    _initializeGame();
  }

  void moveTile(int index) {
    if (isGameComplete) return;

    final emptyIndex = tiles.indexOf(tiles.length - 1);
    if (GameLogic.isAdjacent(index, emptyIndex, gridSize)) {
      tiles[emptyIndex] = tiles[index];
      tiles[index] = tiles.length - 1;
      moves++;
      
      if (GameLogic.isSolved(tiles)) {
        isGameComplete = true;
      }
      notifyListeners();
    }
  }

  void shufflePuzzle() {
    do {
      tiles = GameLogic.shuffleTiles(tiles.length, gridSize);
    } while (!GameLogic.isSolvable(tiles, gridSize));
    moves = 0;
    timeElapsed = 0;
    isGameComplete = false;
    notifyListeners();
  }

  void incrementTime() {
    timeElapsed++;
    notifyListeners();
  }
}