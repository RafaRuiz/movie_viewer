import 'package:dio/dio.dart';
import 'package:movie_viewer/data/http/TheMovieDBInfo.dart';

class DioClient {
  Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        validateStatus: (status) => status >= 200 && status < 300,
        baseUrl: THEMOVIEDB_BASE_URL,
      ),
    );
  }
}
