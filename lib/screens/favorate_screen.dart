import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/widgets/fav_card.dart';
import 'package:music_wave/widgets/popup_card.dart';
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

  // final audioQuery = OnAudioQuery();
  // final audioPlayer = AudioPlayer();
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
          'Favorate Songs',
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
              if (musiclist == null) {
                return LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.black,
                  size: 40,
                );
              } else if (musiclist.isEmpty) {
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
                for (var element in musiclist) {
                  log('SongID= ${element.id}');
                }
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: musiclist.length,
                  itemBuilder: ((BuildContext context, int index) {
                    return FavCard(
                      id: musiclist[index].id,
                      onTap: () {
                        // MusicFile.audioPlayer.play();
                        // MusicFile.audioPlayer.setAudioSource(
                        //     MusicFile.createSongList(musiclist),
                        //     initialIndex: index);
                        // MusicFile.audioPlayer.play();
                        // Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                        //   return PlayerScreen(audioPlayer: audioPlayer, songModel: musiclist,)
                        // })));
                      },
                      title: musiclist[index].title,
                      subtitle:
                          musiclist[index].artist.toString() == "<unknown>"
                              ? "Unknown Artist"
                              : musiclist[index].artist.toString(),
                      traling: IconButton(
                          onPressed: () {
                            setState(() {
                              // musiclist.removeAt(index);
                              // FavDb.removeFav(musiclist[index].id);
                            });
                          },
                          icon: Icon(Icons.favorite)),
                      // traling: PopUpcard(
                      //   onPress: () {
                      //     setState(() {
                      //       musiclist.removeAt(index);
                      // FavDb.removeFav(index);
                      // FavDb.musicListNotifier;
                      //     });
                      //   },
                      // ),
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
