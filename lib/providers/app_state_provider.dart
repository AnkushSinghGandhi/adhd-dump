import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void setSelectedFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleAutoScan(bool value) {
    state = state.copyWith(autoScanEnabled: value);
  }

  void toggleLocalOnly(bool value) {
    state = state.copyWith(localOnlyMode: value);
  }

  void toggleNotifications(bool value) {
    state = state.copyWith(notificationsEnabled: value);
  }

  void setReducedMotion(bool value) {
    state = state.copyWith(reducedMotion: value);
  }
}

class AppState {
  final String selectedFilter;
  final String searchQuery;
  final bool autoScanEnabled;
  final bool localOnlyMode;
  final bool notificationsEnabled;
  final bool reducedMotion;

  AppState({
    this.selectedFilter = 'All',
    this.searchQuery = '',
    this.autoScanEnabled = true,
    this.localOnlyMode = true,
    this.notificationsEnabled = true,
    this.reducedMotion = false,
  });

  AppState copyWith({
    String? selectedFilter,
    String? searchQuery,
    bool? autoScanEnabled,
    bool? localOnlyMode,
    bool? notificationsEnabled,
    bool? reducedMotion,
  }) {
    return AppState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      autoScanEnabled: autoScanEnabled ?? this.autoScanEnabled,
      localOnlyMode: localOnlyMode ?? this.localOnlyMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      reducedMotion: reducedMotion ?? this.reducedMotion,
    );
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
