import 'package:dio/dio.dart';
import 'package:flutterappmovie/model/genre_response.dart';
import 'package:flutterappmovie/model/movies/movie_response.dart';
import 'package:flutterappmovie/model/person_response.dart';
import 'package:flutterappmovie/model/trailer_response.dart';

class MovieRepository {
  final String apiKey = "989854c6c0be60cc4b2c40eb24cddeda";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  final _getPlayingUrl = '$mainUrl/movie/now_playing';
  final _getMovieTrailersUrl = '$mainUrl/movie';
  final _getMoviesUrl = '$mainUrl/discover/movie';
  final _getGenresUrl = '$mainUrl/genre/movie/list';
  final _getTrendingPersonsUrl = '$mainUrl/trending/person/';
  final _getTopRatedUrl = '$mainUrl/movie/top_rated';
  final _getPopularUrl = '$mainUrl/movie/popular';
  final _getUpcomingUrl = '$mainUrl/movie/upcoming';
  final _getPopularPeopleUrl = '$mainUrl/person/popular';

  Future<MovieResponse> getTopMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getTopRatedUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPopularMovies() async {
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

  Future<MovieResponse> getUpcomingMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getUpcomingUrl, queryParameters: params);
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

  Future<PersonResponse> getTrendingPersons(String type) async {
    var params = {
      "api_key": apiKey,
    };
    try {
      Response response = await _dio.get(_getTrendingPersonsUrl + type,
          queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return PersonResponse.withError("$error");
    }
  }

  // TODO: Get movies by genre
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

  Future<TrailerResponse> getTrailerByMovie(int id) async {
    String trailersUrl = _getMovieTrailersUrl + "/$id/videos";
    print(trailersUrl);
    var params = {
      "api_key": apiKey,
      "language": "en-US",
    };
    try {
      Response response = await _dio.get(trailersUrl, queryParameters: params);
      print(response.data);
      return TrailerResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return TrailerResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPopularPersons() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getPopularPeopleUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return PersonResponse.withError("$error");
    }
  }
}
