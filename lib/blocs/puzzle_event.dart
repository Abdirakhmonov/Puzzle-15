abstract class PuzzleEvent {}

class InitializePuzzle extends PuzzleEvent {}

class MoveTile extends PuzzleEvent {
  final int tileIndex;

  MoveTile(this.tileIndex);
}

class RestartPuzzle extends PuzzleEvent {}
