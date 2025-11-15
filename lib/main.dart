import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'routes/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DumpMateApp(),
    ),
  );
}

class DumpMateApp extends StatelessWidget {
  const DumpMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DumpMate',
      debugShowCheckedModeBanner: false,
      theme: DumpMateTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
