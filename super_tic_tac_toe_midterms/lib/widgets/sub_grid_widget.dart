import 'package:flutter/material.dart';

class SubGridWidget extends StatelessWidget {
  final int gridIndex;
  final List<String?> cells;
  final String? winner;
  final bool isActive;
  final Function(int cellIndex) onCellTap;

  const SubGridWidget({
    super.key,
    required this.gridIndex,
    required this.cells,
    required this.winner,
    required this.isActive,
    required this.onCellTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color? winnerOverlayColor = winner == null
        ? null
        : (winner == 'X'
            ? const Color.fromARGB(255, 190, 41, 158).withOpacity(0.80)
            : const Color.fromARGB(255, 121, 39, 197).withOpacity(0.80));

    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.22) : Colors.black.withOpacity(0.42),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, cIdx) {
              String? cell = cells[cIdx];
              return GestureDetector(
                onTap: () => onCellTap(cIdx),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white10, width: 0.5),
                  ),
                  child: Center(
                    child: cell == null
                        ? null
                        : Text(
                            cell,
                            style: TextStyle(
                              fontFamily: 'Daydream',
                              color: cell == 'X' ? const Color(0xFFEBA5F6) : const Color.fromARGB(255, 189, 118, 255),
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
          if (winnerOverlayColor != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: winnerOverlayColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          if (winner != null)
            Center(
              child: Text(
                winner!,
                style: TextStyle(
                  fontFamily: 'Daydream',
                  color: winner == 'X' ? const Color(0xFFEBA5F6) : const Color(0xFFb566ff),
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
