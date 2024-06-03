 import 'package:flutter/material.dart';
import 'package:music_player/app/app.dart';
import 'package:music_player/data/local_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalDatabase.instance;
  runApp(const App());
}


