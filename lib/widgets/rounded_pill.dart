import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RoundedPill extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final VoidCallback? onTap;
  final double? fontSize;

  const RoundedPill({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.onTap,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor ?? DumpMateTheme.cardBackground,
        borderRadius: BorderRadius.circular(DumpMateTheme.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ..[
            Icon(
              icon,
              size: fontSize ?? DumpMateTheme.small,
              color: textColor ?? DumpMateTheme.primaryBlack,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? DumpMateTheme.small,
              fontWeight: FontWeight.w500,
              color: textColor ?? DumpMateTheme.primaryBlack,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return Semantics(
        button: true,
        label: text,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(DumpMateTheme.radiusPill),
          child: content,
        ),
      );
    }

    return content;
  }
}
