// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/screens/favorite_music/favorite_music_screen.dart';
import 'package:music_player/screens/home/widgets/all_songs_item.dart';
import 'package:music_player/screens/widgets/recently_played_item.dart';
import 'package:music_player/utils/styles/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Hello",
          style: AppStyle.interBold.copyWith(fontSize: 24.sp),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Ink(
              width: 160.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(.8),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => FavoriteMusicScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red),
                      10.horizontalSpace,
                      Text(
                        "Sevimli musiqalar",
                        style: AppStyle.interRegular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          AllSongsItem(),
        ],
      ),
      bottomSheet: RecentlyPlayedItem(songsId: '0'),
    );
  }
}
