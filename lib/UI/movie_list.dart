import 'package:cinepy/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:cinepy/utils/http_helper.dart';
import 'package:cinepy/models/Movie.dart';
import 'package:cinepy/UI/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List movies = [];
  int moviesCount = 0;
  int page = 1;
  bool loading = true;
  late HttpHelper helper;
  ScrollController? _scrollController;

  Future initialize() async {
    if (helper != null) {
      List? fetchedMovies = await helper.getUpcoming('2');
      setState(() {
        movies = fetchedMovies!;
        moviesCount = movies.length;
        loadMore();
        initScrollController();
      });
    }
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My movies!!!"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieRow(movies[index]);
        },
      ),
    );
  }

  //method loadmore
  void loadMore() {
    helper.getUpcoming(page.toString()).then((value) {
      movies += value;
      setState(() {
        moviesCount = movies.length;
        movies = movies;
        page++;
      });

      if (movies.length % 20 > 0) {
        loading = false;
      }
    });
  }

  //method initScrollController
  void initScrollController() {
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      if ((_scrollController!.position.pixels ==
              _scrollController!.position.maxScrollExtent) &&
          loading) {
        loadMore();
      }
    });
  }
}

class MovieRow extends StatefulWidget {
  final Movie movie;
  MovieRow(this.movie);

  @override
  State<MovieRow> createState() => _MovieRowState(movie);
}

class _MovieRowState extends State<MovieRow> {
  final Movie movie;
  _MovieRowState(this.movie);

  bool? favorite;
  DbHelper? dbHelper;

  @override
  void initState() {
    favorite = false;
    dbHelper = DbHelper();
    isFavorite(movie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: Hero(
          tag: 'poster_' + widget.movie.id.toString(),
          child: Image.network(
              'https://image.tmdb.org/t/p/w500' + movie.posterPath.toString()),
        ),
        title: Text(widget.movie.title.toString()),
        subtitle: Text(widget.movie.releaseDate.toString()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MovieDetail(widget.movie)),
          ).then((value) {
            isFavorite(movie);
          });
        },
        trailing: IconButton(
          icon: Icon(Icons.favorite),
          color: favorite! ? Colors.red : Colors.black38,
          onPressed: () {
            favorite!
                ? dbHelper!.deleteMovie(movie)
                : dbHelper!.insertMovie(movie);
            setState(() {
              favorite = !favorite!;
              movie.isFavorite = favorite;
            });
          },
        ),
      ),
    );
  }

  //method isFavorite
  Future isFavorite(Movie movie) async {
    await dbHelper!.openDb();
    favorite = await dbHelper!.isFavorite(movie);
    setState(() {
      movie.isFavorite = favorite;
    });
  }
}