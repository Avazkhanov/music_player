import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/bloc/all_music/all_music_bloc.dart';
import 'package:music_player/bloc/all_music/all_music_state.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_cubit.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_state.dart';
import 'package:music_player/data/models/all_music_model.dart';
import 'package:music_player/data/models/favorite_music_model.dart';
import 'package:music_player/screens/home/widgets/song_image_creator_item.dart';
import 'package:music_player/screens/widgets/no_data_item.dart';
import 'package:music_player/utils/styles/app_style.dart';

class AllSongsItem extends StatefulWidget {
  const AllSongsItem({super.key});

  @override
  State<AllSongsItem> createState() => _AllSongsItemState();
}

class _AllSongsItemState extends State<AllSongsItem> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  final AssetsAudioPlayer previousAudioPlayer = AssetsAudioPlayer.withId("1");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const Text(
            "Barcha qo'shiqlar",
            style: AppStyle.interMedium,
          ),
        ),
        SizedBox(height: 20.h),
        BlocBuilder<AllMusicBloc, AllMusicState>(
          builder: (context, state) {
            if (state is GetAllMusicState) {
              if (state.allMusic.isEmpty) {
                return const NoDataItem(
                    message: "Qurilmangizda qo'shiqlar mavjud emas");
              }
              List<Audio> convertAudios = [];
              for (var i in state.allMusic) {
                convertAudios.add(Audio.file(
                  i.url,
                  metas: Metas(
                    title: i.name,
                    artist: i.artist,
                    id: i.id.toString(),
                  ),
                ));
              }
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  AllMusicModel music = state.allMusic[index];
                  return BlocBuilder<FavoriteMusicCubit, FavoriteMusicState>(
                    builder: (context, favState) {
                      bool isFavorite = favState.favorites
                          .any((fav) => fav.musicId == music.id);
                      return ListTile(
                        onTap: () {
                          previousAudioPlayer.stop();
                          audioPlayer.open(
                            Playlist(
                              audios: convertAudios,
                              startIndex: index,
                            ),
                            showNotification: true,
                            notificationSettings: NotificationSettings(),
                            headPhoneStrategy:
                                HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          );
                        },
                        leading: SongImageCreatorItem(id: music.id),
                        title: Text(
                          music.name,
                          style: AppStyle.interRegular,
                        ),
                        subtitle: Text(
                          music.artist.isEmpty ? "No artist" : music.artist,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.interRegular,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            if (isFavorite) {
                              context
                                  .read<FavoriteMusicCubit>()
                                  .deleteFavorite(music.id);
                            } else {
                              context.read<FavoriteMusicCubit>().addFavorite(
                                    FavoriteMusicModel(musicId: music.id),
                                  );
                            }
                            context
                                .read<FavoriteMusicCubit>()
                                .readAllFavoriteMusic();
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return 10.verticalSpace;
                },
                itemCount: state.allMusic.length,
              );
            }
            return const Center(
              child: Text("Error"),
            );
          },
        ),
      ],
    );
  }
}
