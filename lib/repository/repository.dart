import 'package:dio/dio.dart';
import 'package:flutterappmovie/model/genre_response.dart';
import 'package:flutterappmovie/model/movie_response.dart';
import 'package:flutterappmovie/model/person_response.dart';

class MovieRepository {
  final String apiKey = "989854c6c0be60cc4b2c40eb24cddeda";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  final _getPopularUrl = '$mainUrl/movie/top_rated';
  final _getMoviesUrl = '$mainUrl/discover/movie';
  final _getPlayingUrl = '$mainUrl/movie/now_playing';
  final _getGenresUrl = '$mainUrl/genre/movie/list';
  final _getPersonsUrl = '$mainUrl/trending/person/week';

  Future<MovieResponse> getMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getPlayingUrl, queryParameters: params);

      print(response.data);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {
      "api_key": apiKey,
    };

    try {
      Response response =
          await _dio.get(_getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return PersonResponse.withError("$error");
    }
  }

  // TODO: Get movie by genre
  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
      "with_genres": id,
    };

    try {
      Response response =
          await _dio.get(_getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }
}
