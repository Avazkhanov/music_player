import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/utils/images/app_images.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongImageCreatorItem extends StatelessWidget {
  const SongImageCreatorItem({
    super.key,
    required this.id,
    this.height = 50,
    this.width = 50,
    this.border = 16,
  });

  final int id;
  final double height;
  final double width;
  final double border;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      artworkHeight: height.h,
      artworkWidth: width.w,
      keepOldArtwork: true,
      artworkBorder: BorderRadius.circular(border.r),
      id: id,
      type: ArtworkType.AUDIO,
      nullArtworkWidget: ClipRRect(
        borderRadius: BorderRadius.circular(border.sp),
        child: Image.asset(
          AppImages.music,
          height: height.h,
          width: width.w,
        ),
      ),
    );
  }
}
