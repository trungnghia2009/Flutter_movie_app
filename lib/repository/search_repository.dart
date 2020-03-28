import 'package:dio/dio.dart';
import 'package:flutterappmovie/model/movies/movie_response.dart';
import 'package:flutterappmovie/model/person_response.dart';
import 'package:flutterappmovie/model/shows/show_response.dart';

class SearchRepository {
  final String apiKey = "989854c6c0be60cc4b2c40eb24cddeda";
  static String mainUrl = "https://api.themoviedb.org/3/search";
  final Dio _dio = Dio();

  final _getSearchMoviesUrl = '$mainUrl/movie';
  final _getSearchPeopleUrl = '$mainUrl/person';
  final _getSearchShowsUrl = '$mainUrl/tv';

  Future<MovieResponse> getMovies(String query) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
      "query": query,
    };

    try {
      Response response =
          await _dio.get(_getSearchMoviesUrl, queryParameters: params);

      print(response.data);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<ShowResponse> getShows(String query) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
      "include_adult": "true",
      "query": query,
    };

    try {
      Response response =
          await _dio.get(_getSearchShowsUrl, queryParameters: params);
      return ShowResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return ShowResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPeople(String query) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
      "include_adult": "true",
      "query": query,
    };

    try {
      Response response =
          await _dio.get(_getSearchPeopleUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return PersonResponse.withError("$error");
    }
  }
}
