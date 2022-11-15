import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:music_wave/Controller/provider/search_provider.dart';
import 'package:music_wave/View/Player%20Screen/player_screen.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:music_wave/View/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

late List<SongModel> allSong;
List<SongModel> song = [];
final audioQuery = OnAudioQuery();

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return Provider.of<SearchProvider>(context, listen: false).allSongLoad();
    });
    log("searv");
    return Consumer<SearchProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: TextFormField(
              onChanged: (value) => provider.search(
                value,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(
                  30.0,
                  10.0,
                  20.0,
                  10.0,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                ),
                labelText: 'Search Now...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  const WhiteSpace10(),
                  song.isNotEmpty
                      ? ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: song.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              title: Text(
                                song[index].displayNameWOExt,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${song[index].artist}' == "<unknown>"
                                    ? "Unknown Artist"
                                    : '${song[index].artist}',
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              leading: QueryArtworkWidget(
                                artworkBorder: BorderRadius.circular(
                                  10,
                                ),
                                id: song[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    color: Colors.amber,
                                  ),
                                  child: const Icon(Icons.music_note),
                                ),
                              ),
                              onTap: () {
                                MusicFile.audioPlayer.setAudioSource(
                                  MusicFile.createSongList(
                                    song,
                                  ),
                                  initialIndex: index,
                                );
                                MusicFile.audioPlayer.play();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return PlayerScreen(
                                        songModel: song,
                                        // index: index,
                                      );
                                    }),
                                  ),
                                );
                              },
                            );
                          }),
                        )
                      : Center(
                          heightFactor: 1.5,
                          child: LottieBuilder.asset(
                            height: 300,
                            'assets/lottie/73061-search-not-found.json',
                          ),
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
