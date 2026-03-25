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
        color: Colors.black.withOpacity(0.7),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tap to next player\'s turn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                playerSymbol == 'X' ? Icons.close : Icons.circle_outlined,
                color: const Color(0xFFb566ff),
                size: 80,
              ),
              const SizedBox(height: 10),
              Text(
                playerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Courier',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
