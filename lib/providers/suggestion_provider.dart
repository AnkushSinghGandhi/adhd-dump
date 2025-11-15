import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/data_loader.dart';

final suggestionsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return await DataLoader.loadSuggestions();
});

final dumpSuggestionsProvider = Provider.family<Map<String, dynamic>?, String>((ref, dumpId) {
  final suggestionsAsync = ref.watch(suggestionsProvider);
  return suggestionsAsync.maybeWhen(
    data: (suggestions) => suggestions[dumpId] as Map<String, dynamic>?,
    orElse: () => null,
  );
});
