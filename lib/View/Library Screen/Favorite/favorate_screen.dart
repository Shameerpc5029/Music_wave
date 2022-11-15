import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_wave/Controller/provider/home_provider.dart';
import 'package:music_wave/Controller/provider/library_provider.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/View/Library%20Screen/library_screen.dart';
import 'package:music_wave/View/Player%20Screen/player_screen.dart';
import 'package:music_wave/View/Library%20Screen/Favorite/Widgets/fav_card.dart';
import 'package:music_wave/View/home_screen.dart';
import 'package:music_wave/View/widgets/music_file.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({
    super.key,
  });

  // @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FavDb>(context, listen: false).getAllSongs();
    });
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Songs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(
              context,
            );
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Consumer<FavDb>(
        builder: (context, value, child) {
          return SafeArea(
            child: value.favSongModel.isNotEmpty
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    physics: const ScrollPhysics(),
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.favSongModel.length,
                      itemBuilder: ((BuildContext context, int index) {
                        return FavCard(
                          id: value.favSongModel[index].id,
                          onTap: () {
                            List<SongModel> favList = [...value.favSongModel];

                            // setState(() {});
                            MusicFile.audioPlayer.stop();
                            MusicFile.audioPlayer.setAudioSource(
                              MusicFile.createSongList(
                                favList,
                              ),
                              initialIndex: index,
                            );
                            MusicFile.audioPlayer.play();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) {
                                  return PlayerScreen(
                                    // index: index,
                                    songModel: favList,
                                  );
                                }),
                              ),
                            );
                            log('Song Played');
                          },
                          title: value.favSongModel[index].title,
                          subtitle:
                              value.favSongModel[index].artist.toString() ==
                                      "<unknown>"
                                  ? "Unknown Artist"
                                  : value.favSongModel[index].artist.toString(),
                          traling: IconButton(
                            onPressed: () {
                              value.removeFav(value.favSongModel[index].id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  margin: const EdgeInsets.all(10),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(
                                    seconds: 1,
                                  ),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  content: Text(
                                    '${value.favSongModel[index].title} Unliked!',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                : Center(
                    heightFactor: 2,
                    child: LottieBuilder.asset(
                      height: 300,
                      'assets/lottie/116469-no-item-in-box.json',
                    ),
                  ),
          );
        },
      ),
    );
  }
}
