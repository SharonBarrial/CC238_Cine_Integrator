import 'package:flutter/material.dart';
import 'package:cinepy/UI/movie_list.dart';
import 'package:cinepy/UI/favorite_movies.dart'; // Importa el archivo

void main() {
  runApp(MyMovies());
}

class MyMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Movies",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Movies"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navega a la lista de películas
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieList()),
                );
              },
              child: Text("Movies"),
            ),
            SizedBox(height: 20), // Espaciado entre los botones
            ElevatedButton(
              onPressed: () {
                // Navega a la pantalla de favoritos
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                );
              },
              child: Text("My Favorites"),
            ),
          ],
        ),
      ),
    );
  }
}
