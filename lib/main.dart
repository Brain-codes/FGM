// ignore_for_file: prefer_const_constructors

import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:FGM/shared/themes/app_theme.dart';
import 'package:FGM/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true, 
  );
  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.production");
  } else {
    await dotenv.load(fileName: ".env.development");
  }
  await Hive.openBox(DbKeyStrings.dbName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(0, 14, 124, 188),
        systemNavigationBarColor: Color.fromARGB(255, 0, 0, 0),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
