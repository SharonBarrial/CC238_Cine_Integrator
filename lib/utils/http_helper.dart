import 'package:http/http.dart' as http;
import 'package:cinepy/models/Movie.dart';
import 'dart:convert';
import 'dart:io';

class HttpHelper {
  final String urlBase = "https://api.themoviedb.org/3/movie";
  final String urlUpcoming = "/upcoming?";
  final String urlKey = "api_key=3cae426b920b29ed2fb1c0749f258325";
  final String urlPage = "&page=";
  //final String urlLanguage = "&language=es-ES";

  Future<List<Movie>> getUpcoming(String page) async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlPage + page;

    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];

      List<Movie> movies = moviesMap.map<Movie>((i)
      => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print(result.body);
      return []; //se retorna una lista vacia
    }
  }


}