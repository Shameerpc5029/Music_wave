import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GridCard extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const GridCard({
    super.key,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final audioQuery = OnAudioQuery();

    return FutureBuilder<List<SongModel>>(
      future: audioQuery.querySongs(
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

        return GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            const ScrollPhysics();

            return Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 89,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          keepOldArtwork: true,
                          quality: 100,
                          artworkFit: BoxFit.cover,
                          artworkBorder: BorderRadius.circular(0),
                          artworkHeight: 142,
                          artworkWidth: 500,
                          nullArtworkWidget: Container(
                            color: Colors.blue,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return PlayerScreen(
                                      songModel: item.data![index],
                                      audioPlayer: audioPlayer,
                                    );
                                  }),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Color.fromARGB(
                                255,
                                180,
                                30,
                                30,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    item.data![index].displayNameWOExt,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(
                    item.data![index].artist.toString() == "<unknown>"
                        ? "Unknown Artist"
                        : item.data![index].artist.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
