import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:studioghibli/models/movie.dart';

class ApiService {
  static const _baseUrl = 'ghibliapi.vercel.app';
  static const _films = '/films';

  final getAllMovies = Uri.https(_baseUrl, _films);
  Uri getSpecificMovie(String id) => Uri.https(_baseUrl, '$_films/$id');

  Future<List<Movie>> getMovies() async {
    final client = http.Client();

    try {
      final response = await client.get(getAllMovies);
      if (response.statusCode >= 200 || response.statusCode < 300) {
        final dataList = jsonDecode(response.body) as List<dynamic>;
        final data = dataList.cast<Map<String, dynamic>>();
        final movies = data.map(Movie.fromJson).toList();
        this.getMovie(movies.first.id);
        return movies;
      } else {
        throw const HttpException('Invalid response');
      }
    } finally {
      client.close();
    }
  }

  Future<Movie> getMovie(String id) async {
    final client = http.Client();

    try {
      final response = await client.get(getAllMovies);
      if (response.statusCode >= 200 || response.statusCode < 300) {
        final dataList = (jsonDecode(response.body) as List<dynamic>);
        final data = dataList.cast<Map<String, dynamic>>().first;
        final movie = Movie.fromJson(data);
        return movie;
      } else {
        throw const HttpException('Invalid response');
      }
    } finally {
      client.close();
    }
  }
}
