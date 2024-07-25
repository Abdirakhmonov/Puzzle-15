import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../blocs/puzzle_bloc.dart';
import '../../blocs/puzzle_event.dart';
import '../../blocs/puzzle_state.dart';

class PuzzleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Puzzle 15",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              context.read<PuzzleBloc>().add(InitializePuzzle());
            },
          ),
        ],
      ),
      body: BlocConsumer<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          if (state.isSolved) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Lottie.asset("assets/succes.json"),
                  title: const Text(
                    'Tabriklaymiz Siz G\'olib bo\'ldingiz',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<PuzzleBloc>().add(RestartPuzzle());
                      },
                      child: const Text('Qayta'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                final tile = state.tiles[index];
                return GestureDetector(
                  onTap: () {
                    context.read<PuzzleBloc>().add(MoveTile(index));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    color: tile == 0 ? Colors.white : Colors.blueAccent,
                    child: Center(
                      child: Text(
                        tile == 0 ? '' : '$tile',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
