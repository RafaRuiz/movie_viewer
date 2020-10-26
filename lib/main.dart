import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_viewer/injection/InjectionModule.dart';
import 'package:movie_viewer/screens/movieviewerdetails/MovieViewerDetailsScreen.dart';
import 'package:movie_viewer/screens/movieviewerlist/MovieViewerListScreen.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListBloc.dart';

void main() {
  // Inject all the stuff!! 😝
  inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [get<BlocProvider<MovieViewerListBloc>>()],
      child: MaterialApp(
        title: 'Movie Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MovieViewerListScreen(),
      ),
    );
  }
}
