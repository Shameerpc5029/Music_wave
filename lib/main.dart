import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_wave/Controller/provider/favbt_provider.dart';
import 'package:music_wave/Controller/provider/home_provider.dart';
import 'package:music_wave/Controller/provider/library_provider.dart';
import 'package:music_wave/Controller/provider/miniplayer_provider.dart';
import 'package:music_wave/Controller/provider/request_provider.dart';
import 'package:music_wave/Controller/provider/player_provider.dart';
import 'package:music_wave/Controller/provider/search_provider.dart';
import 'package:music_wave/Controller/provider/splash_provider.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/View/Splash%20Screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await FavDb.initializeDatabase();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RequestProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavDb(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MiniPlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LibrayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavBt(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Colors.white10,
            centerTitle: true,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
