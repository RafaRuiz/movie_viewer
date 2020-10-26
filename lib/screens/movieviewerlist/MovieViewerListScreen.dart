import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';
import 'package:movie_viewer/screens/movieviewerdetails/MovieViewerDetailsScreen.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListBloc.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListEvent.dart';
import 'package:movie_viewer/screens/movieviewerlist/bloc/MovieViewerListState.dart';
import 'package:movie_viewer/utils/Debouncer.dart';

class MovieViewerListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieViewerListBloc, MovieViewerListState>(
      listener: (context, state) {
        if (state is MovieViewerListSeeDetailsState) {
          _navigateToMovieDetails(context, state.movie);
        }
      },
      child: Scaffold(
        appBar: _appBar(),
        body: _body(context),
      ),
    );
  }

  MovieViewerListBloc _bloc(BuildContext context) => context.bloc<MovieViewerListBloc>();

  AppBar _appBar() {
    return AppBar(
      title: Text("Movie Viewer"),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _searchBar(context),
        _loadingWidget(context),
        _listOfMoviesState(context),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    Debouncer searchDebouncer = Debouncer(milliseconds: 1500);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (newText) => searchDebouncer.run(
          () {
            _bloc(context).add(MovieViewerListSearchEvent(newText));
          },
        ),
        decoration: InputDecoration(
          hintText: "Search...",
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return BlocBuilder<MovieViewerListBloc, MovieViewerListState>(builder: (_, state) {
      if (state is MovieViewerListLoadingState) {
        return Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _listOfMoviesState(BuildContext context) {
    return BlocBuilder<MovieViewerListBloc, MovieViewerListState>(
      // Build only when it's not a "See details event"
      buildWhen: (_, current) {
        return !(current is MovieViewerListSeeDetailsState);
      },
      builder: (_, state) {
        if (state is MovieViewerListSuccessLoadedState) {
          return _listOfMovies(context, state.movies);
        } else if (state is MovieViewerListFailedState) {
          return _failedWidget(state.error);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _failedWidget(dynamic error) {
    return Expanded(
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error),
            SizedBox(
              height: 10,
            ),
            Text(_errorTextForError(error)),
          ],
        ),
      ),
    );
  }

  String _errorTextForError(dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.DEFAULT) {
        return "There's an error with your connection";
      } else {
        String moreInfo = error.message;
        return "There's an error with this request: \n$moreInfo";
      }
    } else {
      return "There's an unknown error";
    }
  }

  Expanded _listOfMovies(BuildContext context, List<MovieAPIModel> movies) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return _movieWidget(context, movies[index]);
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _movieWidget(BuildContext context, MovieAPIModel movie) {
    return InkWell(
      onTap: () {
        _bloc(context).add(MovieViewerSeeDetailsEvent(movie));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                child: Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded)
          ],
        ),
      ),
    );
  }

  void _navigateToMovieDetails(BuildContext context, MovieAPIModel movie) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieViewerDetailsScreen(movie);
    }));
  }
}
