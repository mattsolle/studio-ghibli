sealed class MovieDetailEvent {
  const MovieDetailEvent();
}

final class MovieDetailEventFetch extends MovieDetailEvent {
  const MovieDetailEventFetch({required this.movieId});

  final String movieId;
}
