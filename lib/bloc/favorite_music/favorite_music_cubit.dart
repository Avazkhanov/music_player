import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_state.dart';
import 'package:music_player/data/local_database.dart';
import 'package:music_player/data/models/favorite_music_model.dart';

class FavoriteMusicCubit extends Cubit<FavoriteMusicState> {
  FavoriteMusicCubit()
      : super(const FavoriteMusicState(favorites: []));



  void addFavorite(FavoriteMusicModel favoriteMusicModel) async {
    await LocalDatabase.create(favoriteMusicModel);
  }

  void deleteFavorite(int id) async {
    await LocalDatabase.delete(id);
  }
  void readAllFavoriteMusic()async{
    List<FavoriteMusicModel> favorites = await LocalDatabase.readAllFavoriteMusic();
    emit(state.copyWith(favorites: favorites));
  }
}
