class AllMusicModel {
  final String name;
  final String album;
  final String artist;
  final String url;
  final int id;
  final int duration;

  AllMusicModel({
    required this.name,
    required this.album,
    required this.artist,
    required this.url,
    required this.id,
    required this.duration,
  });

  factory AllMusicModel.fromJson(Map<String, dynamic> json) {
    return AllMusicModel(
      name: json['name'],
      album: json['album'],
      artist: json['artist'],
      url: json['url'],
      id: json['id'],
      duration: json['duration'],
    );
  }
}
