import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/utils/styles/app_style.dart';

class FavoriteMusicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoriteMusicAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        "Sevimli Musiqalar",
        style: AppStyle.interBold.copyWith(
          fontSize: 18.sp,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          size: 24.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 56.h);
}
