class Anime {
  final int id;
  final String title;
  final String? imageUrl;
  final String? synopsis;
  final List<String> genres;
  final double? score;
  final int? episodes;
  final String? status;
  final String? airedString;

  Anime({
    required this.id,
    required this.title,
    this.imageUrl,
    this.synopsis,
    this.genres = const [],
    this.score,
    this.episodes,
    this.status,
    this.airedString,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    var genresList = <String>[];
    if (json['genres'] != null) {
      json['genres'].forEach((genre) {
        genresList.add(genre['name']);
      });
    }

    return Anime(
      id: json['mal_id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      imageUrl: json['images']?['jpg']?['large_image_url'] ?? json['images']?['jpg']?['image_url'],
      synopsis: json['synopsis'],
      genres: genresList,
      score: (json['score'] != null) ? (json['score'] as num).toDouble() : null,
      episodes: json['episodes'],
      status: json['status'],
      airedString: json['aired']?['string'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': id,
      'title': title,
      'images': {
        'jpg': {
          'large_image_url': imageUrl,
        }
      },
      'synopsis': synopsis,
      'genres': genres.map((g) => {'name': g}).toList(),
      'score': score,
      'episodes': episodes,
      'status': status,
      'aired': {
        'string': airedString,
      }
    };
  }
}
