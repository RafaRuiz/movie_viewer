import 'package:dio/dio.dart';
import 'package:movie_viewer/data/http/DioClient.dart';
import 'package:movie_viewer/data/http/TheMovieDBInfo.dart';
import 'package:movie_viewer/data/http/api_models/MovieQueryResponse.dart';
import 'package:movie_viewer/data/services/MovieService.dart';
import 'package:movie_viewer/injection/InjectionModule.dart';

class MovieServiceImpl extends MovieService {
  Dio get _dio => get<DioClient>().dio;

  @override
  Future<MovieQueryResponse> searchMovies({String query}) {
    return _dio.get(
      "search/movie",
      queryParameters: {
        API_KEY_KEY: THEMOVIEDB_API_KEY,
        QUERY_KEY: query,
      },
    ).then(
      (response) => MovieQueryResponse.fromJson(
        response.data,
      ),
    );
  }
}

const String API_KEY_KEY = "api_key";
const String QUERY_KEY = "query";
