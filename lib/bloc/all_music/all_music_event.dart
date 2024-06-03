import 'package:music_player/data/models/all_music_model.dart';

abstract class AllMusicEvent {}

class GetAllMusicEvent extends AllMusicEvent {
  final List<AllMusicModel> allMusic;

  GetAllMusicEvent({required this.allMusic});
}
class LoadedMusicEvent extends AllMusicEvent {
  final List<AllMusicModel> allMusic;

  LoadedMusicEvent({required this.allMusic});
}
