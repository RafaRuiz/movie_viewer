import 'package:flutter/widgets.dart';
import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';

abstract class MovieRepository {
  Future<List<MovieAPIModel>> getMoviesFromQuery({@required String query});
}