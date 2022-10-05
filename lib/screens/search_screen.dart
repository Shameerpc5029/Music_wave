import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/music_file.dart';

import 'package:music_wave/widgets/white_space.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

late List<SongModel> allSong;

List<SongModel> song = [];
final audioPlayer = AudioPlayer();
final audioQuery = OnAudioQuery();
int currentIndex = 0;

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    allSongLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 5,
                ),
                child: TextFormField(
                  onChanged: (value) => search(value),
                  cursorColor: const Color.fromARGB(
                    255,
                    174,
                    48,
                    39,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic_none_rounded,
                          color: Color.fromARGB(
                            255,
                            174,
                            48,
                            39,
                          ),
                        )),
                    hintText: 'All Songs',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(
                        255,
                        174,
                        48,
                        39,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(
                      20.0,
                      10.0,
                      20.0,
                      10.0,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(
                        255,
                        174,
                        48,
                        39,
                      ),
                    ),
                    labelText: 'Search Now...',
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(
                        255,
                        174,
                        48,
                        39,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                ),
              ),
              const WhiteSpace10(),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 40,
              //   ),
              //   child: Row(
              //     children: const [
              //       HeadingText(
              //         text: 'History',
              //       ),
              //     ],
              //   ),
              // ),
              // Row(
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.only(
              //         left: 40,
              //       ),
              //       child: Text(
              //         'One day',
              //       ),
              //     ),
              //     IconButton(
              //       splashRadius: 5,
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.close,
              //         size: 10,
              //       ),
              //     ),
              //     const Text(
              //       'Ole melody',
              //     ),
              //     IconButton(
              //       splashRadius: 5,
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.close,
              //         size: 10,
              //       ),
              //     ),
              //   ],
              // ),
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
                          ),
                          subtitle: Text(
                            '${song[index].artist}',
                            maxLines: 1,
                          ),
                          leading: QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(10),
                            id: song[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber,
                              ),
                              child: const Icon(Icons.music_note),
                            ),
                          ),
                          onTap: () {
                            MusicFile.audioPlayer.setAudioSource(
                              MusicFile.createSongList(song),
                              initialIndex: index,
                            );
                            MusicFile.audioPlayer.play();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) {
                                  return PlayerScreen(
                                    songModel: song,
                                    index: currentIndex,
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
  }

  void allSongLoad() async {
    allSong = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    song = allSong;
  }

  void search(String keybord) {
    List<SongModel> results = [];
    if (keybord.isEmpty) {
      results = allSong;
    } else {
      results = allSong
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(keybord.toLowerCase()))
          .toList();
    }
    setState(() {
      song = results;
    });
  }
}
