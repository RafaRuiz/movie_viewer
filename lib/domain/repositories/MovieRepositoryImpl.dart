import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';
import 'package:movie_viewer/data/services/MovieService.dart';
import 'package:movie_viewer/domain/repositories/MovieRepository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieService _service;

  MovieRepositoryImpl(this._service);

  @override
  Future<List<MovieAPIModel>> getMoviesFromQuery({String query}) {
    return _service.searchMovies(query: query).then((value) => value.results);
  }
}
