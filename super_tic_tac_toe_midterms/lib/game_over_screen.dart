import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final String winnerName;
  final String winnerSymbol;
  final String player1Name;
  final String player2Name;
  final int player1Wins;
  final int player2Wins;
  final VoidCallback onRematch;
  final VoidCallback onNewGame;

  const GameOverScreen({
    super.key,
    required this.winnerName,
    required this.winnerSymbol,
    required this.player1Name,
    required this.player2Name,
    required this.player1Wins,
    required this.player2Wins,
    required this.onRematch,
    required this.onNewGame,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF32316B), Color(0xFF0d051a)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/galaxy.png',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/grid.png',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    SizedBox(
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Text(
                            'GAME OVER',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Daydream',
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 8
                                ..color = const Color(0xFFE7C4FF),
                            ),
                          ),
                          const Text(
                            'GAME OVER',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Daydream',
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF7060AD),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Transform.rotate(
                      angle: 0.02,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          '$winnerName WINS!',
                          style: TextStyle(
                            color: winnerSymbol == 'X'
                                ? const Color(0xFFEBA5F6)
                                : const Color(0xFF7060AD),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Brady',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$player1Name: $player1Wins',
                      style: const TextStyle(
                        fontFamily: 'Brady',
                        color: Color.fromARGB(255, 255, 144, 237),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$player2Name: $player2Wins',
                      style: const TextStyle(
                        fontFamily: 'Brady',
                        color: Color.fromARGB(255, 190, 134, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFEBA5F6),
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: onRematch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFa682ff),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'REMATCH',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Brady',
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF32316B),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFEBA5F6),
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: onNewGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFa682ff),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'NEW GAME',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Brady',
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF32316B),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
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
