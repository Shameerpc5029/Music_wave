import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/View/Player%20Screen/player_screen.dart';
import 'package:music_wave/View/Library%20Screen/Favorite/Widgets/fav_card.dart';
import 'package:music_wave/View/widgets/music_file.dart';

import 'package:on_audio_query/on_audio_query.dart';

class FavorateScreen extends StatefulWidget {
  const FavorateScreen({
    super.key,
  });

  @override
  State<FavorateScreen> createState() => _FavorateScreenState();
}

class _FavorateScreenState extends State<FavorateScreen> {
  @override
  void initState() {
    FavDb.getAllSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            setState(() {
              Navigator.pop(
                context,
              );
            });
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
        child: FavDb.musicListNotifier.value.isNotEmpty
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(
                  10,
                ),
                physics: const ScrollPhysics(),
                child: ValueListenableBuilder(
                  valueListenable: FavDb.musicListNotifier,
                  builder: ((BuildContext context, List<SongModel> music,
                      Widget? child) {
                    return ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: music.length,
                      itemBuilder: ((BuildContext context, int index) {
                        return FavCard(
                          id: music[index].id,
                          onTap: () {
                            List<SongModel> favList = [...music];

                            setState(() {});
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
                                    index: index,
                                    songModel: favList,
                                  );
                                }),
                              ),
                            );
                            log('Song Played');
                          },
                          title: music[index].title,
                          subtitle:
                              music[index].artist.toString() == "<unknown>"
                                  ? "Unknown Artist"
                                  : music[index].artist.toString(),
                          traling: IconButton(
                            onPressed: () {
                              FavDb.removeFav(music[index].id);

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
                                    '${music[index].title} Unliked!',
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
      ),
    );
  }
}
