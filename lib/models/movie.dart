class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalTitleRomanised,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rtScore,
    required this.people,
    required this.species,
    required this.locations,
    required this.vehicles,
    required this.url,
  });

  Movie.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      title = json['title'] as String,
      originalTitle = json['original_title'] as String,
      originalTitleRomanised = json['original_title_romanised'] as String,
      description = json['description'] as String,
      director = json['director'] as String,
      producer = json['producer'] as String,
      releaseDate = json['release_date'] as String,
      runningTime = json['running_time'] as String,
      rtScore = json['rt_score'] as String,
      people = (json['people'] as List<dynamic>)
          .map((m) => m as String)
          .toList(),
      species = (json['species'] as List<dynamic>)
          .map((m) => m as String)
          .toList(),
      locations = (json['locations'] as List<dynamic>)
          .map((m) => m as String)
          .toList(),
      vehicles = (json['vehicles'] as List<dynamic>)
          .map((m) => m as String)
          .toList(),
      url = json['url'] as String;

  final String id;
  final String title;
  final String originalTitle;
  final String originalTitleRomanised;
  final String description;
  final String director;
  final String producer;
  final String releaseDate;
  // Running Time, in minutes
  final String runningTime;
  final String rtScore;
  final List<String> people;
  final List<String> species;
  final List<String> locations;
  final List<String> vehicles;
  final String url;
}
