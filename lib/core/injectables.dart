import 'package:get_it/get_it.dart';
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/services/api_service.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepository(apiService: getIt<ApiService>()),
  );
}
