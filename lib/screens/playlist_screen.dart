import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/screens/select_playlist_screen.dart';
import 'package:music_wave/widgets/playlist_card.dart';
import 'package:music_wave/widgets/playlist_song_card.dart';
import 'package:music_wave/widgets/popup_card.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  PlaylistScreen({
    super.key,
  });

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    FavDb.getAllPlaylistSongs();
    super.initState();
  }

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return SelectPlaylistScreen();
          })));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Playlist',
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
      body: SingleChildScrollView(
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

            return ValueListenableBuilder(
              valueListenable: FavDb.playListMusicNotifier,
              builder:
                  (BuildContext context, List<SongModel> music, Widget? child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: music.length,
                  itemBuilder: (context, index) {
                    return PlaylistCard(
                        title: music[index].title,
                        subtitle: music[index].artist.toString() == "<unknown>"
                            ? "Unknown Artist"
                            : music[index].artist.toString(),
                        traling: PopUpcard(
                          onPress: () {
                            setState(() {
                              FavDb.removeFav(music[index].id);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                margin: const EdgeInsets.all(10),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 1),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                content: Text(
                                  '${music[index].title} Unliked!',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                        id: music[index].id,
                        onTap: () {});
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
