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
        if (response.body.trim().isEmpty) {
          return [];
        }
        final json = jsonDecode(response.body);
        if (json is! List<dynamic>) {
          return [];
        }
        final data = json.cast<Map<String, dynamic>>();
        final movies = data.map(Movie.fromJson).toList();
        return movies;
      } else if (response.statusCode == 400) {
        throw const HttpException('Bad Request');
      } else if (response.statusCode == 404) {
        throw const HttpException('Not Found');
      } else {
        throw const HttpException('Unknown Error');
      }
    } on Exception catch (_) {
      throw const HttpException('Unknown Error');
    }
  }

  @override
  Future<Movie?> getMovie(String id) async {
    try {
      final url = _getSpecificMovie(id);
      final response = await client.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.trim().isEmpty) {
          return null;
        }
        final json = jsonDecode(response.body);
        if (json is! Map<String, dynamic>? || json!.isEmpty) {
          return null;
        }
        //final data = dataList.cast<Map<String, dynamic>>().first;
        final movie = Movie.fromJson(json);
        return movie;
      } else {
        throw const HttpException('Invalid response');
      }
    } on Exception catch (_) {
      throw const HttpException('Unknown Error');
    }
  }
}
