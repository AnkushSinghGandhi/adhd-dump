import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../models/dump.dart';
import '../models/suggestion.dart';
import '../providers/dump_provider.dart';
import '../providers/suggestion_provider.dart';
import '../utils/data_loader.dart';
import '../theme/app_theme.dart';
import '../widgets/rounded_pill.dart';
import '../widgets/suggestion_card.dart';

class DumpDetailsScreen extends ConsumerStatefulWidget {
  final String dumpId;

  const DumpDetailsScreen({Key? key, required this.dumpId}) : super(key: key);

  @override
  ConsumerState<DumpDetailsScreen> createState() => _DumpDetailsScreenState();
}

class _DumpDetailsScreenState extends ConsumerState<DumpDetailsScreen> {
  bool _showBoundingBoxes = false;

  @override
  Widget build(BuildContext context) {
    final dumpsAsync = ref.watch(dumpProvider);
    
    return dumpsAsync.when(
      data: (dumps) {
        final dump = dumps.firstWhere(
          (d) => d.id == widget.dumpId,
          orElse: () => dumps.first,
        );
        
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: const Text('Dump Details'),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share feature coming soon!')),
                  );
                },
                tooltip: 'Share',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full-width image with Hero animation
                Hero(
                  tag: 'dump_${dump.id}',
                  child: GestureDetector(
                    onTap: () {
                      // Could open full-screen image viewer
                    },
                    child: CachedNetworkImage(
                      imageUrl: dump.thumbnailUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: DumpMateTheme.background,
                        height: 300,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: DumpMateTheme.background,
                        height: 300,
                        child: const Icon(Icons.image_not_supported, size: 80),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        dump.title,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 12),
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          RoundedPill(
                            text: dump.category,
                            backgroundColor: DumpMateTheme.accentLime.withOpacity(0.2),
                            icon: Icons.folder_outlined,
                          ),
                          RoundedPill(
                            text: dump.subcategory,
                            backgroundColor: DumpMateTheme.background,
                          ),
                          ...dump.tags.map(
                            (tag) => RoundedPill(
                              text: tag,
                              backgroundColor: DumpMateTheme.background,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // OCR Text section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Extracted Text',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _showBoundingBoxes = !_showBoundingBoxes;
                              });
                            },
                            icon: Icon(
                              _showBoundingBoxes ? Icons.visibility_off : Icons.visibility,
                              size: 18,
                            ),
                            label: Text(_showBoundingBoxes ? 'Hide boxes' : 'Show boxes'),
                            style: TextButton.styleFrom(
                              foregroundColor: DumpMateTheme.mutedText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: DumpMateTheme.background,
                          borderRadius: BorderRadius.circular(DumpMateTheme.radiusButton),
                        ),
                        child: Text(
                          dump.ocrText,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Suggestions section
                      if (dump.suggestionProviders.isNotEmpty) ..[
                        Text(
                          'Suggestions',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 12),
                        _SuggestionsCarousel(dumpId: dump.id),
                        const SizedBox(height: 24),
                      ],
                      // Reminders widget
                      Text(
                        'Reminders',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: DumpMateTheme.cardBackground,
                          borderRadius: BorderRadius.circular(DumpMateTheme.radiusCard),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.notifications_outlined, color: DumpMateTheme.mutedText),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                dump.hasReminder ? 'Reminder set' : 'No reminders set',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Add reminder coming soon!')),
                                );
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
            decoration: BoxDecoration(
              color: DumpMateTheme.cardBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                if (dump.category == 'Shopping')
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart!')),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart, size: 20),
                      label: const Text('Add to Cart'),
                    ),
                  ),
                if (dump.category == 'Shopping')
                  const SizedBox(width: 12),
                IconButton(
                  onPressed: () {
                    ref.read(dumpProvider.notifier).togglePin(dump.id);
                  },
                  icon: Icon(
                    dump.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: dump.isPinned ? DumpMateTheme.accentLime : DumpMateTheme.mutedText,
                  ),
                  tooltip: dump.isPinned ? 'Unpin' : 'Pin',
                ),
                IconButton(
                  onPressed: () {
                    ref.read(dumpProvider.notifier).moveToDumpTrash(dump.id);
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Moved to trash')),
                    );
                  },
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  tooltip: 'Move to trash',
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _SuggestionsCarousel extends ConsumerWidget {
  final String dumpId;

  const _SuggestionsCarousel({required this.dumpId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsData = ref.watch(dumpSuggestionsProvider(dumpId));

    if (suggestionsData == null) {
      return const Text('No suggestions available');
    }

    return SizedBox(
      height: 280,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Anime suggestions
          if (suggestionsData['anime'] != null)
            ...DataLoader.parseAnimeSuggestions(suggestionsData['anime']).map(
              (anime) => AnimeSuggestionCard(
                title: anime.title,
                posterUrl: anime.posterUrl,
                season: anime.season,
                rating: anime.rating,
                status: anime.status,
                onAddToWatchlist: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added ${anime.title} to watchlist!')),
                  );
                },
              ),
            ),
          // Shopping suggestions
          if (suggestionsData['shopping'] != null)
            ...DataLoader.parseShoppingSuggestions(suggestionsData['shopping']).map(
              (shopping) => ShoppingSuggestionCard(
                productName: shopping.productName,
                bestPrice: shopping.bestPrice,
                imageUrl: shopping.imageUrl,
                merchants: shopping.merchants
                    .map((m) => {'name': m.name, 'price': m.price})
                    .toList(),
                onCompare: () {
                  _showPriceCompareModal(context, shopping);
                },
              ),
            ),
          // Study suggestions
          if (suggestionsData['study'] != null)
            ...DataLoader.parseStudySuggestions(suggestionsData['study']).map(
              (study) => _StudySuggestionCard(
                title: study.title,
                duration: study.duration,
                type: study.type,
              ),
            ),
        ],
      ),
    );
  }

  void _showPriceCompareModal(BuildContext context, ShoppingSuggestion shopping) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(DumpMateTheme.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Compare Prices',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            ...shopping.merchants.map(
              (merchant) => ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: DumpMateTheme.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      merchant.name[0],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                title: Text(merchant.name),
                trailing: Text(
                  merchant.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudySuggestionCard extends StatelessWidget {
  final String title;
  final String duration;
  final String type;

  const _StudySuggestionCard({
    required this.title,
    required this.duration,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DumpMateTheme.cardBackground,
        borderRadius: BorderRadius.circular(DumpMateTheme.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedPill(
            text: type,
            backgroundColor: DumpMateTheme.accentLime.withOpacity(0.2),
            icon: Icons.school_outlined,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.schedule, size: 14, color: DumpMateTheme.mutedText),
              const SizedBox(width: 4),
              Text(
                duration,
                style: TextStyle(color: DumpMateTheme.mutedText, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text('View Resource', style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
