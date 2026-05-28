import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/core/injectables.dart';
import 'package:studioghibli/screens/list/movie_list_bloc.dart';
import 'package:studioghibli/screens/list/movie_list_events.dart';
import 'package:studioghibli/screens/list/movie_list_state.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<MovieBloc>()..add(const MovieEventFetch()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, state) {
              switch (state) {
                case MovieStateLoading():
                  return const ListScreenLoading();
                case MovieStateError():
                  return const Text('Oops something went wrong');
                case MovieStateLoaded():
                  return ListScreenLoaded(state: state);
              }
            },
          ),
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

  final MovieStateLoaded state;

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
              onTap: () {
                print(movie.id);
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
                              '${movie.originalTitle} (${movie.originalTitleRomanised})',
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Expanded(
                            child: Text(
                              '${movie.releaseDate} | ${movie.director} | ${movie.producer}',
                              maxLines: 2,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
