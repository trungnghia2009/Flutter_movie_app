import 'trailer.dart';

class TrailerResponse {
  final List<Trailer> trailers;
  final String error;
  TrailerResponse({
    this.trailers,
    this.error,
  });

  TrailerResponse.fromJson(Map<String, dynamic> json)
      : trailers = (json['results'] as List)
            .map((item) => Trailer.fromJson(item))
            .toList(),
        error = '';

  TrailerResponse.withError(String errorValue)
      : trailers = List(),
        error = errorValue;
}
