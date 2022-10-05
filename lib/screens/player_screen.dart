import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/screens/home_screen.dart';
import 'package:music_wave/widgets/box_fav_button.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:music_wave/widgets/music_slider.dart';
import 'package:music_wave/widgets/scroll_card.dart';
import 'package:music_wave/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

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
  final _audioQuery = OnAudioQuery();
  final int id = -1;
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
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
                const WhiteSpace10(),
                SizedBox(
                  height: 200,
                  child: ScrollSnapList(
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          ScrollCard(
                            songModel: MusicFile.playingSong,
                            // id: item,
                            // id: MusicFile.playingSong[currentIndex].id,
                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SizedBox(
                              width: 130,
                              child: BoxFavButton(
                                song: item.data![index],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    // itemCount: 1,
                    itemCount: item.data!.length,
                    itemSize: 150,
                    onItemFocus: (index) {
                      print(index);
                    },
                    initialIndex: widget.index.toDouble(),

                    dynamicItemSize: true,
                    focusOnItemTap: true,
                  ),
                ),
                const WhiteSpace(),
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
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        position.toString().split(".")[0],
                      ),
                      Expanded(
                        child: MusicSlide(
                          duration: duration,
                          position: position,
                          audioPlayer: MusicFile.audioPlayer,
                        ),
                      ),
                      Text(duration.toString().split(".")[0]),
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
                            ),
                            RawMaterialButton(
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 185, 18, 18),
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
                                      color: Color.fromARGB(255, 185, 18, 18),
                                      size: 45,
                                    );
                                  } else {
                                    return const Icon(
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
                                    color: Color.fromARGB(255, 185, 18, 18),
                                    width: 3),
                              ),
                              onPressed: () async {
                                if (MusicFile.audioPlayer.hasPrevious) {
                                  await MusicFile.audioPlayer.seekToNext();
                                  await MusicFile.audioPlayer.play();
                                } else {
                                  await MusicFile.audioPlayer.play();
                                }
                              },
                              child: const Icon(
                                Icons.skip_next_rounded,
                                size: 20,
                                color: Color.fromARGB(255, 185, 18, 18),
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
                            ),
                          ],
                        ),
                        const WhiteSpace40(),
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

  bool repetOn = true;
  bool shuffleOn = true;
}
