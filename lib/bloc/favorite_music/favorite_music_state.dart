import 'package:music_player/data/models/favorite_music_model.dart';

class FavoriteMusicState {
  final bool isFavorite;
  final List<FavoriteMusicModel> favorites;

  const FavoriteMusicState({required this.favorites, required this.isFavorite});

  FavoriteMusicState copyWith({
    bool? isFavorite,
    List<FavoriteMusicModel>? favorites,
  }) =>
      FavoriteMusicState(
        isFavorite: isFavorite ?? this.isFavorite,
        favorites: favorites?? this.favorites,
      );
}
