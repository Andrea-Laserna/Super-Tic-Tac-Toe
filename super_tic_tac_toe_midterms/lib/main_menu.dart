import 'package:flutter/material.dart';
import 'game_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final TextEditingController _player1Controller = TextEditingController(text: 'Player 1');
  final TextEditingController _player2Controller = TextEditingController(text: 'Player 2');

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
              // Galaxy image layer (middle)
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
              // UI elements layer (top)
              Column(
                children: [
                  const SizedBox(height: 70),
                  // Logo Text
                  Stack(
                    children: [
                      // Stroke (outline)
                      Text(
                        'SUPER',
                        style: TextStyle(
                          fontFamily: 'Daydream',
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 8
                            ..color = Color(0xFFE7C4FF),
                        ),
                      ),
                      // Fill
                      const Text(
                        'SUPER',
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                        fontFamily: 'Brady',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7060AD),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Inputs Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        _buildPlayerInput(_player1Controller, 'Enter Player 1', Icons.close, const Color(0xFFEBA5F6)),
                        const SizedBox(height: 20),
                        _buildPlayerInput(_player2Controller, 'Enter Player 2', Icons.circle_outlined, const Color(0xFFb566ff)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Start Button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFEBA5F6),
                          offset: Offset(0, 4),
                        )
                      ]
                    ),
                    child:
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameScreen(
                                  player1: _player1Controller.text,
                                player2: _player2Controller.text,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFa682ff),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'START',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Brady',
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF32316B),
                            ),
                          ),
                        ),
                  ),
                        const SizedBox(height: 120),
                      ],
                    ),
              ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerInput(TextEditingController controller, String hint, IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Color(0xFF1a0b2e), 
          fontWeight: FontWeight.bold,
          fontFamily: 'Brady',
          fontSize: 20,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
