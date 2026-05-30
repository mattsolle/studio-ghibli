import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioghibli/models/movie.dart';
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/screens/list/movie_list_bloc.dart';
import 'package:studioghibli/screens/list/movie_list_event.dart';
import 'package:studioghibli/screens/list/movie_list_state.dart';
import 'package:test/test.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late MovieListBloc movieListBloc;
  late MockMovieRepository mockMovieRepository;

  const testMovie = Movie(
    id: '2baf70d1-42bb-4437-b551-e5fed5a87abe',
    title: 'Castle in the Sky',
    originalTitle: '天空の城ラピュタ',
    originalTitleRomanised: 'Tenkū no shiro Rapyuta',
    description:
        'The orphan Sheeta inherited a mysterious crystal that links her to the'
        ' mythical sky-kingdom of Laputa. With the help of resourceful Pazu and'
        ' a rollicking band of sky pirates, she makes her way to the ruins of'
        ' the once-great civilization. Sheeta and Pazu must outwit the evil '
        "Muska, who plans to use Laputa's science to make himself ruler of the"
        ' world.',
    director: 'Hayao Miyazaki',
    producer: 'Isao Takahata',
    releaseDate: '1986',
    runningTime: '124',
    rtScore: '95',
    people: ['https://ghibliapi.vercel.app/people/'],
    species: [
      'https://ghibliapi.vercel.app/species/'
          'af3910a6-429f-4c74-9ad5-dfe1c4aa04f2',
    ],
    locations: ['https://ghibliapi.vercel.app/locations/'],
    vehicles: ['https://ghibliapi.vercel.app/vehicles/'],
    url:
        'https://ghibliapi.vercel.app/films/'
        '2baf70d1-42bb-4437-b551-e5fed5a87abe',
  );

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

    blocTest(
      'emits success when fetching successfully',
      build: () {
        when(
          mockMovieRepository.getMovies(),
        ).thenAnswer((_) async => Future.value([testMovie]));
        return movieListBloc;
      },
      act: (bloc) => bloc..add(const MovieListEventFetch()),
      expect: () => [
        isA<MovieListStateLoading>(),
        isA<MovieListStateLoaded>(),
      ],
    );

    blocTest(
      'emits error when passing in empty movieId',
      build: () {
        return movieListBloc;
      },
      act: (bloc) => bloc..add(const MovieListEventFetch()),
      expect: () => [isA<MovieListStateLoading>(), isA<MovieListStateError>()],
    );

    blocTest(
      'emits error when repository fails',
      build: () {
        when(
          mockMovieRepository.getMovies(),
        ).thenAnswer((_) async => []);
        return movieListBloc;
      },
      act: (bloc) => bloc..add(const MovieListEventFetch()),
      skip: 1,
      expect: () => [isA<MovieListStateError>()],
    );
  });
}
