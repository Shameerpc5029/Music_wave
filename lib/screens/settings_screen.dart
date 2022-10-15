import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/screens/about_screen.dart';
import 'package:music_wave/screens/privacy_screen.dart';
import 'package:music_wave/screens/splash_screen.dart';
import 'package:music_wave/screens/teams_screen.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:music_wave/widgets/remove_alert.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                tapAction: () {},
              ),
              CardTile2(
                icon: Icons.restart_alt,
                titleText: 'Reset App',
                tapAction: () {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return RemoveAlert(
                        title: 'Reset App',
                        contant: 'Do you want to reset this app?',
                        yesPress: () {
                          FavDb.resetAll();
                          MusicFile.audioPlayer.stop();

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: ((context) {
                            return const SplashScreen();
                          })), (route) => false);
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
