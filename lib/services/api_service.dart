import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:studioghibli/models/movie.dart';

class ApiService {
  static const _baseUrl = 'ghibliapi.vercel.app';
  static const _films = '/films';

  final getAllMovies = Uri.https(_baseUrl, _films);

  Future<List<Movie>> getMovies() async {
    final client = http.Client();

    try {
      final response = await client.get(getAllMovies);
      if (response.statusCode >= 200 || response.statusCode < 300) {
        final dataList = jsonDecode(response.body) as List<dynamic>;
        final data = dataList.cast<Map<String, dynamic>>();
        final movies = data.map(Movie.fromJson).toList();
        return movies;
      } else {
        throw const HttpException('Invalid response');
      }
    } finally {
      client.close();
    }
  }
}
