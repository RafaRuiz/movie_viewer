import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';

abstract class MovieViewerListEvent {}

class MovieViewerListSearchEvent extends MovieViewerListEvent {
  final String searchQuery;

  MovieViewerListSearchEvent(this.searchQuery);
}

class MovieViewerSeeDetailsEvent extends MovieViewerListEvent {
  final MovieAPIModel movie;

  MovieViewerSeeDetailsEvent(this.movie);
}