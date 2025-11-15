import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reminder.dart';
import '../utils/data_loader.dart';

class ReminderNotifier extends StateNotifier<AsyncValue<List<Reminder>>> {
  ReminderNotifier() : super(const AsyncValue.loading()) {
    loadReminders();
  }

  Future<void> loadReminders() async {
    try {
      final reminders = await DataLoader.loadReminders();
      state = AsyncValue.data(reminders);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void addReminder(Reminder reminder) {
    state.whenData((reminders) {
      state = AsyncValue.data([...reminders, reminder]);
    });
  }

  void updateReminder(Reminder updatedReminder) {
    state.whenData((reminders) {
      final index = reminders.indexWhere((r) => r.id == updatedReminder.id);
      if (index != -1) {
        final newReminders = List<Reminder>.from(reminders);
        newReminders[index] = updatedReminder;
        state = AsyncValue.data(newReminders);
      }
    });
  }

  void snoozeReminder(String reminderId, Duration duration) {
    state.whenData((reminders) {
      final index = reminders.indexWhere((r) => r.id == reminderId);
      if (index != -1) {
        final reminder = reminders[index];
        final newFireAt = DateTime.now().add(duration);
        final updatedReminder = reminder.copyWith(
          fireAt: newFireAt,
          snoozeCount: reminder.snoozeCount + 1,
        );
        final newReminders = List<Reminder>.from(reminders);
        newReminders[index] = updatedReminder;
        state = AsyncValue.data(newReminders);
      }
    });
  }

  void completeReminder(String reminderId) {
    state.whenData((reminders) {
      final index = reminders.indexWhere((r) => r.id == reminderId);
      if (index != -1) {
        final reminder = reminders[index];
        final updatedReminder = reminder.copyWith(isCompleted: true);
        final newReminders = List<Reminder>.from(reminders);
        newReminders[index] = updatedReminder;
        state = AsyncValue.data(newReminders);
      }
    });
  }

  void deleteReminder(String reminderId) {
    state.whenData((reminders) {
      final newReminders = reminders.where((r) => r.id != reminderId).toList();
      state = AsyncValue.data(newReminders);
    });
  }
}

final reminderProvider = StateNotifierProvider<ReminderNotifier, AsyncValue<List<Reminder>>>((ref) {
  return ReminderNotifier();
});

final upcomingRemindersProvider = Provider<List<Reminder>>((ref) {
  final remindersAsync = ref.watch(reminderProvider);
  final now = DateTime.now();
  return remindersAsync.maybeWhen(
    data: (reminders) => reminders
        .where((r) => !r.isCompleted && !r.isMissed && r.fireAt.isAfter(now))
        .toList()
      ..sort((a, b) => a.fireAt.compareTo(b.fireAt)),
    orElse: () => [],
  );
});

final missedRemindersProvider = Provider<List<Reminder>>((ref) {
  final remindersAsync = ref.watch(reminderProvider);
  return remindersAsync.maybeWhen(
    data: (reminders) => reminders
        .where((r) => r.isMissed)
        .toList(),
    orElse: () => [],
  );
});

final completedRemindersProvider = Provider<List<Reminder>>((ref) {
  final remindersAsync = ref.watch(reminderProvider);
  return remindersAsync.maybeWhen(
    data: (reminders) => reminders
        .where((r) => r.isCompleted)
        .toList(),
    orElse: () => [],
  );
});
