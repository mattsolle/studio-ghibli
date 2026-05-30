import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioghibli/models/movie.dart';
import 'package:studioghibli/screens/detail/movie_detail.dart';
import 'package:studioghibli/screens/detail/movie_detail_bloc.dart';
import 'package:studioghibli/screens/detail/movie_detail_state.dart';

import 'movie_detail_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieDetailBloc>()])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
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
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  setUpAll(() {
    // Mockito needs it
    provideDummy<MovieDetailState>(const MovieDetailStateLoading());
  });

  group('MovieDetail', () {
    testWidgets('has an initial loading state', (tester) async {
      // Arrange
      when(
        mockMovieDetailBloc.state,
      ).thenReturn(const MovieDetailStateLoading());
      const widget = DetailScreen(movieId: '123');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MovieDetailBloc>(
            create: (_) => mockMovieDetailBloc,
            child: widget,
          ),
        ),
      );

      // CircularProgressIndicator doesn't end
      await tester.pump();

      // Assert
      final loading = find.byType(CircularProgressIndicator);
      expect(loading, findsOneWidget);
    });

    testWidgets('has an error state', (tester) async {
      // Arrange
      when(mockMovieDetailBloc.state).thenReturn(const MovieDetailStateError());
      const widget = DetailScreen(movieId: '123');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MovieDetailBloc>(
            create: (_) => mockMovieDetailBloc,
            child: widget,
          ),
        ),
      );

      // CircularProgressIndicator doesn't end
      await tester.pump();

      // Assert
      final error = find.textContaining('wrong');
      expect(error, findsOneWidget);
    });

    testWidgets('has an success state', (tester) async {
      // Arrange
      when(mockMovieDetailBloc.state).thenReturn(
        const MovieDetailStateLoaded(
          testMovie,
        ),
      );
      const widget = DetailScreen(movieId: '123');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MovieDetailBloc>(
            create: (_) => mockMovieDetailBloc,
            child: widget,
          ),
        ),
      );

      // CircularProgressIndicator doesn't end
      await tester.pump();

      // Assert
      final error = find.textContaining('Castle');
      expect(error, findsOneWidget);
    });
  });
}
