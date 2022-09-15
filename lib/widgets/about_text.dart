import 'package:flutter/material.dart';


class AboutText extends StatelessWidget {
  const AboutText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            ''' 
Welcome to Music Wave,

Your number one source for all things Music App. We're dedicated to giving you the best of Music App, focusing on rich UI, custom playlists, and a new animation player.

Founded in 2022 by Shameer PC, Music Wave has come a long way from its beginnings in another music app. When Shameer PC started out, his passion for an "eco-friendly cleaning Music App" drove them so that Music Wave could offer you the best quality of listening.  We are thrilled that we're able to turn our passion into our own mobile application.

I hope you enjoy my products as much as I enjoy offering them to you. If you have any questions or comments, please don't hesitate to contact me.

Sincerely,

Shameer PC''',
            style: TextStyle(
              letterSpacing: 0.2,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              wordSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
