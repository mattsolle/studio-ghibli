import 'package:go_router/go_router.dart';
import 'package:studioghibli/screens/detail/movie_detail.dart';
import 'package:studioghibli/screens/list/movie_list.dart';

final router = GoRouter(
  initialLocation: '/movie',
  routes: [
    GoRoute(
      path: '/movie',
      builder: (context, state) => const ListScreenProvider(),
    ),
    GoRoute(
      path: '/movie/:movieId',
      builder: (context, state) => DetailScreenProvider(
        movieId: state.pathParameters['movieId'] ?? '',
      ),
    ),
  ],
);
