import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studioghibli/core/injectables.dart';
import 'package:studioghibli/screens/list/movie_list_bloc.dart';
import 'package:studioghibli/screens/list/movie_list_event.dart';
import 'package:studioghibli/screens/list/movie_list_state.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<MovieListBloc>()..add(const MovieListEventFetch()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (_, state) {
            switch (state) {
              case MovieListStateLoading():
                return const ListScreenLoading();
              case MovieListStateError():
                return const Text('Oops something went wrong');
              case MovieListStateLoaded():
                return ListScreenLoaded(state: state);
            }
          },
        ),
      ),
    );
  }
}

class ListScreenLoading extends StatelessWidget {
  const ListScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class ListScreenError extends StatelessWidget {
  const ListScreenError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Oops something went wrong');
  }
}

class ListScreenLoaded extends StatelessWidget {
  const ListScreenLoaded({required this.state, super.key});

  final MovieListStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Studio Ghibli'),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final movie = state.movies[index];

            return GestureDetector(
              onTap: () async {
                await context.push('/movie/${movie.id}');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Expanded(
                            child: Text(
                              '${movie.originalTitle}'
                              ' (${movie.originalTitleRomanised})',
                              maxLines: 2,
                              softWrap: true,
                              textAlign: .center,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Text(
                        movie.description,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
            // return Text(
            //   (bloc.state as MovieStateLoaded).movies[index].title,
            // );
          }, childCount: state.movies.length),
        ),
      ],
    );
  }
}
