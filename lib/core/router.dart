import 'package:go_router/go_router.dart';

import 'package:studioghibli/screens/list/movie_list.dart';
import 'package:studioghibli/screens/detail/movie_detail.dart';

final router = GoRouter(
  initialLocation: '/movie',
  routes: [
    GoRoute(
      path: '/movie',
      builder: (context, state) => ListScreen(),
    ),
    GoRoute(
      path: '/movie/:movieId',
      builder: (context, state) => DetailScreen(
        movieId: state.pathParameters['movieId'] ?? '',
      ),
    ),
  ],
);
