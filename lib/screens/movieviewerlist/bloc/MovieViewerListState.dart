import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';

abstract class MovieViewerListState {}

/// Initial state when it's uninitialized
class MovieViewerListInitialState extends MovieViewerListState {}

/// Sets the loading state (for example when the user types
/// and it sends an event, the UI will show a Loading state
/// while the server answers
class MovieViewerListLoadingState extends MovieViewerListState {}

/// State where the info is already brought back. The UI
/// will display the list of information
class MovieViewerListSuccessLoadedState extends MovieViewerListState {
  final List<MovieAPIModel> movies;

  MovieViewerListSuccessLoadedState(this.movies);
}

/// State where the info couldn't load for any reason.
/// It'll display the error accordingly
class MovieViewerListFailedState extends MovieViewerListState {
  final dynamic error;

  MovieViewerListFailedState(this.error);
}

/// State where the user goes to another
/// screen to see the details of a movie.
class MovieViewerListSeeDetailsState extends MovieViewerListState {
  final MovieAPIModel movie;

  MovieViewerListSeeDetailsState(this.movie);
}
