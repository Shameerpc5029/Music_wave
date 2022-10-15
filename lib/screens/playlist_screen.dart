import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/screens/select_playlist_screen.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:music_wave/widgets/playlist_card.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  final String folderName;
  const PlaylistScreen({
    super.key,
    required this.folderName,
  });

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      FavDb.getAllPlaylistSongs(widget.folderName);
    });
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) {
                return SelectPlaylistScreen(
                  folderName: widget.folderName,
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
          widget.folderName.toUpperCase(),
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
                return ValueListenableBuilder(
                  valueListenable: FavDb.playListMusicNotifier,
                  builder: (BuildContext context, List<SongModel> music,
                      Widget? child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: music.length,
                      itemBuilder: (context, index) {
                        return PlaylistCard(
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                FavDb.removePlaylistMusic(
                                  music[index].id,
                                  widget.folderName,
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.delete_sweep_outlined,
                            ),
                          ),
                          title: music[index].title,
                          subtitle:
                              music[index].artist.toString() == "<unknown>"
                                  ? "Unknown Artist"
                                  : music[index].artist.toString(),
                          id: music[index].id,
                          onTap: () {
                            List<SongModel> playList = [...music];
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
                                    index: index,
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
