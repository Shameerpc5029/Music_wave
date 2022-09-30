import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/grid_card.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:music_wave/widgets/song_card.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSong extends StatefulWidget {
  const AllSong({
    Key? key,
  }) : super(key: key);
  // static List<SongModel> playSong = [];
  @override
  State<AllSong> createState() => _AllSongState();
}

class _AllSongState extends State<AllSong> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

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
      log(
        "Error pasing song",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          10,
        ),
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    left: 10,
                  ),
                  child: HeadingText(
                    text: 'Recently Songs',
                  ),
                ),
              ],
            ),
            GridCard(
              audioPlayer: audioPlayer,
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    left: 10,
                  ),
                  child: HeadingText(
                    text: 'All Songs',
                  ),
                ),
              ],
            ),
            FutureBuilder<List<SongModel>>(
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
                } else {
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: item.data!.length,
                    itemBuilder: ((context, index) {
                      return SongCard(
                        // onTap: () {
                        //   MusicFile.audioPlayer.setAudioSource(
                        //       MusicFile.createSongList(item.data!),
                        //       initialIndex: index);
                        //   MusicFile.audioPlayer.play();
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: ((context) {
                        //         return PlayerScreen(songModel: item.data!);
                        //       }),
                        //     ),
                        //   );
                        // },
                        leadingIcon: Icon(Icons.favorite),
                        item: item,
                        index: index,
                        audioPlayer: audioPlayer,
                        titleText: item.data![index].displayNameWOExt,
                        subText:
                            item.data![index].artist.toString() == "<unknown>"
                                ? "Unknown Artist"
                                : item.data![index].artist.toString(),
                        fontWeight: FontWeight.bold,
                      );
                    }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool iconButtonClick = false;
}
