import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/repository/movie_repository.dart';

import 'package:studioghibli/screens/list/movie_list_events.dart';
import 'package:studioghibli/screens/list/movie_list_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({
    required this.movieRepository,
  }) : super(
         const MovieStateLoading(),
       ) {
    on<MovieEventFetch>((event, emit) async {
      try {
        final movies = await movieRepository.getMovies();
        emit(MovieStateLoaded(movies));
      } on Exception catch (_) {
        emit(const MovieStateError());
      }
    });
  }

  MovieRepositoryInterface movieRepository;
}
