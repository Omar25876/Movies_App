import 'dart:convert';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:http/http.dart' as http;
class ApiManager{
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String apiKey = '69c3325ee81b50be98642c899b90b4b6';

static Future<MoviesModel> getPopularMovies() async{
  var response = await http.get(Uri.parse('$baseUrl/3/movie/popular?api_key=$apiKey'));
  var json = jsonDecode(response.body);
  MoviesModel popularMoviesModel = MoviesModel.fromJson(json);
  return popularMoviesModel;
}

  static Future<MoviesModel> getNewReleasesMovies() async{
    try{
      var response = await http.get(Uri.parse('$baseUrl/3/movie/upcoming?api_key=$apiKey&language=en-US'));
      var json = jsonDecode(response.body);
      MoviesModel newReleasesMoviesModel = MoviesModel.fromJson(json);
      return newReleasesMoviesModel;
    }catch(e){
      throw Exception(e.toString());
    }
  }

  static Future<MoviesModel> getTopRatedMovies() async{
    var response = await http.get(Uri.parse('$baseUrl/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1'));
    var json = jsonDecode(response.body);
    MoviesModel topRatedMoviesModel = MoviesModel.fromJson(json);
    return topRatedMoviesModel;
  }

  static Future<Category> getCategoryMovies() async{
    var response = await http.get(Uri.parse('$baseUrl/3/genre/movie/list?api_key=$apiKey&language=en-US&page=1'));
    var json = jsonDecode(response.body);
    Category categoryModel = Category.fromJson(json);
    return categoryModel;
  }
  static Future<MoviesModel> getCategoryMoviesList(int? categotyId) async{
    var response = await http.get(Uri.parse('$baseUrl/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$categotyId&with_watch_monetization_types=flatrate'));
    var json = jsonDecode(response.body);
    MoviesModel categorylist = MoviesModel.fromJson(json);
    return categorylist;
  }


  static Future<MoviesModel> getSearchMovies(String? query) async{
    var response = await http.get(Uri.parse('$baseUrl/3/search/movie?api_key=$apiKey&language=en-US&query=$query&page=1'));
    var json = jsonDecode(response.body);
    MoviesModel categoryModel = MoviesModel.fromJson(json);
    return categoryModel;
  }

  static Future<MoviesModel> getSimilarMovies(num? movieId) async{
    var response = await http.get(Uri.parse('$baseUrl/3/movie/$movieId/similar?api_key=$apiKey&language=en-US&page=1'));
    var json = jsonDecode(response.body);
    MoviesModel categorylist = MoviesModel.fromJson(json);
    return categorylist;
  }











}