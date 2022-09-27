import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/widgets/box_fav_button.dart';
import 'package:music_wave/widgets/music_slider.dart';
import 'package:music_wave/widgets/scroll_card.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/volume_slider.dart';
import 'package:music_wave/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel songModel;
  final AudioPlayer audioPlayer;
  const PlayerScreen({
    super.key,
    required this.audioPlayer,
    required this.songModel,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final _audioQuery = OnAudioQuery();

  Duration duration = const Duration();
  Duration position = const Duration();

  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    playSongs();
  }

  void playSongs() {
    try {
      widget.audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(widget.songModel.uri!),
          tag: MediaItem(
            id: '${widget.songModel.id}',
            album: "${widget.songModel.album}",
            title: widget.songModel.displayNameWOExt,
            artUri: Uri.parse('https://example.com/albumart.jpg'),
          ),
        ),
      );
      widget.audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log("Cannot pase song");
    }
    // widget.audioPlayer.durationStream.listen(
    //   (d) {
    //     duration = d!;
    //   },
    // );
    // widget.audioPlayer.positionStream.listen(
    //   (p) {
    //     position = p;
    //   },
    // // );
    // setState(() {});
  }

  Color iconColor = Colors.black38;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Now Playing',
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
      body: Center(
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 15,
                //     top: 10,
                //   ),
                //   child: Row(
                //     children: const [
                //       HeadingText(
                //         text: 'Next Song',
                //       ),
                //     ],
                //   ),
                // ),
                // FutureBuilder<List<SongModel>>(
                //   future: _audioQuery.querySongs(
                //     sortType: null,
                //     orderType: OrderType.ASC_OR_SMALLER,
                //     uriType: UriType.EXTERNAL,
                //     ignoreCase: true,
                //   ),
                //   builder: (context, item) {
                //     if (item.data == null) {
                //       return LoadingAnimationWidget.staggeredDotsWave(
                //         color: Colors.black,
                //         size: 40,
                //       );
                //     } else if (item.data!.isEmpty) {
                //       return const SizedBox(
                //         height: 200,
                //         child: Center(
                //           child: Text(
                //             'No Songs Found',
                //           ),
                //         ),
                //       );
                //     }
                //     return ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: 2,
                //       itemBuilder: ((context, index) {
                //         return SongCard(
                //           player: widget.audioPlayer,
                //           index: index,
                //           item: item,
                //           fontWeight: FontWeight.bold,
                //           titleText: widget.songModel.displayNameWOExt,
                //           subText:
                //               widget.songModel.artist.toString() == "<unknown>"
                //                   ? "Unknown Artist"
                //                   : widget.songModel.artist.toString(),
                //           icon: const Icon(
                //             Icons.favorite,
                //           ),
                //         );
                //       }),
                //     );
                //   },
                // ),
                const WhiteSpace10(),
                SizedBox(
                  height: 200,
                  child: ScrollSnapList(
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          ScrollCard(
                            songModel: widget.songModel,
                            // id: item,

                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SizedBox(
                              width: 130,
                              child: BoxFavButton(
                                songModel: widget.songModel,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: item.data!.length,
                    itemSize: 150,
                    onItemFocus: (index) {},
                    dynamicItemSize: true,
                    focusOnItemTap: true,
                  ),
                ),
                const WhiteSpace(),
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
                          audioPlayer: widget.audioPlayer,
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
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              onPressed: () async {
                                // if (widget.audioPlayer.hasPrevious) {
                                //   _isPlaying = true;
                                //   await widget.audioPlayer.seekToPrevious();
                                //   await widget.audioPlayer.play();
                                // } else {
                                //   await widget.audioPlayer.play();
                                // }
                              },
                              child: const Icon(
                                Icons.skip_previous_rounded,
                                size: 20,
                                color: Color.fromARGB(255, 185, 18, 18),
                              ),
                            ),
                            RawMaterialButton(
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              padding: const EdgeInsets.all(15),
                              onPressed: () {
                                setState(
                                  () {
                                    if (_isPlaying) {
                                      widget.audioPlayer.pause();
                                    } else {
                                      widget.audioPlayer.play();
                                    }
                                    _isPlaying = !_isPlaying;
                                  },
                                );
                              },
                              child: Icon(
                                _isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: const Color.fromARGB(255, 185, 18, 18),
                                size: 40,
                              ),
                            ),
                            RawMaterialButton(
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              onPressed: () async {
                                // if (widget.audioPlayer.hasNext) {
                                //   _isPlaying = true;
                                //   await widget.audioPlayer.seekToNext();
                                //   await widget.audioPlayer.play();
                                // } else {
                                //   await widget.audioPlayer.play();
                                // }
                              },
                              child: const Icon(
                                Icons.skip_next_rounded,
                                size: 20,
                                color: Color.fromARGB(255, 185, 18, 18),
                              ),
                            ),
                          ],
                        ),
                        const WhiteSpace40(),
                        const VolumeSlider(),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
