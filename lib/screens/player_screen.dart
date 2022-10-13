import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_wave/widgets/fav_button.dart';

import 'package:music_wave/widgets/music_file.dart';
import 'package:music_wave/widgets/music_slider.dart';

import 'package:music_wave/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatefulWidget {
  // final AudioPlayer audioPlayer;
  final int index;
  const PlayerScreen({
    super.key,
    // required this.audioPlayer,
    required this.songModel,
    required this.index,
  });
  final List<SongModel> songModel;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Duration duration = const Duration();
  Duration position = const Duration();

  int currentIndex = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    MusicFile.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          currentIndex = index;
        });
      }
    });
    super.initState();
    playSongs();
  }

  void playSongs() {
    MusicFile.audioPlayer.durationStream.listen(
      (d) {
        if (mounted) {
          setState(() {
            duration = d!;
          });
        }
      },
    );
    MusicFile.audioPlayer.positionStream.listen(
      (p) {
        if (mounted) {
          setState(() {
            position = p;
          });
        }
      },
    );
  }

  bool addButtonClick = false;

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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.blue,
                  Colors.black,
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  elevation: 12,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: QueryArtworkWidget(
                            id: MusicFile.playingSong[currentIndex].id,
                            // id:widget.id,
                            type: ArtworkType.AUDIO,
                            // type: widget.type,
                            keepOldArtwork: true,

                            artworkFit: BoxFit.fill,
                            artworkBorder: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            artworkHeight: 200,
                            artworkWidth: 200,
                            nullArtworkWidget: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.blue,
                              ),
                              height: 200,
                              width: 200,
                              child: const Center(
                                  child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 50,
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SizedBox(
                            height: 40,
                            child: FavButton(
                              songModel: widget.songModel[widget.index],
                              icon: Icons.favorite,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const WhiteSpace40(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: Text(
                    widget.songModel[currentIndex].displayNameWOExt,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Text(
                    widget.songModel[currentIndex].artist.toString() ==
                            "<unknown>"
                        ? "Unknown Artist"
                        : widget.songModel[currentIndex].artist.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const WhiteSpace40(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        position.toString().split(".")[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: MusicSlide(
                          duration: duration,
                          position: position,
                          audioPlayer: MusicFile.audioPlayer,
                        ),
                      ),
                      Text(
                        duration.toString().split(".")[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const WhiteSpace(),
                Stack(
                  children: [
                    // WaveClipper(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // await MusicFile.audioPlayer.shuffle();
                                setState(() {
                                  if (shuffleOn) {
                                    MusicFile.audioPlayer.shuffle();
                                    MusicFile.audioPlayer
                                        .setShuffleModeEnabled(true);
                                  } else {
                                    MusicFile.audioPlayer
                                        .setShuffleModeEnabled(false);
                                  }
                                  shuffleOn = !shuffleOn;
                                });
                              },
                              icon: Icon(shuffleOn
                                  ? Icons.shuffle
                                  : Icons.shuffle_on_outlined),
                              color: Colors.white,
                            ),
                            RawMaterialButton(
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    // color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              onPressed: () async {
                                if (MusicFile.audioPlayer.hasPrevious) {
                                  await MusicFile.audioPlayer.seekToPrevious();
                                  await MusicFile.audioPlayer.play();
                                } else {
                                  await MusicFile.audioPlayer.play();
                                }
                              },
                              child: const Icon(
                                Icons.skip_previous_rounded,
                                size: 20,
                                // color: Color.fromARGB(255, 185, 18, 18),
                                color: Colors.white,
                              ),
                            ),
                            RawMaterialButton(
                              shape: const CircleBorder(
                                side: BorderSide(
                                    // color: Color.fromARGB(255, 185, 18, 18),
                                    color: Colors.white,
                                    width: 3),
                              ),
                              padding: const EdgeInsets.all(15),
                              onPressed: () {
                                setState(
                                  () {
                                    if (!_isPlaying) {
                                      MusicFile.audioPlayer.pause();
                                    } else {
                                      MusicFile.audioPlayer.play();
                                    }
                                    _isPlaying = !_isPlaying;
                                  },
                                );
                              },
                              child: StreamBuilder<bool>(
                                stream: MusicFile.audioPlayer.playingStream,
                                builder: (context, snapshot) {
                                  bool? playingStage = snapshot.data;
                                  if (playingStage != null && playingStage) {
                                    return const Icon(
                                      Icons.pause_rounded,
                                      // color: Color.fromARGB(255, 185, 18, 18),
                                      color: Colors.white,
                                      size: 45,
                                    );
                                  } else {
                                    return const Icon(
                                      color: Colors.white,
                                      Icons.play_arrow_rounded,
                                      size: 45,
                                    );
                                  }
                                },
                              ),
                            ),
                            RawMaterialButton(
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(
                                side: BorderSide(
                                    // color: Color.fromARGB(255, 185, 18, 18),
                                    color: Colors.white,
                                    width: 3),
                              ),
                              onPressed: () async {
                                await MusicFile.audioPlayer.seekToNext();
                                await MusicFile.audioPlayer.play();
                                //   if (MusicFile.audioPlayer.hasPrevious) {
                                //     await MusicFile.audioPlayer.seekToNext();
                                //     await MusicFile.audioPlayer.play();
                                //   } else {
                                //     await MusicFile.audioPlayer.play();
                                //   }
                              },
                              child: const Icon(
                                Icons.skip_next_rounded,
                                size: 20,
                                // color: Color.fromARGB(255, 185, 18, 18),
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (repetOn) {
                                    MusicFile.audioPlayer
                                        .setLoopMode(LoopMode.one);
                                  } else {
                                    MusicFile.audioPlayer
                                        .setLoopMode(LoopMode.off);
                                  }
                                  repetOn = !repetOn;
                                });
                              },
                              icon: Icon(
                                repetOn
                                    ? Icons.repeat
                                    : Icons.repeat_on_outlined,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const WhiteSpace40(),
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

  bool repetOn = true;
  bool shuffleOn = true;
}
