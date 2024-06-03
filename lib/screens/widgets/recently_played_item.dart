import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_cubit.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_state.dart';
import 'package:music_player/data/models/favorite_music_model.dart';
import 'package:music_player/screens/home/widgets/song_controller_item.dart';
import 'package:music_player/screens/home/widgets/song_image_creator_item.dart';
import 'package:music_player/screens/home/widgets/song_minute_item.dart';
import 'package:music_player/utils/styles/app_style.dart';

class RecentlyPlayedItem extends StatefulWidget {
  const RecentlyPlayedItem({super.key, required this.songsId});
  final String songsId;

  @override
  State<RecentlyPlayedItem> createState() => _RecentlyPlayedItemState();
}

class _RecentlyPlayedItemState extends State<RecentlyPlayedItem> {
  late AssetsAudioPlayer audioPlayer;
  @override
  void initState() {
    audioPlayer = AssetsAudioPlayer.withId(widget.songsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(
      builder: (context, playing) {
        int musicId = int.parse(playing.audio.audio.metas.id!);
        context.read<FavoriteMusicCubit>().checkFavorite(musicId);
        return BlocBuilder<FavoriteMusicCubit, FavoriteMusicState>(
          builder: (context, state) {
            bool isFavorite = state.favorites.any((fav) => fav.musicId == musicId);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SongImageCreatorItem(
                        height: 60,
                        width: 60,
                        border: 10,
                        id: musicId,
                      ),
                      const Spacer(),
                      SongControllerItem(audioPlayer: audioPlayer),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              playing.audio.audio.metas.title!,
                              style: AppStyle.interBold.copyWith(fontSize: 16.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              playing.audio.audio.metas.artist!,
                              style: AppStyle.interBold.copyWith(fontSize: 16.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (isFavorite) {
                            context.read<FavoriteMusicCubit>().deleteFavorite(musicId);
                          } else {
                            context.read<FavoriteMusicCubit>().addFavorite(
                                FavoriteMusicModel(musicId: musicId));
                          }
                          context.read<FavoriteMusicCubit>().readAllFavoriteMusic();

                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SongMinuteItem(audioPlayer: audioPlayer)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
