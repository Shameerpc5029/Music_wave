import 'package:flutter/material.dart';

class AboutText extends StatelessWidget {
  const AboutText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const [
                    TextSpan(
                        text: '''

Welcome to Music Wave,
                    
''',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                      text:
                          '''Your number one source for all things Music App. We're dedicated to giving you the best of Music App, focusing on rich UI, custom playlists, and a new animation player.

Founded in 2022 by Shameer PC, Music Wave has come a long way from its beginnings in another music app. When Shameer PC started out, his passion for an "eco-friendly cleaning Music App" drove them so that Music Wave could offer you the best quality of listening.  We are thrilled that we're able to turn our passion into our own mobile application.

I hope you enjoy my products as much as
I enjoy offering them to you. If you have any questions or comments, please don't hesitate to contact me

Sincerely,
''',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        wordSpacing: 1,
                      ),
                    ),
                    TextSpan(
                        text: 'Shameer PC.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.black38),
            ),
            const Text(
              'Developed By Shameer PC',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
