import 'dart:math';

class GameLogic {
  static List<int> generateSolvablePuzzle(int gridSize) {
    List<int> tiles = List.generate(gridSize * gridSize, (i) => i);
    do {
      tiles.shuffle(Random());
    } while (!isSolvable(tiles, gridSize) || isSolved(tiles));
    return tiles;
  }

  static bool isSolvable(List<int> tiles, int gridSize) {
    int inversions = 0;
    int blankRowFromBottom = 0;
    int blankValue = tiles.length - 1;

    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] == blankValue) {
        blankRowFromBottom = gridSize - (i ~/ gridSize);
        continue;
      }
      for (int j = i + 1; j < tiles.length; j++) {
        if (tiles[j] != blankValue && tiles[i] > tiles[j]) {
          inversions++;
        }
      }
    }

    if (gridSize % 2 == 1) {
      return inversions % 2 == 0;
    } else {
      return (inversions + blankRowFromBottom) % 2 == 1;
    }
  }

  static bool isAdjacent(int a, int b, int gridSize) {
    int rowA = a ~/ gridSize, colA = a % gridSize;
    int rowB = b ~/ gridSize, colB = b % gridSize;
    return (rowA == rowB && (colA - colB).abs() == 1) ||
           (colA == colB && (rowA - rowB).abs() == 1);
  }

  static bool isSolved(List<int> tiles) {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != i) return false;
    }
    return true;
  }

  static List<int> shuffleTiles(int length, int gridSize) {
    List<int> tiles = List.generate(length, (i) => i);
    tiles.shuffle(Random());
    return tiles;
  }
}