import 'dart:convert';
import 'package:movies_app/models/popular_movies_model.dart';
import 'package:http/http.dart' as http;
class ApiManager{
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String apiKey = '69c3325ee81b50be98642c899b90b4b6';

static Future<PopularMoviesModel> getPopularMovies() async{
  var response = await http.get(Uri.parse('$baseUrl/3/movie/popular?api_key=$apiKey'));
  var json = jsonDecode(response.body);
  PopularMoviesModel popularMoviesModel = PopularMoviesModel.fromJson(json);
  print(popularMoviesModel.results);
  return popularMoviesModel;
}

  static Future<Movies> getTopRatedMovies() async{
    var response = await http.get(Uri.parse('$baseUrl/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1'));
    var json = jsonDecode(response.body);
    Movies popularMoviesModel = Movies.fromJson(json);
    print(popularMoviesModel);
    return popularMoviesModel;
  }










}