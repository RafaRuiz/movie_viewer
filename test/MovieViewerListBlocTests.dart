// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';
import 'package:movie_viewer/domain/repositories/MovieRepository.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListBloc.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListEvent.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListState.dart';

class MovieRepositoryMock extends Mock implements MovieRepository {}

void main() {
  MovieRepository movieRepositoryMock;
  MovieViewerListBloc subject;

  setUp(() {
    movieRepositoryMock = MovieRepositoryMock();
    subject = MovieViewerListBloc(movieRepositoryMock);
  });

  tearDown(() {
    subject?.close();
  });

  test('Initial state', () {
    assert(subject.state is MovieViewerListInitialState);
  });

  test('On search successful, it showed loading, then success', () {
    List<MovieAPIModel> mockMovies = [MovieAPIModel("poster_path", "title", "description", 1.0)];
    String query = "test movie";
    when(movieRepositoryMock.getMoviesFromQuery(query: query)).thenAnswer((_) => Future.value(mockMovies));

    subject.add(MovieViewerListSearchEvent(query));

    final expectedResponse = [
      isInstanceOf<MovieViewerListLoadingState>(),
      isInstanceOf<MovieViewerListSuccessLoadedState>(),
    ];

    expectLater(subject, emitsInOrder(expectedResponse));
  });

  test('On empty search, it shows the initial state', () {
    String query = "";
    subject.add(MovieViewerListSearchEvent(query));

    expectLater(subject, emits(isInstanceOf<MovieViewerListInitialState>()));
  });

  test('On non trimmed empty search, it shows the initial state', () {
    String query = "  ";
    subject.add(MovieViewerListSearchEvent(query));

    expectLater(subject, emits(isInstanceOf<MovieViewerListInitialState>()));
  });

  test('On search failed, it showed loading, then failed', () {
    String query = "test movie";
    when(movieRepositoryMock.getMoviesFromQuery(query: query)).thenThrow(DioError());

    subject.add(MovieViewerListSearchEvent(query));

    final List<dynamic> expectedResponse = [
      isInstanceOf<MovieViewerListLoadingState>(),
      isInstanceOf<MovieViewerListFailedState>(),
    ];

    expectLater(subject, emitsInOrder(expectedResponse));
  });

  test('On want to see details, it emits a see details', () {
    MovieAPIModel movie = MovieAPIModel("poster_path", "title", "description", 1.0);
    subject.add(MovieViewerSeeDetailsEvent(movie));

    expectLater(subject, emits(isInstanceOf<MovieViewerListSeeDetailsState>()));
  });
}
