import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_84/blocs/puzzle_bloc.dart';
import 'package:lesson_84/blocs/puzzle_event.dart';
import 'package:lesson_84/ui/screens/puzzle_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PuzzleBloc()..add(InitializePuzzle());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PuzzleView(),
      ),
    );
  }
}
