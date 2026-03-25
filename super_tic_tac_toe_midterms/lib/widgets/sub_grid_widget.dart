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
    return Container(
      decoration: BoxDecoration(
        color: winner != null
            ? Colors.grey.withOpacity(0.5)
            : (isActive ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.3)),
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
                        : Icon(
                            cell == 'X' ? Icons.close : Icons.circle_outlined,
                            color: const Color(0xFFb566ff),
                            size: 14,
                          ),
                  ),
                ),
              );
            },
          ),
          if (winner != null)
            Center(
              child: Icon(
                winner == 'X' ? Icons.close : Icons.circle_outlined,
                color: const Color(0xFFb566ff),
                size: 60,
              ),
            ),
        ],
      ),
    );
  }
}
