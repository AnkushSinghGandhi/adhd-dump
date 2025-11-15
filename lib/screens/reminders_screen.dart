import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/reminder_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/rounded_pill.dart';

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Reminders'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: DumpMateTheme.accentLime,
          unselectedLabelColor: DumpMateTheme.mutedText,
          indicatorColor: DumpMateTheme.accentLime,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Missed'),
            Tab(text: 'Done'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _UpcomingReminders(),
          _MissedReminders(),
          _CompletedReminders(),
        ],
      ),
    );
  }
}

class _UpcomingReminders extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(upcomingRemindersProvider);
    final dateFormat = DateFormat('MMM d, yyyy h:mm a');

    if (reminders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 80,
              color: DumpMateTheme.mutedText,
            ),
            const SizedBox(height: 16),
            Text(
              'No upcoming reminders',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        final priorityColor = reminder.priority == 'high'
            ? Colors.red
            : reminder.priority == 'medium'
                ? Colors.orange
                : DumpMateTheme.mutedText;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: priorityColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminder.title,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 14,
                                  color: DumpMateTheme.mutedText,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  dateFormat.format(reminder.fireAt),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      RoundedPill(
                        text: reminder.priority.toUpperCase(),
                        backgroundColor: priorityColor.withOpacity(0.1),
                        textColor: priorityColor,
                        fontSize: 11,
                      ),
                    ],
                  ),
                  if (reminder.recurrence != 'none') ..[
                    const SizedBox(height: 8),
                    RoundedPill(
                      text: 'Repeats ${reminder.recurrence}',
                      icon: Icons.repeat,
                      backgroundColor: DumpMateTheme.background,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _showSnoozeOptions(context, ref, reminder.id);
                        },
                        icon: const Icon(Icons.snooze, size: 18),
                        label: const Text('Snooze'),
                        style: TextButton.styleFrom(
                          foregroundColor: DumpMateTheme.mutedText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () {
                          ref.read(reminderProvider.notifier).completeReminder(reminder.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reminder completed')),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline, size: 18),
                        label: const Text('Complete'),
                        style: TextButton.styleFrom(
                          foregroundColor: DumpMateTheme.accentLime,
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
    );
  }

  void _showSnoozeOptions(BuildContext context, WidgetRef ref, String reminderId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(DumpMateTheme.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Snooze for',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            ...[10, 30, 60].map((minutes) {
              return ListTile(
                leading: const Icon(Icons.schedule),
                title: Text('$minutes minutes'),
                onTap: () {
                  ref.read(reminderProvider.notifier).snoozeReminder(
                        reminderId,
                        Duration(minutes: minutes),
                      );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Snoozed for $minutes minutes')),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _MissedReminders extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(missedRemindersProvider);

    if (reminders.isEmpty) {
      return Center(
        child: Text(
          'No missed reminders',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        return ListTile(
          title: Text(reminder.title),
          subtitle: Text('Missed: ${DateFormat('MMM d, h:mm a').format(reminder.fireAt)}'),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              ref.read(reminderProvider.notifier).deleteReminder(reminder.id);
            },
          ),
        );
      },
    );
  }
}

class _CompletedReminders extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(completedRemindersProvider);

    if (reminders.isEmpty) {
      return Center(
        child: Text(
          'No completed reminders',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        return ListTile(
          leading: Icon(
            Icons.check_circle,
            color: DumpMateTheme.accentLime,
          ),
          title: Text(
            reminder.title,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              ref.read(reminderProvider.notifier).deleteReminder(reminder.id);
            },
          ),
        );
      },
    );
  }
}
