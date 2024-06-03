import 'package:music_player/data/models/all_music_model.dart';

abstract class AllMusicState {}

class AllMusicInitial extends AllMusicState {}

class GetAllMusicState extends AllMusicState {
  final List<AllMusicModel> allMusic;

  GetAllMusicState({required this.allMusic});
}
