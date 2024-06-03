import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/bloc/all_music/all_music_bloc.dart';
import 'package:music_player/bloc/all_music/all_music_state.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_cubit.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_state.dart';
import 'package:music_player/screens/favorite_music/widgets/favorite_music_appbar.dart';
import 'package:music_player/screens/widgets/no_data_item.dart';
import 'package:music_player/screens/widgets/recently_played_item.dart';
import 'package:music_player/screens/home/widgets/song_image_creator_item.dart';
import 'package:music_player/utils/styles/app_style.dart';

class FavoriteMusicScreen extends StatefulWidget {
  const FavoriteMusicScreen({super.key});

  @override
  State<FavoriteMusicScreen> createState() => _FavoriteMusicScreenState();
}

class _FavoriteMusicScreenState extends State<FavoriteMusicScreen> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("1");
  final AssetsAudioPlayer previousAudioPlayer = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const FavoriteMusicAppBar(),
      body: BlocBuilder<AllMusicBloc, AllMusicState>(
        builder: (context, allMusicState) {
          if (allMusicState is GetAllMusicState) {
            return BlocBuilder<FavoriteMusicCubit, FavoriteMusicState>(
              builder: (context, state) {
                final favorites =
                    context.read<FavoriteMusicCubit>().state.favorites;
                final favoriteAudios = allMusicState.allMusic
                    .where((music) =>
                        favorites.any((fav) => fav.musicId == music.id))
                    .map((music) => Audio.file(
                          music.url,
                          metas: Metas(
                            title: music.name,
                            artist: music.artist,
                            id: music.id.toString(),
                          ),
                        ))
                    .toList();

                if (favoriteAudios.isEmpty) {
                  return const NoDataItem(
                      message: "Siz hali sevimli qo'shiqlar qo'shmadingiz");
                }

                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final music = favoriteAudios[index].metas;
                    final musicId = int.parse(music.id!);
                    return ListTile(
                      onTap: () {
                        previousAudioPlayer.stop();
                        audioPlayer.open(
                          Playlist(audios: favoriteAudios, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                        );
                      },
                      leading: SongImageCreatorItem(id: musicId),
                      title: Text(music.title!, style: AppStyle.interRegular),
                      subtitle: Text(
                        music.artist!.isEmpty ? "No artist" : music.artist!,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interRegular,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context
                              .read<FavoriteMusicCubit>()
                              .deleteFavorite(musicId);
                          context
                              .read<FavoriteMusicCubit>()
                              .readAllFavoriteMusic();
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 10.verticalSpace,
                  itemCount: favoriteAudios.length,
                );
              },
            );
          }
          return const Center(child: Text("Error"));
        },
      ),
      bottomSheet: const RecentlyPlayedItem(songsId: '1'),
    );
  }
}
