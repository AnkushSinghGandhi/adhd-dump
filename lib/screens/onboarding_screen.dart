import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _autoScanEnabled = false;
  bool _cloudSyncEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DumpMateTheme.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              // Logo
              Center(
                child: Container(
                  width: 80,
                  height: 80,
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
                        fontSize: 48,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Center(
                child: Text(
                  'Welcome to DumpMate',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Your ADHD-friendly screenshot & thought manager',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              // Features
              _FeatureItem(
                icon: Icons.photo_library_outlined,
                title: 'Auto-scan Gallery',
                description: 'Automatically organize your screenshots',
              ),
              const SizedBox(height: 16),
              _FeatureItem(
                icon: Icons.lightbulb_outline,
                title: 'Smart Suggestions',
                description: 'Get AI-powered recommendations',
              ),
              const SizedBox(height: 16),
              _FeatureItem(
                icon: Icons.notifications_outlined,
                title: 'Reminders',
                description: 'Never forget important things',
              ),
              const SizedBox(height: 16),
              _FeatureItem(
                icon: Icons.lock_outlined,
                title: 'Local-first',
                description: 'Your data stays on your device',
              ),
              const Spacer(),
              // Options
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Enable Auto-scan'),
                        subtitle: const Text('Requires gallery permission'),
                        value: _autoScanEnabled,
                        activeColor: DumpMateTheme.accentLime,
                        onChanged: (value) {
                          setState(() {
                            _autoScanEnabled = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      SwitchListTile(
                        title: const Text('Enable Cloud Sync (Demo)'),
                        subtitle: const Text('Optional - keep local-only for privacy'),
                        value: _cloudSyncEnabled,
                        activeColor: DumpMateTheme.accentLime,
                        onChanged: (value) {
                          setState(() {
                            _cloudSyncEnabled = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // CTA Button
              PrimaryButton(
                text: 'Get Started',
                onPressed: () {
                  context.go('/home');
                },
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                text: 'Skip',
                onPressed: () {
                  context.go('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: DumpMateTheme.accentLime.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: DumpMateTheme.primaryBlack,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
