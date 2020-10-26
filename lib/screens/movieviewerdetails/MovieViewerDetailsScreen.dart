import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';

class MovieViewerDetailsScreen extends StatelessWidget {
  final MovieAPIModel movie;

  const MovieViewerDetailsScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        movie.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      decoration: _background(),
      child: Column(
        children: [
          _reviews(),
          _description(),
        ],
      ),
    );
  }

  BoxDecoration _background() {
    return BoxDecoration(
      color: Colors.black,
      image: DecorationImage(
        image: NetworkImage(
          movie.image,
        ),
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        fit: BoxFit.cover,
        repeat: ImageRepeat.noRepeat,
      ),
    );
  }

  Widget _reviews() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Icon(Icons.star),
          Text("Vote average: ${movie.rating} / 10.0")
        ],
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        movie.description,
        style: TextStyle(
          color: Colors.white,
          height: 1.5,
          fontSize: 18
        ),
      ),
    );
  }
}
