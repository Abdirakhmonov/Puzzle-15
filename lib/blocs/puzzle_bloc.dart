import 'package:bloc/bloc.dart';
import 'puzzle_event.dart';
import 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc()
      : super(PuzzleState(tiles: List.generate(16, (index) => index))) {
    on<InitializePuzzle>(_onInitializePuzzle);
    on<MoveTile>(_onMoveTile);
    on<RestartPuzzle>(_onRestartPuzzle);
  }

  void _onInitializePuzzle(InitializePuzzle event, Emitter<PuzzleState> emit) {
    final shuffledTiles = List.generate(16, (index) => index)..shuffle();
    emit(state.copyWith(tiles: shuffledTiles, isSolved: false));
  }

  void _onMoveTile(MoveTile event, Emitter<PuzzleState> emit) {
    final emptyIndex = state.tiles.indexOf(0);
    final tileIndex = event.tileIndex;

    if (_canMove(emptyIndex, tileIndex)) {
      final newTiles = List<int>.from(state.tiles);
      newTiles[emptyIndex] = newTiles[tileIndex];
      newTiles[tileIndex] = 0;

      emit(state.copyWith(
        tiles: newTiles,
        isSolved: _isPuzzleSolved(newTiles),
      ));
    }
  }

  void _onRestartPuzzle(RestartPuzzle event, Emitter<PuzzleState> emit) {
    add(InitializePuzzle());
  }

  bool _canMove(int emptyIndex, int tileIndex) {
    final emptyRow = emptyIndex ~/ 4;
    final emptyCol = emptyIndex % 4;
    final tileRow = tileIndex ~/ 4;
    final tileCol = tileIndex % 4;

    return (emptyRow == tileRow && (emptyCol - tileCol).abs() == 1) ||
        (emptyCol == tileCol && (emptyRow - tileRow).abs() == 1);
  }

  bool _isPuzzleSolved(List<int> tiles) {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) {
        return false;
      }
    }
    return tiles.last == 0;
  }
}
