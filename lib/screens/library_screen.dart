import 'package:flutter/material.dart';
import 'package:music_wave/screens/favorate_screen.dart';
import 'package:music_wave/screens/playlist_screen.dart';
import 'package:music_wave/screens/search_screen.dart';
import 'package:music_wave/widgets/bottom_sheet.dart';

import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Bottom(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(
            10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  5,
                ),
                child: Row(
                  children: const [
                    HeadingText(
                      //playlist heading
                      text: 'Playlists',
                    ),
                  ],
                ),
              ),
              CardTile(
                //favorate
                subText: '10 Songs',
                tittleText: 'Favorate Songs',
                icon: Icons.favorite,
                iconColor: Colors.red,
                tapAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const FavorateScreen()),
                    ),
                  );
                },
              ),
              const WhiteSpace10(),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return CardTile(
                    //playlist 1
                    subText: '$index Songs',
                    tittleText: 'Playlist ${1 + index}',

                    icon: Icons.playlist_play,
                    iconColor: Colors.black,
                    tapAction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return const PlaylistScreen();
                          }),
                        ),
                      );
                    },
                  );
                }),
                itemCount: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
