import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/widgets/fav_button.dart';
import 'package:music_wave/widgets/fav_card.dart';

import 'package:music_wave/widgets/song_card.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavorateScreen extends StatefulWidget {
  FavorateScreen({
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

  final audioQuery = OnAudioQuery();

  final audioPlayer = AudioPlayer();

  playSong(String? uri) {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
    } on Exception {
      log("Error pasing song");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorate Songs',
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
          padding: EdgeInsets.all(10),
          physics: const ScrollPhysics(),
          child: ValueListenableBuilder(
            valueListenable: FavDb.musicListNotifier,
            builder: ((BuildContext context, List<SongModel> musiclist,
                Widget? child) {
              if (musiclist == null) {
                return LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 40,
                );
              } else if (musiclist.isEmpty) {
                return Center(
                  heightFactor: 30,
                  child: Text(
                    'No Songs Found!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: musiclist.length,
                itemBuilder: ((BuildContext context, int index) {
                  FavDb.getAllSongs();
                  return FavCard(
                    title: musiclist[index].title,
                    subtitle: musiclist[index].artist.toString() == "<unknown>"
                        ? "Unknown Artist"
                        : musiclist[index].artist.toString(),
                    traling: showCard(),
                  );
                }),
              );
            }),
          ),
        )));
  }

  Widget showCard() => PopupMenuButton(
      splashRadius: 50,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      offset: Offset(-30, 20),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Unlike'),
                ],
              )),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Icon(
                  Icons.playlist_add,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Add Playlist'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Share Music',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ];
      });
}
