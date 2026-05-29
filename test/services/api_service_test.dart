import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioghibli/services/api_service.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'api_service_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late ApiService apiService;

  const testResponse = <String, dynamic>{
    'id': '2baf70d1-42bb-4437-b551-e5fed5a87abe',
    'title': 'Castle in the Sky',
    'original_title': '天空の城ラピュタ',
    'original_title_romanised': 'Tenkū no shiro Rapyuta',
    'description':
        'The orphan Sheeta inherited a mysterious crystal that links her to the'
        ' mythical sky-kingdom of Laputa. With the help of resourceful Pazu and'
        ' a rollicking band of sky pirates, she makes her way to the ruins of'
        ' the once-great civilization. Sheeta and Pazu must outwit the evil '
        "Muska, who plans to use Laputa's science to make himself ruler of the"
        ' world.',
    'director': 'Hayao Miyazaki',
    'producer': 'Isao Takahata',
    'release_date': '1986',
    'running_time': '124',
    'rt_score': '95',
    'people': ['https://ghibliapi.vercel.app/people/'],
    'species': [
      'https://ghibliapi.vercel.app/species/'
          'af3910a6-429f-4c74-9ad5-dfe1c4aa04f2',
    ],
    'locations': ['https://ghibliapi.vercel.app/locations/'],
    'vehicles': ['https://ghibliapi.vercel.app/vehicles/'],
    'url':
        'https://ghibliapi.vercel.app/films/'
        '2baf70d1-42bb-4437-b551-e5fed5a87abe',
  };

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(client: mockClient);
  });

  group('getMovies', () {
    test('returns parsed movies on 200', () async {
      // Arrange: tell the mock what to return for any GET
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(
          jsonEncode(
            [testResponse],
          ),
          200,
          // Needed because we're getting Japanese characters in response
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );

      // Act
      final movies = await apiService.getMovies();

      // Assert
      expect(movies, hasLength(1));
      expect(movies.first.title, 'Castle in the Sky');
      verify(
        mockClient.get(any),
      ).called(1); // optional: it actually hit the client
    });

    test('throws exception on 400', () async {
      // Arrange: tell the mock what to return for any GET
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(
          'Bad Request',
          400,
        ),
      );

      // Act
      Object? caught;
      try {
        await apiService.getMovies();
      } on Exception catch (e) {
        caught = e;
      }

      // Assert
      expect(caught, isA<HttpException>());
      verify(
        mockClient.get(any),
      ).called(1); // optional: it actually hit the client
    });

    test('throws exception on 404', () async {
      // Arrange: tell the mock what to return for any GET
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      // Act
      Object? caught;
      try {
        await apiService.getMovies();
      } on Exception catch (e) {
        caught = e;
      }

      // Assert
      expect(caught, isA<HttpException>());
      verify(
        mockClient.get(any),
      ).called(1); // optional: it actually hit the client
    });

    test('throws exception on unexpected status code', () async {
      // Arrange: tell the mock what to return for any GET
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(
          'Unknown',
          500,
        ),
      );

      // Act
      Object? caught;
      try {
        await apiService.getMovies();
      } on Exception catch (e) {
        caught = e;
      }

      // Assert
      expect(caught, isA<HttpException>());
      verify(
        mockClient.get(any),
      ).called(1); // optional: it actually hit the client
    });
  });
}
