import 'package:go_router/go_router.dart';

import 'package:studioghibli/screens/list.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ListScreen(),
    ),
  ],
);
