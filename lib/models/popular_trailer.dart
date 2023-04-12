class PopularTrailer {
  PopularTrailer({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  String iso6391;
  String iso31661;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  String publishedAt;
  String id;

  factory PopularTrailer.fromMap(Map<String, dynamic> map) {
    return PopularTrailer(
      iso6391: map['iso_639_1'],
      iso31661: map['iso_3166_1'],
      name: map['name'],
      key: map['key'],
      site: map['site'],
      size: map['size'],
      type: map['type'],
      official: map['official'],
      publishedAt: map['published_at'],
      id: map['id'],
    );
  }
}
