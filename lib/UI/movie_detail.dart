import 'package:flutter/material.dart';
import 'package:cinepy/models/Movie.dart';
import 'package:cinepy/utils/db_helper.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;
  MovieDetail(this.movie);

  @override
  State<MovieDetail> createState() => _MovieDetailState(movie);
}

class _MovieDetailState extends State<MovieDetail> {
  final Movie movie;
  late DbHelper dbHelper;
  String path = "";

  _MovieDetailState(this.movie);

  @override
  void initState() {
    dbHelper = DbHelper();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: Hero(
                  tag: 'poster_' + movie.id.toString(),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500' + movie.posterPath.toString(),
                    height: height / 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}