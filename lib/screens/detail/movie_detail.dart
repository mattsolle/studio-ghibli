import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studioghibli/core/injectables.dart';
import 'package:studioghibli/screens/detail/movie_detail_bloc.dart';
import 'package:studioghibli/screens/detail/movie_detail_event.dart';
import 'package:studioghibli/screens/detail/movie_detail_state.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.movieId, super.key});

  final String movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<MovieDetailBloc>()
        ..add(
          MovieDetailEventFetch(movieId: movieId),
        ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Studio Ghibli'),
          leading: GestureDetector(
            onTap: context.pop,
            child: const Center(
              child: Text(
                'Back',
              ),
            ),
          ),
        ),
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (_, state) {
            switch (state) {
              case MovieDetailStateLoading():
                return const DetailScreenLoading();
              case MovieDetailStateError():
                return const Text('Oops something went wrong');
              case MovieDetailStateLoaded():
                return DetailScreenLoaded(state: state);
            }
          },
        ),
      ),
    );
  }
}

class DetailScreenLoading extends StatelessWidget {
  const DetailScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class DetailScreenError extends StatelessWidget {
  const DetailScreenError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Oops something went wrong');
  }
}

class DetailScreenLoaded extends StatelessWidget {
  const DetailScreenLoaded({required this.state, super.key});

  final MovieDetailStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              movie.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              '${movie.originalTitle} (${movie.originalTitleRomanised})',
              maxLines: 2,
              softWrap: true,
              textAlign: .center,
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
                    '${movie.releaseDate}'
                    ' | '
                    '${movie.director}'
                    ' | '
                    '${movie.producer}',
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
            Row(
              mainAxisAlignment: .center,
              children: [
                Expanded(
                  child: Text(
                    '${movie.runningTimeFormatted}'
                    ' | '
                    '${movie.rtScore} on Rotten Tomatoes',
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
    );
  }
}
