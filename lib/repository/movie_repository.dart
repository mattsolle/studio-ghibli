import 'package:studioghibli/models/movie.dart';
import 'package:studioghibli/services/api_service.dart';

abstract interface class MovieRepositoryInterface {
  Future<List<Movie>> getMovies();
  Future<Movie?> getMovie(String id);
}

class MovieRepository implements MovieRepositoryInterface {
  MovieRepository({required this.apiService});

  final ApiServiceInterface apiService;

  @override
  Future<List<Movie>> getMovies() async {
    final movies = await apiService.getMovies();
    return movies;
  }

  @override
  Future<Movie?> getMovie(String id) async {
    if (id.trim().isEmpty) {
      throw ArgumentError.value(
        id,
        'id',
        'must not be empty.',
      );
    }
    final movies = await apiService.getMovie(id);
    return movies;
  }
}
