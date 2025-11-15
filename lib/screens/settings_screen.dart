import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/app_state_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DumpMateTheme.spacingMd),
        children: [
          // General Settings
          _SectionHeader(title: 'General'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Auto-scan Gallery'),
                  subtitle: const Text('Automatically scan for new screenshots'),
                  value: appState.autoScanEnabled,
                  activeColor: DumpMateTheme.accentLime,
                  onChanged: (value) {
                    ref.read(appStateProvider.notifier).toggleAutoScan(value);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Local-only Mode'),
                  subtitle: const Text('Keep all data on device'),
                  value: appState.localOnlyMode,
                  activeColor: DumpMateTheme.accentLime,
                  onChanged: (value) {
                    ref.read(appStateProvider.notifier).toggleLocalOnly(value);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Receive reminder notifications'),
                  value: appState.notificationsEnabled,
                  activeColor: DumpMateTheme.accentLime,
                  onChanged: (value) {
                    ref.read(appStateProvider.notifier).toggleNotifications(value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // OCR Settings
          _SectionHeader(title: 'OCR Settings'),
          Card(
            child: ListTile(
              title: const Text('OCR Languages'),
              subtitle: const Text('English, Hindi'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Language selection coming soon!')),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Appearance
          _SectionHeader(title: 'Appearance'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Theme'),
                  subtitle: const Text('Light mode'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Theme selection coming soon!')),
                    );
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Reduced Motion'),
                  subtitle: const Text('Minimize animations'),
                  value: appState.reducedMotion,
                  activeColor: DumpMateTheme.accentLime,
                  onChanged: (value) {
                    ref.read(appStateProvider.notifier).setReducedMotion(value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Storage
          _SectionHeader(title: 'Storage'),
          Card(
            child: ListTile(
              title: const Text('Clear Cache'),
              subtitle: const Text('Free up storage space'),
              trailing: const Icon(Icons.delete_outline),
              onTap: () {
                _showClearCacheDialog(context);
              },
            ),
          ),
          const SizedBox(height: 24),
          // Developer Options
          _SectionHeader(title: 'Developer'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Seed Sample Data'),
                  subtitle: const Text('Reload mock data (for development)'),
                  trailing: const Icon(Icons.refresh),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sample data is already loaded!'),
                        backgroundColor: DumpMateTheme.accentLime,
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Reset App'),
                  subtitle: const Text('Clear all data and start fresh'),
                  trailing: const Icon(Icons.warning_amber, color: Colors.red),
                  onTap: () {
                    _showResetDialog(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // About
          _SectionHeader(title: 'About'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Version'),
                  subtitle: const Text('1.0.0'),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Terms of Service'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache?'),
        content: const Text(
          'This will clear temporary files and free up storage space.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared!')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset App?'),
        content: const Text(
          'This will delete all your dumps, reminders, and settings. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('App reset (mock action - data not actually cleared)'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: DumpMateTheme.mutedText,
        ),
      ),
    );
  }
}
