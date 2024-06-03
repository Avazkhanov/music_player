import 'package:music_player/data/models/favorite_music_model.dart';

class FavoriteMusicState {
  final List<FavoriteMusicModel> favorites;

  const FavoriteMusicState({required this.favorites});

  FavoriteMusicState copyWith({
    List<FavoriteMusicModel>? favorites,
  }) =>
      FavoriteMusicState(
        favorites: favorites ?? this.favorites,
      );
}
