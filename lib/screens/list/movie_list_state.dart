import 'package:studioghibli/models/movie.dart';

sealed class MovieListState {
  const MovieListState();
}

final class MovieListStateLoading extends MovieListState {
  const MovieListStateLoading();
}

final class MovieListStateLoaded extends MovieListState {
  const MovieListStateLoaded(this.movies);

  final List<Movie> movies;
}

final class MovieListStateError extends MovieListState {
  const MovieListStateError();
}
