import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_viewer/data/http/DioClient.dart';
import 'package:movie_viewer/data/services/MovieService.dart';
import 'package:movie_viewer/data/services/MovieServiceImpl.dart';
import 'package:movie_viewer/domain/repositories/MovieRepository.dart';
import 'package:movie_viewer/domain/repositories/MovieRepositoryImpl.dart';
import 'package:movie_viewer/screens/movieviewerlist/MovieViewerListScreen.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListBloc.dart';

final getIt = GetIt.instance;
final get = GetIt.instance.get;

void inject() {
  // Http Client
  getIt.registerSingleton<DioClient>(DioClient());

  // Movie service
  getIt.registerSingleton<MovieService>(MovieServiceImpl());

  // Movie repository
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl(get()));

  // Bloc providers
  // - MovieViewerListBloc
  getIt.registerFactory(
    () => BlocProvider<MovieViewerListBloc>(
      create: (_) => MovieViewerListBloc(get()),
      child: MovieViewerListScreen(),
    ),
  );
}
