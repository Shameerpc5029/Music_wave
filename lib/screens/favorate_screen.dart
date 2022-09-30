import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/fav_card.dart';
import 'package:music_wave/widgets/popup_card.dart';

import 'package:on_audio_query/on_audio_query.dart';

class FavorateScreen extends StatefulWidget {
  const FavorateScreen({
    super.key,
  });
  static List<SongModel> song = [];
  @override
  State<FavorateScreen> createState() => _FavorateScreenState();
}

class _FavorateScreenState extends State<FavorateScreen> {
  @override
  void initState() {
    FavDb.getAllSongs();
    super.initState();
  }

  // final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  // playSong(String? uri) {
  //   try {
  //     audioPlayer.setAudioSource(
  //       AudioSource.uri(
  //         Uri.parse(uri!),
  //       ),
  //     );
  //     audioPlayer.play();
  //   } on Exception {
  //     log("Error pasing song");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          physics: const ScrollPhysics(),
          child: ValueListenableBuilder(
            valueListenable: FavDb.musicListNotifier,
            builder: ((BuildContext context, List<SongModel> musiclist,
                Widget? child) {
              if (musiclist.isEmpty) {
                return const Center(
                  heightFactor: 30,
                  child: Text(
                    'No Songs Found!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: musiclist.length,
                  itemBuilder: ((BuildContext context, int index) {
                    return FavCard(
                      id: musiclist[index].id,
                      onTap: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: ((context) {
                        //   return PlayerScreen(
                        //       audioPlayer: audioPlayer,
                        //       songModel: musiclist[index].uri);
                        // })));
                        log('Song Played');
                      },
                      title: musiclist[index].title,
                      subtitle:
                          musiclist[index].artist.toString() == "<unknown>"
                              ? "Unknown Artist"
                              : musiclist[index].artist.toString(),
                      traling: PopUpcard(
                        onPress: () {
                          setState(() {
                            FavDb.removeFav(musiclist[index].id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              margin: const EdgeInsets.all(10),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              content: Text(
                                '${musiclist[index].title} Unliked!',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
