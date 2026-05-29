import 'package:mockito/annotations.dart';
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/screens/detail/movie_detail_bloc.dart';
import 'package:studioghibli/screens/detail/movie_detail_state.dart';
import 'package:test/test.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    movieDetailBloc = MovieDetailBloc(movieRepository: mockMovieRepository);
  });

  group('MovieDetailBloc', () {
    test('defaults to loading state', () {
      // Arrange and Act are captured by setup
      // Assert
      expect(movieDetailBloc.state.runtimeType, MovieDetailStateLoading);
    });

    // TODO: Bloc Tests
  });
}
