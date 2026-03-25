import 'package:flutter/material.dart';
import 'sub_grid_widget.dart';

class GameBoardWidget extends StatelessWidget {
  final List<List<String?>> board;
  final List<String?> subGridWinners;
  final int? activeSubGrid;
  final Function(int gridIndex, int cellIndex) onMove;

  const GameBoardWidget({
    super.key,
    required this.board,
    required this.subGridWinners,
    required this.activeSubGrid,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFb566ff).withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 9,
            itemBuilder: (context, gIdx) {
              bool isActive = activeSubGrid == null || activeSubGrid == gIdx;
              String? winner = subGridWinners[gIdx];

              return SubGridWidget(
                gridIndex: gIdx,
                cells: board[gIdx],
                winner: winner,
                isActive: isActive,
                onCellTap: (cIdx) => onMove(gIdx, cIdx),
              );
            },
          ),
        ),
      ),
    );
  }
}
