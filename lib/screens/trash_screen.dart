import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/dump_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/dump_card.dart';
import '../widgets/countdown_chip.dart';

class TrashScreen extends ConsumerWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashedDumps = ref.watch(trashedDumpsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Trash'),
      ),
      body: trashedDumps.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline,
                    size: 80,
                    color: DumpMateTheme.mutedText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Trash is empty',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Deleted items will appear here',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
              itemCount: trashedDumps.length,
              itemBuilder: (context, index) {
                final dump = trashedDumps[index];
                final daysLeft = dump.daysLeftInTrash;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
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
                              CountdownChip(daysLeft: daysLeft),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dump.ocrText,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  ref.read(dumpProvider.notifier).restoreFromTrash(dump.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Restored from trash'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          ref.read(dumpProvider.notifier).moveToDumpTrash(dump.id);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.restore, size: 18),
                                label: const Text('Restore'),
                                style: TextButton.styleFrom(
                                  foregroundColor: DumpMateTheme.accentLime,
                                ),
                              ),
                              const SizedBox(width: 8),
                              TextButton.icon(
                                onPressed: () {
                                  _showDeleteConfirmation(context, ref, dump.id);
                                },
                                icon: const Icon(Icons.delete_forever, size: 18),
                                label: const Text('Delete'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String dumpId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Permanently?'),
        content: const Text(
          'This action cannot be undone. The dump will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(dumpProvider.notifier).deletePermanently(dumpId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Permanently deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
