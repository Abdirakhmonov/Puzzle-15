class PuzzleState {
  final List<int> tiles;
  final bool isSolved;

  PuzzleState({required this.tiles, this.isSolved = false});

  PuzzleState copyWith({
    List<int>? tiles,
    bool? isSolved,
  }) {
    return PuzzleState(
      tiles: tiles ?? this.tiles,
      isSolved: isSolved ?? this.isSolved,
    );
  }
}
