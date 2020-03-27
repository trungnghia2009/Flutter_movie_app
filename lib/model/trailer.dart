class Trailer {
  final String id;
  final String key;
  final String name;
  final String site;
  Trailer({
    this.id,
    this.key,
    this.name,
    this.site,
  });

  Trailer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        name = json['name'],
        site = json['site'];
}
