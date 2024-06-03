// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/screens/home/widgets/all_songs_item.dart';
import 'package:music_player/screens/home/widgets/recently_played_item.dart';
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
        children: [
          SizedBox(height: 50.h),
          AllSongsItem(),
        ],
      ),
      bottomSheet: RecentlyPlayedItem(),
    );
  }
}
