class FavoriteMusicModel {
  final int? id;
  final int musicId;

  FavoriteMusicModel({
    this.id,
    required this.musicId,
  });

  factory FavoriteMusicModel.fromJson(Map<String, dynamic> json) {
    return FavoriteMusicModel(
      id: json['id'],
      musicId: json['music_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'music_id': musicId,
    };
  }

  FavoriteMusicModel copyWith({
    int? id,
    int? musicId,
  }) {
    return FavoriteMusicModel(
      id: id ?? this.id,
      musicId: musicId ?? this.musicId,
    );
  }
}
