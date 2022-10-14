import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GridCarousal extends StatefulWidget {
  const GridCarousal({super.key});

  @override
  State<GridCarousal> createState() => _GridCarousalState();
}

class _GridCarousalState extends State<GridCarousal> {
  final audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.connectionState == ConnectionState.waiting) {
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

          return CarouselSlider.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index, realIndex) {
              return Center(
                child: Card(
                  elevation: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: InkWell(
                    onTap: () {
                      MusicFile.audioPlayer.setAudioSource(
                          MusicFile.createSongList(item.data!),
                          initialIndex: index);
                      MusicFile.audioPlayer.play();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return PlayerScreen(
                              songModel: item.data!,
                              index: index,
                            );
                          }),
                        ),
                      );
                    },
                    child: QueryArtworkWidget(
                      id: item.data![index].id,
                      type: ArtworkType.AUDIO,
                      keepOldArtwork: true,
                      quality: 100,
                      artworkFit: BoxFit.cover,
                      artworkBorder: BorderRadius.circular(10),
                      artworkHeight: 142,
                      artworkWidth: 500,
                      nullArtworkWidget: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        height: 142,
                        child: const Center(
                          child: Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 0.3,
              enableInfiniteScroll: true,
              disableCenter: true,
              autoPlayAnimationDuration: const Duration(
                seconds: 3,
              ),
              autoPlayInterval: const Duration(
                seconds: 3,
              ),
              // aspectRatio: 100,
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
          );
        },
      ),
    );
  }
}
