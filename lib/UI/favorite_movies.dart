import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites"),
      ),
      body: Center(
        child: Text(
          "Here are your favorite movies!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
