import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/all_music/all_music_bloc.dart';
import 'package:music_player/bloc/all_music/all_music_event.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_cubit.dart';
import 'package:music_player/data/models/all_music_model.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:music_player/utils/images/app_images.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final audioQuery = OnAudioQuery();
  List<SongModel> allMusic = [];
  final List<AllMusicModel> allMPMusic = [];

  _getRequest() async {
    bool hasPermission = await audioQuery.permissionsStatus();
    if (!hasPermission) {
      await audioQuery.permissionsRequest();
    }
    allMusic = await audioQuery.querySongs();

    for (var i in allMusic) {
      if (i.fileExtension == "mp3") {
        allMPMusic.add(
          AllMusicModel(
            name: i.displayName,
            album: i.album ?? "",
            artist: i.artist ?? "",
            url: i.uri ?? "",
            id: i.id,
            duration: i.duration ?? 0,
          ),
        );
      }else if (i.fileExtension == "flac"){
        allMPMusic.add(
          AllMusicModel(
            name: i.displayName,
            album: i.album ?? "",
            artist: i.artist ?? "",
            url: i.uri ?? "",
            id: i.id,
            duration: i.duration ?? 0,
          ),
        );
      }
    }
    if(!mounted) return;
    context.read<AllMusicBloc>().add(GetAllMusicEvent(allMusic: allMPMusic));
    context.read<FavoriteMusicCubit>().readAllFavoriteMusic();
    await Future.delayed(const Duration(seconds: 1),(){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    _getRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.logo,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
