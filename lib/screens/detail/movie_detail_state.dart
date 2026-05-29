import 'package:studioghibli/models/movie.dart';

sealed class MovieDetailState {
  const MovieDetailState();
}

final class MovieDetailStateLoading extends MovieDetailState {
  const MovieDetailStateLoading();
}

final class MovieDetailStateLoaded extends MovieDetailState {
  const MovieDetailStateLoaded(this.movie);

  final Movie movie;
}

final class MovieDetailStateError extends MovieDetailState {
  const MovieDetailStateError();
}
