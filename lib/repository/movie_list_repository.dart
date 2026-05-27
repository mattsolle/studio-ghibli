import 'package:studioghibli/services/api_service.dart';
import 'package:studioghibli/models/movie.dart';

abstract interface class MovieListRepositoryInterface {
  Future<List<Movie>> getMovies();
  Future<Movie> getMovie(String id);
}

class MovieListRepository implements MovieListRepositoryInterface {
  MovieListRepository({required this.apiService});

  final ApiService apiService;

  @override
  Future<List<Movie>> getMovies() async {
    final movies = await apiService.getMovies();
    return movies;
  }

  @override
  Future<Movie> getMovie(String id) async {
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
