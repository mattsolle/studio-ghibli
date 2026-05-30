import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/screens/detail/movie_detail_bloc.dart';
import 'package:studioghibli/screens/list/movie_list_bloc.dart';
import 'package:studioghibli/services/api_service.dart';

// Dependency Injector
final GetIt di = GetIt.instance;

void configureDependencies() {
  di
    ..registerLazySingleton<http.Client>(
      http.Client.new,
    )
    ..registerLazySingleton<ApiService>(
      () => ApiService(
        client: di<http.Client>(),
      ),
    )
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepository(apiService: di<ApiService>()),
    )
    ..registerFactory<MovieListBloc>(
      () => MovieListBloc(movieRepository: di<MovieRepository>()),
    )
    ..registerFactory<MovieDetailBloc>(
      () => MovieDetailBloc(movieRepository: di<MovieRepository>()),
    );
}
