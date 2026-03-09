import 'package:flutter/material.dart';
import 'main_menu.dart';

void main() {
  runApp(const SuperTicTacToeApp());
}

class SuperTicTacToeApp extends StatelessWidget {
  const SuperTicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        fontFamily: 'Courier', // Using a mono font as placeholder for pixelated style
      ),
      home: const MainMenu(),
    );
  }
}
