import 'package:flutter/widgets.dart';
import 'package:movie_viewer/data/http/api_models/MovieQueryResponse.dart';

abstract class MovieService {
  Future<MovieQueryResponse> searchMovies({@required String query});
}