import 'dart:convert';
import 'package:flutter_app/model/MoviesModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/Api/Constanta.dart';

class ApiRequest {
  static dynamic _response;
  static dynamic _jsonData;
  static dynamic _listJson;

  static Future<List<MoviesModel>> fetchMovies(String type) async {
    List<MoviesModel> _moviesModel = List();
    try {
      _response = await http.get(
          "${Constanta.BASE_URL + type}?api_key=3f409df90d09bb04f75d97b5b22491d1&language=en-US");
      _jsonData = json.decode(_response.body);
      _listJson = _jsonData['results'] as List;
      for (var i in _listJson) {
        MoviesModel moviesModel = new MoviesModel(
            id: i['id'],
            title: i['title'],
            voteAverage: i['vote_average'].toString(),
            posterPath: i['poster_path'],
            date: i["release_date"],
            backDropPath: i['backdrop_path'],
            overView: i['overview']);
        _moviesModel.add(moviesModel);
      }
      if (_response.statusCode == 200) {
        return _moviesModel;
      } else {
        return null;
      }
    } catch (SocketException) {
      return null;
    }
  }

  static Future<List<String>> fetchGenres(int id) async {
    List<String> genres = List();
    _response = await http.get(Constanta.BASE_URL+"movie/"+
        id.toString() +
        "?api_key=3f409df90d09bb04f75d97b5b22491d1&language=en-US");
    _jsonData = json.decode(_response.body);
    _listJson = _jsonData['genres'] as List;
    for (var i in _listJson) {
      genres.add(i['name']);
    }
    return genres;
  }
}
