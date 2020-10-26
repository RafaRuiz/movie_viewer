import 'package:bloc/bloc.dart';
import 'package:movie_viewer/domain/repositories/MovieRepository.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListEvent.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListState.dart';

class MovieViewerListBloc extends Bloc<MovieViewerListEvent, MovieViewerListState> {
  final MovieRepository _movieRepository;

  MovieViewerListBloc(this._movieRepository) : super(MovieViewerListInitialState());

  @override
  Stream<MovieViewerListState> mapEventToState(MovieViewerListEvent event) async* {
    if (event is MovieViewerListSearchEvent) {
      if (event.searchQuery.trim().isEmpty) {
        yield MovieViewerListInitialState();
      } else {
        yield MovieViewerListLoadingState();

        try {
          yield MovieViewerListSuccessLoadedState(await _movieRepository.getMoviesFromQuery(query: event.searchQuery));
        } catch (error) {
          yield MovieViewerListFailedState(error);
        }
      }
    } else if (event is MovieViewerSeeDetailsEvent) {
      yield MovieViewerListSeeDetailsState(event.movie);
    }
  }
}
