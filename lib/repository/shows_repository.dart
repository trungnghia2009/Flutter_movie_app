import 'package:dio/dio.dart';
import 'package:flutterappmovie/model/genre_response.dart';
import 'package:flutterappmovie/model/trailer_response.dart';
import '../model/shows/show_response.dart';

class ShowRepository {
  final String apiKey = "989854c6c0be60cc4b2c40eb24cddeda";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  final _getAiringToday = '$mainUrl/tv/airing_today';
  final _getShowTrailersUrl = '$mainUrl/tv';
  final _getShowsUrl = '$mainUrl/discover/tv';
  final _getGenresUrl = '$mainUrl/genre/tv/list';
  final _getTopRatedUrl = '$mainUrl/tv/top_rated';
  final _getPopularUrl = '$mainUrl/tv/popular';
  final _getOnTheAirUrl = '$mainUrl/tv/on_the_air';

  Future<ShowResponse> getAiringToday() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };
    try {
      Response response =
          await _dio.get(_getAiringToday, queryParameters: params);
      return ShowResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return ShowResponse.withError("$error");
    }
  }

  Future<TrailerResponse> getTrailerByShow(int id) async {
    String trailersUrl = _getShowTrailersUrl + "/$id/videos";
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

  Future<GenreResponse> getGenres() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getGenresUrl, queryParameters: params);
      print('.......Tran Trung NGhia');
      print(response.data);
      return GenreResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return GenreResponse.withError("$error");
    }
  }

  // TODO: Get shows by genre
  Future<ShowResponse> getShowsByGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
      "with_genres": id,
    };

    try {
      Response response = await _dio.get(_getShowsUrl, queryParameters: params);
      return ShowResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return ShowResponse.withError("$error");
    }
  }

  Future<ShowResponse> getTopShows() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getTopRatedUrl, queryParameters: params);
      return ShowResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return ShowResponse.withError("$error");
    }
  }

  Future<ShowResponse> getPopularMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getPopularUrl, queryParameters: params);
      return ShowResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return ShowResponse.withError("$error");
    }
  }

  Future<ShowResponse> getOnTheAirMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response =
          await _dio.get(_getOnTheAirUrl, queryParameters: params);
      return ShowResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return ShowResponse.withError("$error");
    }
  }
}
