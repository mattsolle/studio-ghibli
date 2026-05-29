import 'package:get_it/get_it.dart';
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/screens/detail/movie_detail_bloc.dart';
import 'package:studioghibli/screens/list/movie_list_bloc.dart';
import 'package:studioghibli/services/api_service.dart';

// Dependency Injector
final GetIt di = GetIt.instance;

void configureDependencies() {
  di
    ..registerLazySingleton<ApiService>(ApiService.new)
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
