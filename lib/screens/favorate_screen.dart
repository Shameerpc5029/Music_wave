import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:music_wave/widgets/song_card.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavorateScreen extends StatelessWidget {
  final _audioQuery = OnAudioQuery();
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

  FavorateScreen({super.key});

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
            physics: const ScrollPhysics(),
            child: FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  if (item.data == null) {
                    return LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.black,
                      size: 40,
                    );
                  } else if (item.data!.isEmpty) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'No Songs Found',
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: ((context, index) {
                      return SongCard(
                        player: audioPlayer,
                        index: index,
                        item: item,
                        titleText: 'Pala Palli',
                        subText: 'Athul Narukara and Jakes Bejoy',
                        fontWeight: FontWeight.bold,

                        icon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                        // tapAction: () {
                        //   // Navigator.of(context).push(
                        //   //   MaterialPageRoute(
                        //   //     builder: ((context) {
                        //   //       return PlayerScreen(songModel: item.data![index],);
                        //   //     }),
                        //   //   ),
                        //   // );
                        // },
                      );
                    }),
                  );
                })),
      ),
    );
  }
}
