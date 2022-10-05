import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/fav_card.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:music_wave/widgets/popup_card.dart';

import 'package:on_audio_query/on_audio_query.dart';

class FavorateScreen extends StatefulWidget {
  const FavorateScreen({
    super.key,
  });
  // static List<SongModel> song = [];
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
        child: FavDb.musicListNotifier.value.isEmpty
            ? const Center(
                heightFactor: 30,
                child: Text(
                  'No Songs Found!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(10),
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
                              MusicFile.audioPlayer.stop();
                              MusicFile.audioPlayer.setAudioSource(
                                MusicFile.createSongList(music),
                                initialIndex: index,
                              );
                              MusicFile.audioPlayer.play();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return PlayerScreen(
                                      index: index,
                                      songModel: music,
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
                            traling: PopUpcard(
                              onPress: () {
                                setState(() { 
                                  
                                  FavDb.removeFav(music[index].id);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    margin: const EdgeInsets.all(10),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 1),
                                    shape: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    content: Text(
                                      '${music[index].title} Unliked!',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),);
                  }),
                ),
              ),
      ),
    );
  }
}
