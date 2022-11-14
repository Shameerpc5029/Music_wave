import 'package:flutter/material.dart';
import 'package:music_wave/Controller/provider/miniplayer_provider.dart';
import 'package:music_wave/View/Player%20Screen/player_screen.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
  });
  // final int index;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      return Provider.of<MiniPlayerProvider>(context, listen: false)
          .miniplayer();
    });
    return Consumer<MiniPlayerProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return PlayerScreen(
                          songModel: MusicFile.playingSong,
                          // index: widget.index,
                        );
                      }),
                    ),
                  );
                },
                shape: const OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                ),
                tileColor: Colors.blueGrey,
                leading: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(10),
                  quality: 100,
                  id: MusicFile
                      .playingSong[MusicFile.audioPlayer.currentIndex!].id,
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
                    child: const Icon(
                      Icons.music_note,
                    ),
                  ),
                ),
                title: Text(
                  MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!]
                      .displayNameWOExt,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                ),
                subtitle: Text(
                  '${MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!].artist}' ==
                          "<unknown>"
                      ? "Unknown Artist"
                      : '${MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!].artist}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (MusicFile.audioPlayer.hasPrevious) {
                            await MusicFile.audioPlayer.seekToPrevious();
                            await MusicFile.audioPlayer.play();
                            // setState(() {});
                          } else {
                            await MusicFile.audioPlayer.play();
                            // setState(() {});
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (MusicFile.audioPlayer.playing) {
                            await MusicFile.audioPlayer.pause();
                          } else {
                            await MusicFile.audioPlayer.play();
                          }
                        },
                        icon: StreamBuilder<bool>(
                          stream: MusicFile.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            bool? playingStage = snapshot.data;
                            if (playingStage != null && playingStage) {
                              return const Icon(
                                Icons.pause_rounded,
                                color: Colors.white,
                                size: 20,
                              );
                            } else {
                              return const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 20,
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await MusicFile.audioPlayer.seekToNext();

                          await MusicFile.audioPlayer.play();
                        },
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
