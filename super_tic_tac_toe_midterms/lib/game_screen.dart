import 'package:flutter/material.dart';
import 'widgets/game_board_widget.dart';
import 'widgets/turn_popup_widget.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;

  const GameScreen({super.key, required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // 9 sub-grids, each with 9 cells
  late List<List<String?>> board;
  late List<String?> subGridWinners;
  late String currentPlayer;
  int? activeSubGrid; // null means any sub-grid is active
  bool showTurnPopup = false;
  String? mainWinner;
  int player1Wins = 0;
  int player2Wins = 0;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      board = List.generate(9, (_) => List.filled(9, null));
      subGridWinners = List.filled(9, null);
      currentPlayer = 'X';
      activeSubGrid = null;
      mainWinner = null;
      showTurnPopup = false;
    });
  }

  String? _checkWinner(List<String?> cells) {
    const lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
      [0, 4, 8], [2, 4, 6]             // diags
    ];
    for (var line in lines) {
      if (cells[line[0]] != null &&
          cells[line[0]] == cells[line[1]] &&
          cells[line[0]] == cells[line[2]]) {
        return cells[line[0]];
      }
    }
    return null;
  }

  void _handleMove(int gridIndex, int cellIndex) {
    if (mainWinner != null || subGridWinners[gridIndex] != null || board[gridIndex][cellIndex] != null) return;
    if (activeSubGrid != null && activeSubGrid != gridIndex) return;

    setState(() {
      board[gridIndex][cellIndex] = currentPlayer;

      // Check if sub-grid is won
      String? winner = _checkWinner(board[gridIndex]);
      if (winner != null) {
        subGridWinners[gridIndex] = winner;
        // Check if main board is won
        mainWinner = _checkWinner(subGridWinners);
        if (mainWinner != null) {
          // Increment winner's count
          if (mainWinner == 'X') {
            player1Wins++;
          } else {
            player2Wins++;
          }
          // Trigger game over after a short delay
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameOverScreen(
                    winnerName: mainWinner == 'X' ? widget.player1 : widget.player2,
                    winnerSymbol: mainWinner!,
                    player1Name: widget.player1,
                    player2Name: widget.player2,
                    player1Wins: player1Wins,
                    player2Wins: player2Wins,
                    onRematch: () {
                      Navigator.pop(context);
                      _resetGame();
                    },
                    onNewGame: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ),
              );
            }
          });
        }
      }

      // Determine next active sub-grid
      int nextGrid = cellIndex;
      bool isFull = !board[nextGrid].contains(null);
      if (subGridWinners[nextGrid] != null || isFull) {
        activeSubGrid = null;
      } else {
        activeSubGrid = nextGrid;
      }

      // If no winner yet, show turn transition popup
      if (mainWinner == null) {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        showTurnPopup = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentPlayerName = currentPlayer == 'X' ? widget.player1 : widget.player2;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1a0b2e), Color(0xFF0d051a)],
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        // Turn Indicator
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
 
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  mainWinner != null
                                      ? "Player ${mainWinner == 'X' ? widget.player1 : widget.player2} WINS!"
                                      : "Player $currentPlayerName's turn",
                                  style: const TextStyle(
                                    fontFamily: 'Brady',
                                    color: Color(0xFF32316B),
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  (mainWinner ?? currentPlayer) == 'X' ? 'X' : 'O',
                                  style: TextStyle(
                                    fontFamily: 'Daydream',
                                    color: (mainWinner ?? currentPlayer) == 'X'
                                        ? const Color(0xFFEBA5F6)
                                        : const Color.fromARGB(255, 178, 148, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Main Board - Constrained for Desktop
                        Expanded(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: GameBoardWidget(
                                board: board,
                                subGridWinners: subGridWinners,
                                activeSubGrid: activeSubGrid,
                                onMove: _handleMove,
                              ),
                            ),
                          ),
                        ),
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
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFa682ff),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'QUIT MATCH',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Brady',
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF32316B),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Turn Transition Popup
          if (showTurnPopup)
            TurnPopupWidget(
              playerName: currentPlayerName,
              playerSymbol: currentPlayer,
              onTap: () {
                setState(() {
                  showTurnPopup = false;
                });
              },
            ),
        ],
      ),
    );
  }
}
