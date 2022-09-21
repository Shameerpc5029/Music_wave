import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/widgets/music_slider.dart';

import 'package:music_wave/widgets/scroll_card.dart';
import 'package:music_wave/widgets/song_card.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/volume_slider.dart';
import 'package:music_wave/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel songModel;
  final AudioPlayer audioPlayer;
  const PlayerScreen(
      {super.key, required this.songModel, required this.audioPlayer});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
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

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    playSongs();
  }

  void playSongs() {
    try {
      widget.audioPlayer;
      widget.audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(widget.songModel.uri!),
        ),
      );
      widget.audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log("Cannot pase song");
    }
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  Color iconColor = Colors.black38;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(
        //   'Player',
        // ),
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
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 10,
                  ),
                  child: Row(
                    children: const [
                      HeadingText(
                        text: 'Next Song',
                      ),
                    ],
                  ),
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
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: ((context, index) {
                            return SongCard(
                              player: audioPlayer,
                              index: index,
                              item: item,
                              fontWeight: FontWeight.bold,
                              titleText: widget.songModel.displayNameWOExt,
                              subText: widget.songModel.artist.toString() ==
                                      "<unknown>"
                                  ? "Unknown Artist"
                                  : widget.songModel.artist.toString(),
                              icon: const Icon(
                                Icons.favorite,
                              ),
                            );
                          }));
                    }),
                const WhiteSpace10(),
                SizedBox(
                  height: 150,
                  child: ScrollSnapList(
                    itemBuilder: (BuildContext context, int index) {
                      return ScrollCard(
                        id: widget.songModel.id,
                        type: ArtworkType.AUDIO,
                      );
                    },
                    itemCount: 5,
                    itemSize: 150,
                    onItemFocus: (index) {
                      print('Selected');
                    },
                    dynamicItemSize: true,
                    focusOnItemTap: true,
                  ),
                ),
                const WhiteSpace10(),
                ListTile(
                  title: HeadingText(
                    text: widget.songModel.displayNameWOExt,
                  ),
                  subtitle: SubTitle(
                    titleText: widget.songModel.artist.toString() == "<unknown>"
                        ? "Unknown Artist"
                        : widget.songModel.artist.toString(),
                  ),
                  trailing: IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.playlist_add,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(position.toString().split(".")[0]),
                      Expanded(
                        child: MusicSlide(
                          duration: duration,
                          position: position,
                          audioPlayer: audioPlayer,
                        ),
                      ),
                      Text(duration.toString().split(".")[0]),
                    ],
                  ),
                ),
                const WhiteSpace(),
                Stack(
                  children: [
                    // Clip(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              padding: EdgeInsets.all(15),
                              shape: CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.skip_previous_rounded,
                                size: 20,
                                color: Color.fromARGB(255, 185, 18, 18),
                              ),
                            ),
                            RawMaterialButton(
                              shape: CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              padding: EdgeInsets.all(15),
                              onPressed: () {
                                setState(() {
                                  if (_isPlaying) {
                                    widget.audioPlayer.pause();
                                  } else {
                                    widget.audioPlayer.play();
                                  }
                                  _isPlaying = !_isPlaying;
                                });
                              },
                              child: Icon(
                                _isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Color.fromARGB(255, 185, 18, 18),
                                size: 40,
                              ),
                            ),
                            RawMaterialButton(
                              padding: EdgeInsets.all(15),
                              shape: CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.skip_next_rounded,
                                size: 20,
                                color: Color.fromARGB(255, 185, 18, 18),
                              ),
                            ),
                          ],
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       if (_isPlaying) {
                        //         widget.audioPlayer.pause();
                        //       } else {
                        //         widget.audioPlayer.play();
                        //       }
                        //       _isPlaying = !_isPlaying;
                        //     });
                        //   },
                        //   icon: Icon(
                        //     _isPlaying ? Icons.pause : Icons.play_arrow,
                        //   ),
                        // ),

                        // PlayerController(
                        //   icons: Icons.skip_previous_rounded,
                        //   buttonAction: () {
                        //     print("object");
                        //   },
                        //   size: 30,
                        // ),
                        const SizedBox(
                          width: 75,
                        ),

                        const WhiteSpace(),
                        const VolumeSlider(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
