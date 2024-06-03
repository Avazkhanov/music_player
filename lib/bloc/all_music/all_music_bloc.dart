import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/all_music/all_music_event.dart';
import 'package:music_player/bloc/all_music/all_music_state.dart';
import 'package:music_player/data/models/all_music_model.dart';

class AllMusicBloc extends Bloc<AllMusicEvent, AllMusicState> {
  AllMusicBloc() : super(AllMusicInitial()) {
    on<GetAllMusicEvent>(_getAllMusic);
    on<LoadedMusicEvent>(_loadedMusic);
  }


  _getAllMusic (GetAllMusicEvent event, emit)async {
    add(LoadedMusicEvent(allMusic: event.allMusic));
  }

  _loadedMusic (LoadedMusicEvent event,emit)async{
    emit(GetAllMusicState(allMusic: event.allMusic));
  }
}
