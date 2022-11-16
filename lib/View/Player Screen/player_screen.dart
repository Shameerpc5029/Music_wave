import 'package:flutter/material.dart';

import 'package:music_wave/Controller/provider/player_provider.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';

import 'package:music_wave/View/Player%20Screen/Widgets/box_fav_button.dart';
import 'package:music_wave/View/bottom_nav.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:music_wave/View/Player%20Screen/Widgets/music_slider.dart';
import 'package:music_wave/View/Player%20Screen/Widgets/player_controler.dart';
import 'package:music_wave/View/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayerScreen extends StatelessWidget {

  const PlayerScreen({
    super.key,
    required this.songModel,

  });
  final List<SongModel> songModel;


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return Provider.of<PlayerProvider>(context, listen: false).player();
    });
    return Consumer<PlayerProvider>(
      builder: (context, value, child) {
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
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ), (route) => false);
                // Navigator.pop(context);
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
                                id: MusicFile
                                    .playingSong[value.currentIndex].id,
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
                                song: songModel[value.currentIndex],
                                onTap: () async {
                                  if (value.isFav) {
                                    FavDb().removeFav(
                                      songModel[value.currentIndex].id,
                                    );
                                  } else {
                                    FavDb().addFav(
                                      songModel[value.currentIndex],
                                    );
                                  }
                                  value.cheakFav();
                                },
                                icon: Icons.favorite,
                                color: value.isFav ? Colors.red : Colors.blue,
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
                        songModel[value.currentIndex].displayNameWOExt,
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
                        songModel[value.currentIndex].artist.toString() ==
                                "<unknown>"
                            ? "Unknown Artist"
                            : songModel[value.currentIndex].artist.toString(),
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
                            value.position.toString().split(".")[0],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: MusicSlide(
                              duration: value.duration,
                              position: value.position,
                              audioPlayer: MusicFile.audioPlayer,
                            ),
                          ),
                          Text(
                            value.duration.toString().split(".")[0],
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
      },
    );
  }
}
