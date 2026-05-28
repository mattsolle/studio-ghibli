import 'package:flutter/material.dart';

import 'package:studioghibli/core/router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: .fromSeed(
      seedColor: Colors.deepPurple,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Studio Ghibli',
      theme: base.copyWith(
        cardTheme: base.cardTheme.copyWith(
          elevation: 2,
          margin: const EdgeInsets.all(16),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
