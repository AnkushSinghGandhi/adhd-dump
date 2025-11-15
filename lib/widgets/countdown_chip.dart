import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CountdownChip extends StatelessWidget {
  final int daysLeft;

  const CountdownChip({Key? key, required this.daysLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = daysLeft <= 7
        ? Colors.red
        : daysLeft <= 14
        ? Colors.orange
        : DumpMateTheme.mutedText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(DumpMateTheme.radiusPill),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            '$daysLeft days left',
            style: TextStyle(
              fontSize: DumpMateTheme.small,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
