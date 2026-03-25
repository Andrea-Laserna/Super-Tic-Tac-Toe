import 'package:flutter/material.dart';

class TurnPopupWidget extends StatelessWidget {
  final String playerName;
  final String playerSymbol;
  final VoidCallback onTap;

  const TurnPopupWidget({
    super.key,
    required this.playerName,
    required this.playerSymbol,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: playerSymbol == 'X' ? const Color.fromARGB(255, 53, 6, 38).withOpacity(0.6) : const Color.fromARGB(255, 32, 7, 54).withOpacity(0.6),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tap to next\nplayer\'s turn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Brady',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                playerSymbol,
                style: TextStyle(
                  color: playerSymbol == 'X'
                      ? const Color(0xFFEBA5F6)
                      : const Color(0xFFb566ff),
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Daydream',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                playerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Daydream',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
