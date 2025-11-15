import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dump.dart';
import '../utils/data_loader.dart';

class DumpNotifier extends StateNotifier<AsyncValue<List<Dump>>> {
  DumpNotifier() : super(const AsyncValue.loading()) {
    loadDumps();
  }

  Future<void> loadDumps() async {
    try {
      final dumps = await DataLoader.loadDumps();
      state = AsyncValue.data(dumps);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void addDump(Dump dump) {
    state.whenData((dumps) {
      state = AsyncValue.data([dump, ...dumps]);
    });
  }

  void updateDump(Dump updatedDump) {
    state.whenData((dumps) {
      final index = dumps.indexWhere((d) => d.id == updatedDump.id);
      if (index != -1) {
        final newDumps = List<Dump>.from(dumps);
        newDumps[index] = updatedDump;
        state = AsyncValue.data(newDumps);
      }
    });
  }

  void togglePin(String dumpId) {
    state.whenData((dumps) {
      final index = dumps.indexWhere((d) => d.id == dumpId);
      if (index != -1) {
        final dump = dumps[index];
        final updatedDump = dump.copyWith(isPinned: !dump.isPinned);
        final newDumps = List<Dump>.from(dumps);
        newDumps[index] = updatedDump;
        state = AsyncValue.data(newDumps);
      }
    });
  }

  void moveToDumpTrash(String dumpId) {
    state.whenData((dumps) {
      final index = dumps.indexWhere((d) => d.id == dumpId);
      if (index != -1) {
        final dump = dumps[index];
        final updatedDump = dump.copyWith(
          isTrashed: true,
          trashedAt: DateTime.now(),
        );
        final newDumps = List<Dump>.from(dumps);
        newDumps[index] = updatedDump;
        state = AsyncValue.data(newDumps);
      }
    });
  }

  void restoreFromTrash(String dumpId) {
    state.whenData((dumps) {
      final index = dumps.indexWhere((d) => d.id == dumpId);
      if (index != -1) {
        final dump = dumps[index];
        final updatedDump = dump.copyWith(
          isTrashed: false,
          trashedAt: null,
        );
        final newDumps = List<Dump>.from(dumps);
        newDumps[index] = updatedDump;
        state = AsyncValue.data(newDumps);
      }
    });
  }

  void deletePermanently(String dumpId) {
    state.whenData((dumps) {
      final newDumps = dumps.where((d) => d.id != dumpId).toList();
      state = AsyncValue.data(newDumps);
    });
  }
}

final dumpProvider = StateNotifierProvider<DumpNotifier, AsyncValue<List<Dump>>>((ref) {
  return DumpNotifier();
});

final activeDumpsProvider = Provider<List<Dump>>((ref) {
  final dumpsAsync = ref.watch(dumpProvider);
  return dumpsAsync.maybeWhen(
    data: (dumps) => dumps.where((d) => !d.isTrashed).toList(),
    orElse: () => [],
  );
});

final trashedDumpsProvider = Provider<List<Dump>>((ref) {
  final dumpsAsync = ref.watch(dumpProvider);
  return dumpsAsync.maybeWhen(
    data: (dumps) => dumps.where((d) => d.isTrashed).toList(),
    orElse: () => [],
  );
});

final filteredDumpsProvider = Provider.family<List<Dump>, String>((ref, filter) {
  final activeDumps = ref.watch(activeDumpsProvider);
  
  if (filter == 'All' || filter.isEmpty) {
    return activeDumps;
  }
  
  if (filter == 'New') {
    final oneDayAgo = DateTime.now().subtract(const Duration(days: 1));
    return activeDumps.where((d) => d.createdAt.isAfter(oneDayAgo)).toList();
  }
  
  return activeDumps.where((d) => d.category == filter).toList();
});
