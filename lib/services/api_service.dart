import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:studioghibli/models/movie.dart';

abstract interface class ApiServiceInterface {
  Future<List<Movie>> getMovies();

  Future<Movie?> getMovie(String id);
}

class ApiService implements ApiServiceInterface {
  ApiService({required this.client});

  http.Client client;

  static const _baseUrl = 'ghibliapi.vercel.app';
  static const _films = '/films';

  final _getAllMoviesUri = Uri.https(_baseUrl, _films);
  Uri _getSpecificMovie(String id) => Uri.https(_baseUrl, '$_films/$id');

  @override
  Future<List<Movie>> getMovies() async {
    try {
      final response = await client.get(_getAllMoviesUri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final dataList = jsonDecode(response.body) as List<dynamic>;
        final data = dataList.cast<Map<String, dynamic>>();
        final movies = data.map(Movie.fromJson).toList();
        return movies;
      } else if (response.statusCode == 400) {
        throw const HttpException('Bad Request');
      } else if (response.statusCode == 404) {
        throw const HttpException('Not Found');
      } else {
        throw const HttpException('Unknown Error');
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<Movie?> getMovie(String id) async {
    final client = http.Client();

    try {
      // This isn't going to work and that's okay for now
      final response = await client.get(_getSpecificMovie(id));
      if (response.statusCode >= 200 || response.statusCode < 300) {
        final data = jsonDecode(response.body) as Map<String, dynamic>?;
        //final data = dataList.cast<Map<String, dynamic>>().first;
        final movie = data == null ? null : Movie.fromJson(data);
        return movie;
      } else {
        throw const HttpException('Invalid response');
      }
    } finally {
      client.close();
    }
  }
}
