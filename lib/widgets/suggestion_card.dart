import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import 'rounded_pill.dart';

class AnimeSuggestionCard extends StatelessWidget {
  final String title;
  final String posterUrl;
  final String season;
  final double rating;
  final String status;
  final VoidCallback? onAddToWatchlist;

  const AnimeSuggestionCard({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.season,
    required this.rating,
    required this.status,
    this.onAddToWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Anime suggestion: $title',
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: DumpMateTheme.cardBackground,
          borderRadius: BorderRadius.circular(DumpMateTheme.radiusCard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(DumpMateTheme.radiusCard),
              ),
              child: CachedNetworkImage(
                imageUrl: posterUrl,
                width: double.infinity,
                height: 120,
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    season,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RoundedPill(
                        text: '★ $rating',
                        backgroundColor: DumpMateTheme.accentLime.withOpacity(0.2),
                        fontSize: 11,
                      ),
                      const SizedBox(width: 6),
                      RoundedPill(
                        text: status,
                        backgroundColor: DumpMateTheme.background,
                        fontSize: 11,
                      ),
                    ],
                  ),
                  if (onAddToWatchlist != null) ..[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onAddToWatchlist,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: const Text('Add to Watchlist', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingSuggestionCard extends StatelessWidget {
  final String productName;
  final String bestPrice;
  final String imageUrl;
  final List<Map<String, String>> merchants;
  final VoidCallback? onCompare;

  const ShoppingSuggestionCard({
    Key? key,
    required this.productName,
    required this.bestPrice,
    required this.imageUrl,
    required this.merchants,
    this.onCompare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Shopping suggestion: $productName',
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: DumpMateTheme.cardBackground,
          borderRadius: BorderRadius.circular(DumpMateTheme.radiusCard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(DumpMateTheme.radiusCard),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: DumpMateTheme.background,
                ),
                errorWidget: (context, url, error) => Container(
                  color: DumpMateTheme.background,
                  child: Icon(Icons.image_not_supported, color: DumpMateTheme.mutedText),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  RoundedPill(
                    text: 'Best: $bestPrice',
                    backgroundColor: DumpMateTheme.accentLime.withOpacity(0.2),
                    icon: Icons.local_offer,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${merchants.length} merchants',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (onCompare != null) ..[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onCompare,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: const Text('Compare Prices', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
