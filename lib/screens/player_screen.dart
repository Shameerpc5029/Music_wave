import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/widgets/box_fav_button.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:music_wave/widgets/music_slider.dart';
import 'package:music_wave/widgets/player_controler.dart';
import 'package:music_wave/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayerScreen extends StatefulWidget {
  final int index;
  const PlayerScreen({
    super.key,
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
  bool isFav = false;
  int currentIndex = 0;

  @override
  void initState() {
    MusicFile.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          currentIndex = index;
        });
        cheakFav();
        MusicFile.currentIndes = index;
      }
    });
    super.initState();

    playSongs();
  }

  void cheakFav() async {
    isFav = await FavDb.isFav(
      widget.songModel[currentIndex].id,
    );
    setState(() {});
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
            setState(() {});
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
                  Colors.white10,
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
                            type: ArtworkType.AUDIO,
                            keepOldArtwork: true,
                            artworkFit: BoxFit.fill,
                            artworkBorder: const BorderRadius.only(
                              topLeft: Radius.circular(
                                5,
                              ),
                              topRight: Radius.circular(
                                5,
                              ),
                            ),
                            artworkHeight: 200,
                            artworkWidth: 200,
                            nullArtworkWidget: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    5,
                                  ),
                                  topRight: Radius.circular(
                                    5,
                                  ),
                                ),
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
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: BoxFavButton(
                            song: widget.songModel[currentIndex],
                            onTap: () async {
                              if (isFav) {
                                FavDb.removeFav(
                                  widget.songModel[currentIndex].id,
                                );
                              } else {
                                FavDb.addFav(
                                  widget.songModel[currentIndex],
                                );
                              }
                              cheakFav();
                            },
                            icon: Icons.favorite,
                            color: isFav ? Colors.red : Colors.blue,
                          ),
                        ),
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
                  child: TextScroll(
                    velocity: const Velocity(
                      pixelsPerSecond: Offset(
                        50,
                        50,
                      ),
                    ),
                    widget.songModel[currentIndex].displayNameWOExt,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60,
                    right: 60,
                  ),
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
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
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
                const MusicController(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
