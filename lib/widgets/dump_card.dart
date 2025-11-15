import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/dump.dart';
import '../theme/app_theme.dart';
import 'rounded_pill.dart';

class DumpCard extends StatelessWidget {
  final Dump dump;
  final VoidCallback onTap;
  final VoidCallback? onPin;
  final VoidCallback? onRemind;
  final bool compact;

  const DumpCard({
    Key? key,
    required this.dump,
    required this.onTap,
    this.onPin,
    this.onRemind,
    this.compact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Dump card: ${dump.title}',
      button: true,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(DumpMateTheme.radiusCard),
          child: Padding(
            padding: EdgeInsets.all(compact ? 8.0 : 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Hero(
                  tag: 'dump_${dump.id}',
                  child: ClipRRectWidget(
                    radius: DumpMateTheme.radiusPill,
                    child: CachedNetworkImage(
                      imageUrl: dump.thumbnailUrl,
                      width: compact ? 60 : 80,
                      height: compact ? 60 : 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: DumpMateTheme.background,
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: DumpMateTheme.background,
                        child: Icon(Icons.image_not_supported, color: DumpMateTheme.mutedText),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              dump.title,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Quick actions
                          if (onPin != null)
                            IconButton(
                              icon: Icon(
                                dump.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                                size: 18,
                                color: dump.isPinned ? DumpMateTheme.accentLime : DumpMateTheme.mutedText,
                              ),
                              onPressed: onPin,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              tooltip: dump.isPinned ? 'Unpin' : 'Pin',
                            ),
                          if (onRemind != null)
                            IconButton(
                              icon: Icon(
                                dump.hasReminder ? Icons.notifications_active : Icons.notifications_outlined,
                                size: 18,
                                color: dump.hasReminder ? DumpMateTheme.accentLime : DumpMateTheme.mutedText,
                              ),
                              onPressed: onRemind,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              tooltip: 'Set reminder',
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // OCR snippet
                      if (!compact)
                        Text(
                          dump.ocrText,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 8),
                      // Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          RoundedPill(
                            text: dump.category,
                            backgroundColor: DumpMateTheme.accentLime.withOpacity(0.2),
                            textColor: DumpMateTheme.primaryBlack,
                          ),
                          if (!compact && dump.tags.isNotEmpty)
                            ...dump.tags.take(2).map(
                                  (tag) => RoundedPill(
                                text: tag,
                                backgroundColor: DumpMateTheme.background,
                                textColor: DumpMateTheme.mutedText,
                              ),
                            ),
                        ],
                      ),
                      // Suggestion providers preview
                      if (!compact && dump.suggestionProviders.isNotEmpty) ..[
                        const SizedBox(height: 8),
                        Row(
                          children: dump.suggestionProviders.take(3).map((provider) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: RoundedPill(
                                text: provider,
                                backgroundColor: DumpMateTheme.primaryBlack,
                                textColor: Colors.white,
                                fontSize: 10,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClipRRectWidget extends StatelessWidget {
  final Widget child;
  final double radius;

  const ClipRRectWidget({Key? key, required this.child, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: child,
    );
  }
}
