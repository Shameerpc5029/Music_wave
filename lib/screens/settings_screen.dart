import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                HeadingText(text: 'Settings'),
              ],
            ),
          ),
          CardTile2(
            fontWeight: FontWeight.w100,
            icon: Icons.info_outline,
            titleText: 'About Music Wave',
            tapAction: () {},
          ),
          CardTile2(
            fontWeight: FontWeight.w200,
            icon: Icons.text_snippet_outlined,
            titleText: 'Terms And Conditions',
            tapAction: () {},
          ),
          CardTile2(
            fontWeight: FontWeight.w200,
            icon: Icons.security_outlined,
            titleText: 'Privacy policy',
            tapAction: () {},
          ),
          CardTile2(
            fontWeight: FontWeight.w200,
            icon: Icons.share,
            titleText: 'Share Music Wave',
            tapAction: () {},
          ),
          CardTile2(
            fontWeight: FontWeight.w200,
            icon: Icons.restart_alt,
            titleText: 'Reset App',
            tapAction: () {},
          ),
        ],
      ),
    ));
  }
}
