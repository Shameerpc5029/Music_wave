import 'package:flutter/material.dart';
import 'package:music_wave/screens/favorate_screen.dart';
import 'package:music_wave/widgets/bottom_sheet.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/remove_alert.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const Bottom(),
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
                subText: '1 Songs',
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
                    subText: '$index Songs',
                    tittleText: 'Playlist ${1 + index}',
                    trailingIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return const RemoveAlert();
                            }));
                      },
                      icon: const Icon(
                        Icons.playlist_remove,
                      ),
                    ),
                    icon: Icons.playlist_play,
                    iconColor: Colors.black,
                    tapAction: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: ((context) {
                      //       return PlaylistScreen();
                      //     }),
                      //   ),
                      // );
                    },
                  );
                }),
                itemCount: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
