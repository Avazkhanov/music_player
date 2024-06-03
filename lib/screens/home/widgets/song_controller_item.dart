import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SongControllerItem extends StatelessWidget {
  const SongControllerItem({super.key, required this.audioPlayer});
final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.isPlaying(
      player: audioPlayer,
      builder: (context, isPlaying) {
        return Row(
          children: [
            IconButton(
              onPressed: () {
                audioPlayer.previous();
              },
              icon: Icon(
                Icons.skip_previous_outlined,
                color: Colors.white,
                size: 40.sp,
              ),
            ),
            15.horizontalSpace,
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black, shape: BoxShape.circle),
              child: IconButton(
                onPressed: () {
                  audioPlayer.playOrPause();
                },
                icon: Icon(
                  isPlaying
                      ? Icons.pause
                      : Icons.play_arrow_outlined,
                  color: Colors.white,
                  size: 40.sp,
                ),
              ),
            ),
            15.horizontalSpace,
            IconButton(
              onPressed: () {
                audioPlayer.next();
              },
              icon: Icon(
                Icons.skip_next_outlined,
                color: Colors.white,
                size: 40.sp,
              ),
            ),
          ],
        );
      },
    );
  }
}
