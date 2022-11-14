import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:music_wave/View/Library%20Screen/Playlist/Widgets/playlist_song_card.dart';
import 'package:music_wave/View/widgets/text.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SelectPlaylistScreen extends StatefulWidget {
  final String folderName;
  const SelectPlaylistScreen({
    super.key,
    required this.folderName,
  });

  @override
  State<SelectPlaylistScreen> createState() => _SelectPlaylistScreenState();
}

class _SelectPlaylistScreenState extends State<SelectPlaylistScreen> {
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            10,
          ),
          child: Column(
            children: [
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
                        return PlaylistSongCard(
                          folderName: widget.folderName,
                          titleText: item.data![index].displayNameWOExt,
                          subText:
                              item.data![index].artist.toString() == "<unknown>"
                                  ? "Unknown Artist"
                                  : item.data![index].artist.toString(),
                          fontWeight: FontWeight.bold,
                          item: item,
                          index: index,
                          audioPlayer: MusicFile.audioPlayer,
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
  }
}
