import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioghibli/models/movie.dart';
import 'package:studioghibli/repository/movie_repository.dart';
import 'package:studioghibli/services/api_service.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<ApiService>()])
import 'movie_repository_test.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late MovieRepository repository;

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
    mockApiService = MockApiService();
    repository = MovieRepository(apiService: mockApiService);
  });

  group('Repository', () {
    group('getMovies', () {
      test('returns list of movies when response contains movies', () async {
        // Arrange: tell the mock what to return for any GET
        when(mockApiService.getMovies()).thenAnswer(
          (_) async => [testMovie],
        );

        // Act
        final movies = await mockApiService.getMovies();

        // Assert
        expect(movies, hasLength(1));
        expect(movies.first.title, 'Castle in the Sky');
      });

      test('returns empty list when no movies return', () async {
        // Arrange: tell the mock what to return for any GET
        when(mockApiService.getMovies()).thenAnswer(
          (_) async => [],
        );

        // Act
        final movies = await mockApiService.getMovies();

        // Assert
        expect(movies, hasLength(0));
      });
    });
    group('getMovie', () {
      test('returns movie when response contain movie', () async {
        // Arrange: tell the mock what to return for any GET
        when(mockApiService.getMovie(any)).thenAnswer(
          (_) async => testMovie,
        );

        // Act
        final movie = await mockApiService.getMovie('123');

        // Assert
        expect(movie, isNotNull);
        expect(movie!.title, 'Castle in the Sky');
      });

      test('returns null when no movie return', () async {
        // Arrange: tell the mock what to return for any GET
        when(mockApiService.getMovie(any)).thenAnswer(
          (_) async => null,
        );

        // Act
        final movie = await mockApiService.getMovie('123');

        // Assert
        expect(movie, null);
      });
    });
  });
}
