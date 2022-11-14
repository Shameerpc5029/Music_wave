import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/View/Player%20Screen/player_screen.dart';
import 'package:music_wave/View/Library%20Screen/Playlist/select_playlist_screen.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:music_wave/View/Library%20Screen/Playlist/Widgets/playlist_card.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatelessWidget {
  final String folderName;
  PlaylistScreen({
    super.key,
    required this.folderName,
  });

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FavDb>(context, listen: false)
          .getAllPlaylistSongs(folderName);
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) {
                return SelectPlaylistScreen(
                  folderName: folderName,
                );
              }),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          folderName.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  height: 569,
                  child: Center(
                    child: Text(
                      'No Songs Found',
                    ),
                  ),
                );
              } else {
                return Consumer<FavDb>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: value.songsPlaylist.length,
                      itemBuilder: (context, index) {
                        return PlaylistCard(
                          trailing: IconButton(
                            onPressed: () {
                              // FavDb.removePlaylistMusic(
                              //   music[index].id,
                              //   folderName,
                              // );
                              value.removePlaylistMusic(
                                  value.songsPlaylist[index].id, folderName);
                            },
                            icon: const Icon(
                              Icons.delete_sweep_outlined,
                            ),
                          ),
                          title: value.songsPlaylist[index].title,
                          subtitle: value.songsPlaylist[index].artist
                                      .toString() ==
                                  "<unknown>"
                              ? "Unknown Artist"
                              : value.songsPlaylist[index].artist.toString(),
                          id: value.songsPlaylist[index].id,
                          onTap: () {
                            List<SongModel> playList = [...value.songsPlaylist];
                            MusicFile.audioPlayer.stop();
                            MusicFile.audioPlayer.setAudioSource(
                              MusicFile.createSongList(
                                playList,
                              ),
                              initialIndex: index,
                            );
                            MusicFile.audioPlayer.play();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) {
                                  return PlayerScreen(
                                    // index: index,
                                    songModel: playList,
                                  );
                                }),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
