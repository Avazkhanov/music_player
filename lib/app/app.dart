import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/bloc/all_music/all_music_bloc.dart';
import 'package:music_player/bloc/favorite_music/favorite_music_cubit.dart';
import 'package:music_player/screens/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AllMusicBloc()),
        BlocProvider(create: (_) => FavoriteMusicCubit())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          theme: ThemeData(
              bottomSheetTheme:
                  const BottomSheetThemeData(surfaceTintColor: Colors.black)),
        );
      },
      child: const SplashScreen(),
    );
  }
}
