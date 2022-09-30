import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/song_card.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SelectPlaylistScreen extends StatefulWidget {
  const SelectPlaylistScreen({super.key});

  @override
  State<SelectPlaylistScreen> createState() => _SelectPlaylistScreenState();
}

class _SelectPlaylistScreenState extends State<SelectPlaylistScreen> {
  bool addButtonClick = false;
  final _audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    left: 10,
                  ),
                  child: HeadingText(
                    text: 'All Songs',
                  ),
                ),
              ],
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
                        // onTap: () {
                          
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: ((context) {
                        //         return PlayerScreen(songModel: item.data!);
                        //       }),
                        //     ),
                        //   );
                        // },
                        leadingIcon: Icon(addButtonClick
                            ? Icons.playlist_add
                            : Icons.playlist_add_check),
                        item: item,
                        index: index,
                        audioPlayer: audioPlayer,
                        titleText: item.data![index].displayNameWOExt,
                        subText:
                            item.data![index].artist.toString() == "<unknown>"
                                ? "Unknown Artist"
                                : item.data![index].artist.toString(),
                        fontWeight: FontWeight.bold,
                      );
                    }),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
