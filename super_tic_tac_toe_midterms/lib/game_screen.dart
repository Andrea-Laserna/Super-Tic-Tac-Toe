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
          // Trigger game over after a short delay
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameOverScreen(
                    winnerName: mainWinner == 'X' ? widget.player1 : widget.player2,
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
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Turn Indicator
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mainWinner != null 
                              ? "Player ${mainWinner == 'X' ? widget.player1 : widget.player2} WINS!"
                              : "Player $currentPlayerName's turn",
                          style: const TextStyle(
                            color: Color(0xFF1a0b2e),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Icon(
                          (mainWinner ?? currentPlayer) == 'X' ? Icons.close : Icons.circle_outlined,
                          color: const Color(0xFFb566ff),
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Main Board - Constrained for Desktop
                  Center(
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
                  const Spacer(),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'QUIT MATCH',
                      style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
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
