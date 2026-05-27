import 'package:studioghibli/models/movie.dart';

sealed class MovieState {
  const MovieState();
}

final class MovieStateLoading extends MovieState {
  const MovieStateLoading();
}

final class MovieStateLoaded extends MovieState {
  const MovieStateLoaded(this.movies);

  final List<Movie> movies;
}

final class MovieStateError extends MovieState {
  const MovieStateError();
}
