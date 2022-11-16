import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/Controller/provider/bottom_nav_provider.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/View/Settings%20Screen/About/about_screen.dart';
import 'package:music_wave/View/Settings%20Screen/Privacy/privacy_screen.dart';
import 'package:music_wave/View/Splash%20Screen/splash_screen.dart';
import 'package:music_wave/View/Settings%20Screen/Terms%20And%20Conditions/teams_screen.dart';
import 'package:music_wave/View/widgets/card.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:music_wave/View/widgets/remove_alert.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("set");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(
            10,
          ),
          child: Column(
            children: [
              CardTile2(
                icon: Icons.info_outline,
                titleText: 'About Music Wave',
                tapAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (contex) {
                      return const AboutScreen();
                    }),
                  );
                },
              ),
              CardTile2(
                icon: Icons.text_snippet_outlined,
                titleText: 'Terms And Conditions',
                tapAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (contex) {
                      return const TermsScreen();
                    }),
                  );
                },
              ),
              CardTile2(
                icon: Icons.security_outlined,
                titleText: 'Privacy policy',
                tapAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (contex) {
                      return const PrivacyScreen();
                    }),
                  );
                },
              ),
              CardTile2(
                icon: Icons.share,
                titleText: 'Share Music Wave',
                tapAction: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=in.shameer.music_wave');
                },
              ),
              CardTile2(
                icon: Icons.restart_alt,
                titleText: 'Reset App',
                tapAction: () {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return Consumer<FavDb>(
                        builder: (context, value, child) {
                          return RemoveAlert(
                            title: 'Reset App',
                            contant: 'Do you want to reset this app?',
                            yesPress: () {
                              value.resetAll();
                              MusicFile.audioPlayer.stop();
                              Provider.of<HomeProvider>(context, listen: false)
                                  .currentIndex = 0;
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                builder: ((context) {
                                  return const SplashScreen();
                                }),
                              ), (route) => false);
                            },
                          );
                        },
                      );
                    }),
                  );
                },
              ),
              const Spacer(),
              const Text(
                'V 1.0.0',
                style: TextStyle(
                  color: Colors.black12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
