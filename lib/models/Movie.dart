class Movie {
  //El ? indica que la variable puede ser nula
  int? id;
  String? overview;
  double? popularity;
  String? posterPath;
  String? title;
  String? releaseDate;
  bool? isFavorite;

  //Se inicializan las variables de la clase Movie
  Movie(this.id, this.overview, this.popularity, this.posterPath, this.title,
      this.releaseDate, this.isFavorite);

  //Se crea un constructor que recibe un mapa de datos
  // y asigna los valores a las variables de la clase Movie
  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    title = json['title'];
    releaseDate = json['release_date'];
    isFavorite = json['isFavorite'];
  }

  //Se crea un metodo toJson que retorna un mapa de datos
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['isFavorite'] = this.isFavorite;
    return data;
  }

  //Se crea un metodo toMap que retorna un mapa de datos
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
    };
  }
}