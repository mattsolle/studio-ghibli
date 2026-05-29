import 'package:mockito/annotations.dart';
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/screens/list/movie_list_bloc.dart';
import 'package:studioghibli/screens/list/movie_list_state.dart';
import 'package:test/test.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late MovieListBloc movieListBloc;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    movieListBloc = MovieListBloc(movieRepository: mockMovieRepository);
  });

  group('MovieListBloc', () {
    test('defaults to loading state', () {
      // Arrange and Act are captured by setup
      // Assert
      expect(movieListBloc.state.runtimeType, MovieListStateLoading);
    });

    // TODO: Bloc Tests
  });
}
