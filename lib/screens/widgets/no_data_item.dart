import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/utils/images/app_images.dart';
import 'package:music_player/utils/styles/app_style.dart';

class NoDataItem extends StatelessWidget {
  const NoDataItem({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(AppImages.empty),
          Text(
            message,
            style: AppStyle.interBold.copyWith(
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
