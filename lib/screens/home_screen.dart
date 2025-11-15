import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/dump_provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/dump_card.dart';
import '../widgets/floating_dump_button.dart';
import '../widgets/rounded_pill.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filters = ['All', 'New', 'Study', 'Watchlist', 'Shopping', 'Misc'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final activeDumps = ref.watch(activeDumpsProvider);
    final selectedFilter = appState.selectedFilter;
    
    final filteredDumps = selectedFilter == 'All'
        ? activeDumps
        : selectedFilter == 'New'
            ? activeDumps.where((d) {
                final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
                return d.createdAt.isAfter(oneDayAgo);
              }).toList()
            : activeDumps.where((d) => d.category == selectedFilter).toList();

    final searchQuery = _searchController.text.toLowerCase();
    final displayDumps = searchQuery.isEmpty
        ? filteredDumps
        : filteredDumps.where((d) {
            return d.title.toLowerCase().contains(searchQuery) ||
                d.ocrText.toLowerCase().contains(searchQuery) ||
                d.tags.any((tag) => tag.toLowerCase().contains(searchQuery));
          }).toList();

    // Count new items (last 24 hours)
    final newItemsCount = activeDumps.where((d) {
      final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
      return d.createdAt.isAfter(oneDayAgo);
    }).length;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: DumpMateTheme.accentLime,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'D',
                style: TextStyle(
                  color: DumpMateTheme.primaryBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        title: const Text('DumpMate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
            child: Semantics(
              textField: true,
              label: 'Search dumps, tags, text',
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: DumpMateTheme.cardBackground,
                  borderRadius: BorderRadius.circular(DumpMateTheme.radiusButton),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search dumps, tags, text…',
                    prefixIcon: Icon(Icons.search, color: DumpMateTheme.mutedText),
                    suffixIcon: Icon(Icons.mic_outlined, color: DumpMateTheme.mutedText),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),
          ),
          // Filter chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: DumpMateTheme.spacingMd),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      filter,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      ref.read(appStateProvider.notifier).setSelectedFilter(filter);
                    },
                    backgroundColor: DumpMateTheme.cardBackground,
                    selectedColor: DumpMateTheme.accentLime.withOpacity(0.2),
                    side: BorderSide(
                      color: isSelected ? DumpMateTheme.accentLime : Colors.transparent,
                      width: 2,
                    ),
                    checkmarkColor: DumpMateTheme.primaryBlack,
                  ),
                );
              },
            ),
          ),
          // New items banner
          if (newItemsCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DumpMateTheme.spacingMd,
                vertical: DumpMateTheme.spacingSm,
              ),
              child: InkWell(
                onTap: () {
                  ref.read(appStateProvider.notifier).setSelectedFilter('New');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: DumpMateTheme.accentLime.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(DumpMateTheme.radiusButton),
                    border: Border.all(
                      color: DumpMateTheme.accentLime,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.fiber_new, color: DumpMateTheme.primaryBlack),
                      const SizedBox(width: 8),
                      Text(
                        '$newItemsCount new items — Review',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: DumpMateTheme.primaryBlack,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 16, color: DumpMateTheme.primaryBlack),
                    ],
                  ),
                ),
              ),
            ),
          // Main feed
          Expanded(
            child: displayDumps.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          color: DumpMateTheme.mutedText,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No dumps yet',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the + button to create your first dump',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
                    itemCount: displayDumps.length,
                    itemBuilder: (context, index) {
                      final dump = displayDumps[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: DumpCard(
                          dump: dump,
                          onTap: () => context.push('/dump/${dump.id}'),
                          onPin: () {
                            ref.read(dumpProvider.notifier).togglePin(dump.id);
                          },
                          onRemind: () {
                            // Open reminder composer
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Reminder feature coming soon!')),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingDumpButton(
        onPressed: () => _showQuickDumpModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: DumpMateTheme.accentLime,
        unselectedItemColor: DumpMateTheme.mutedText,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_outline),
            activeIcon: Icon(Icons.delete),
            label: 'Trash',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              context.push('/cart');
              break;
            case 2:
              context.push('/reminders');
              break;
            case 3:
              context.push('/trash');
              break;
          }
        },
      ),
    );
  }

  void _showQuickDumpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickDumpModal(),
    );
  }
}

class QuickDumpModal extends ConsumerStatefulWidget {
  const QuickDumpModal({Key? key}) : super(key: key);

  @override
  ConsumerState<QuickDumpModal> createState() => _QuickDumpModalState();
}

class _QuickDumpModalState extends ConsumerState<QuickDumpModal> {
  final TextEditingController _noteController = TextEditingController();
  String? _selectedCategory;
  String? _selectedReminderPreset;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: DumpMateTheme.cardBackground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DumpMateTheme.radiusCard),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(DumpMateTheme.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: DumpMateTheme.mutedText.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Quick Dump',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            // Image preview placeholder
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: DumpMateTheme.background,
                borderRadius: BorderRadius.circular(DumpMateTheme.radiusPill),
                border: Border.all(
                  color: DumpMateTheme.mutedText.withOpacity(0.3),
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined, color: DumpMateTheme.mutedText),
                    const SizedBox(width: 8),
                    Text(
                      'Latest screenshot will auto-attach',
                      style: TextStyle(color: DumpMateTheme.mutedText, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Note input
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Quick note or paste...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            // Category suggestion
            Text(
              'Category',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['Study', 'Watchlist', 'Shopping', 'Misc'].map((category) {
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                    });
                  },
                  selectedColor: DumpMateTheme.accentLime.withOpacity(0.2),
                  side: BorderSide(
                    color: isSelected ? DumpMateTheme.accentLime : Colors.transparent,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Quick reminder presets
            Text(
              'Quick Reminder',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['30m', 'Tonight 9 PM', 'Tomorrow 9 AM', 'Custom'].map((preset) {
                final isSelected = _selectedReminderPreset == preset;
                return ChoiceChip(
                  label: Text(preset),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedReminderPreset = selected ? preset : null;
                    });
                  },
                  selectedColor: DumpMateTheme.accentLime.withOpacity(0.2),
                  side: BorderSide(
                    color: isSelected ? DumpMateTheme.accentLime : Colors.transparent,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Discard'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save dump logic
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Dump saved successfully!'),
                          backgroundColor: DumpMateTheme.accentLime,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text('Save Dump'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
