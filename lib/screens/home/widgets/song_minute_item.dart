import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class SongMinuteItem extends StatelessWidget {
  const SongMinuteItem({super.key, required this.audioPlayer});
  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration.zero;
    Duration position = Duration.zero;
    return PlayerBuilder.realtimePlayingInfos(
      player: audioPlayer,
      builder: (context, realtimePlayingInfo) {
        duration = realtimePlayingInfo.current!.audio.duration;
        position = realtimePlayingInfo.currentPosition;
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ProgressBar(
            baseBarColor: Colors.white.withOpacity(0.5),
            progressBarColor: Colors.red,
            thumbColor: Colors.red,
            thumbRadius: 5,
            timeLabelPadding: 5,
            progress: position,
            timeLabelTextStyle: const TextStyle(
              color: Colors.white,
            ),
            total: duration,
            onSeek: (duration) async {
              await audioPlayer.seek(duration);
            },
          ),
        );
      },
    );
  }
}
