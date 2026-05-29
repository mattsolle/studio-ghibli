import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/repository/movie_repository.dart';

import 'package:studioghibli/screens/list/movie_list_event.dart';
import 'package:studioghibli/screens/list/movie_list_state.dart';

class MovieBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieBloc({
    required this.movieRepository,
  }) : super(
         const MovieListStateLoading(),
       ) {
    on<MovieListEventFetch>((event, emit) async {
      try {
        final movies = await movieRepository.getMovies();
        emit(MovieListStateLoaded(movies));
      } on Exception catch (_) {
        emit(const MovieListStateError());
      }
    });
  }

  MovieRepositoryInterface movieRepository;
}
