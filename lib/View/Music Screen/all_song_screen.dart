import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/Controller/provider/request_provider.dart';
import 'package:music_wave/View/Player%20Screen/player_screen.dart';
import 'package:music_wave/View/Search%20Screen/search_screen.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:music_wave/View/Music%20Screen/Widgets/song_card.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AllSong extends StatelessWidget {
  AllSong({
    Key? key,
  }) : super(key: key);
  // @override
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return Provider.of<RequestProvider>(context, listen: false)
          .requestPermission();
    });
    log('message');
    return Consumer<RequestProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'All Songs',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Center(
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
                                            // index: index,
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
                            height: 200,
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                        );
                      },
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
                      } else {
                        return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: item.data!.length,
                          itemBuilder: ((context, index) {
                            return SongCard(
                              icon: Icons.favorite,
                              onTap: () {
                                //setState(() {
                                MusicFile.audioPlayer.setAudioSource(
                                  MusicFile.createSongList(
                                    item.data!,
                                  ),
                                  initialIndex: index,
                                );
                                MusicFile.audioPlayer.play();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return PlayerScreen(
                                        songModel: item.data!,
                                        // index: index,
                                      );
                                    }),
                                  ),
                                );
                              },
                              item: item,
                              index: index,
                              titleText: item.data![index].displayNameWOExt,
                              subText: item.data![index].artist.toString() ==
                                      "<unknown>"
                                  ? "Unknown Artist"
                                  : item.data![index].artist.toString(),
                            );
                          }),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
