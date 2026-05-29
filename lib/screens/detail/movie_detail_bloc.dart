import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/screens/detail/movie_detail_event.dart';
import 'package:studioghibli/screens/detail/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required this.movieRepository,
  }) : super(
         const MovieDetailStateLoading(),
       ) {
    on<MovieDetailEventFetch>((event, emit) async {
      try {
        final movie = await movieRepository.getMovie(event.movieId);
        if (movie == null) {
          emit(const MovieDetailStateError());
        } else {
          emit(MovieDetailStateLoaded(movie));
        }
      } on Exception catch (_) {
        emit(const MovieDetailStateError());
      }
    });
  }

  MovieRepositoryInterface movieRepository;
}
