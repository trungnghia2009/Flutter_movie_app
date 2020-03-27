import '../shows/show.dart';

class ShowResponse {
  final List<Show> shows;
  final String error;

  ShowResponse({
    this.shows,
    this.error,
  });

  ShowResponse.fromJson(Map<String, dynamic> json)
      : shows = (json["results"] as List)
            .map((show) => Show.fromJson(show))
            .toList(),
        error = '';

  ShowResponse.withError(String errorValue)
      : shows = List(),
        error = errorValue;
}
