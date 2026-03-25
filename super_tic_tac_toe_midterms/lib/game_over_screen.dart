import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final String winnerName;
  final VoidCallback onRematch;
  final VoidCallback onNewGame;

  const GameOverScreen({
    super.key,
    required this.winnerName,
    required this.onRematch,
    required this.onNewGame,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1a0b2e), Color(0xFF0d051a)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              const Text(
                'GAME OVER',
                style: TextStyle(
                  color: Color(0xFFb566ff),
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 10),
              // Winner Banner
              Transform.rotate(
                angle: 0.02,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Text(
                    '$winnerName Wins!',
                    style: const TextStyle(
                      color: Color(0xFF1a0b2e),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: onRematch,
                      icon: const Icon(Icons.refresh, size: 28),
                      label: const Text(
                        'REMATCH',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFa682ff),
                        foregroundColor: const Color(0xFF1a0b2e),
                        minimumSize: const Size(double.infinity, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 8,
                      ),
                    ),
                    const SizedBox(height: 25),
                    OutlinedButton.icon(
                      onPressed: onNewGame,
                      icon: const Icon(Icons.home_outlined, size: 24),
                      label: const Text(
                        'NEW GAME',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white24, width: 2),
                        minimumSize: const Size(double.infinity, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
