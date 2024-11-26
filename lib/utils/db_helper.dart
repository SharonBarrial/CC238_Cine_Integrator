import 'package:cinepy/models/Movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  // Atributos de la clase
  final int version = 1;
  Database? db;

  // Constructor privado
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  // Metodo factory que retorna una instancia de la clase
  factory DbHelper() {
    return _dbHelper;
  }

  // Metodo que abre la base de datos
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'movies.db'),
          onCreate: (db, version) {
            db.execute(
                'CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT)');
          }, version: version);
    }
    return db!;
  }

  // Metodo que inserta una pelicula en la base de datos
  Future<int> insertMovie(Movie movie) async {
    int id = await db!.insert('movies', movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Metodo que elimina una pelicula de la base de datos
  Future<int> deleteMovie(Movie movie) async {
    int result =
    await db!.delete('movies', where: 'id = ?', whereArgs: [movie.id]);
    return result;
  }

  //Metodo que edita una pelicula en la base de datos
  Future<int> editMovie(Movie movie) async {
    int result = await db!.update('movies', movie.toMap(),
        where: 'id = ?', whereArgs: [movie.id]);
    return result;
  }

  // Metodo que verifica si una pelicula es favorita
  Future<bool> isFavorite(Movie movie) async {
    final List<Map<String, dynamic>> maps =
    await db!.query('movies', where: 'id = ?', whereArgs: [movie.id]);
    return maps.length > 0;
  }

  // Metodo que retorna todas las peliculas favoritas
  Future<List<Movie>> getFavorites() async {
    final List<Map<String, dynamic>> maps = await db!.query('movies');
    return List.generate(maps.length, (i) {
      return Movie(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['overview'],
        maps[i]['popularity'],
        maps[i]['poster_path'],
        maps[i]['release_date'],
        maps[i]['isFavorite'],
      );
    });
  }


}