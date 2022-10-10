import 'package:flutter/material.dart';

import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/music_file.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key, required this.index});
  final int index;

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
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
                      index: widget.index,
                    );
                  }),
                ),
              );
            },
            shape: const OutlineInputBorder(
              borderSide: BorderSide(width: 0),
            ),
            tileColor: Colors.grey,
            leading: QueryArtworkWidget(
              artworkBorder: BorderRadius.circular(10),
              quality: 100,
              id: MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  child: const Icon(Icons.music_note)),
            ),
            subtitle: Text(
              '${MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!].artist}',
              style: const TextStyle(
                // fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            title: Text(
              MusicFile.playingSong[MusicFile.audioPlayer.currentIndex!]
                  .displayNameWOExt,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                // overflow: TextOverflow.ellipsis,
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
                        setState(() {});
                      } else {
                        await MusicFile.audioPlayer.play();
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 20,
                      color: Color.fromARGB(255, 185, 18, 18),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          if (!_isPlaying) {
                            MusicFile.audioPlayer.pause();
                          } else {
                            MusicFile.audioPlayer.play();
                          }
                          _isPlaying = !_isPlaying;
                        },
                      );
                    },
                    icon: StreamBuilder<bool>(
                      stream: MusicFile.audioPlayer.playingStream,
                      builder: (context, snapshot) {
                        bool? playingStage = snapshot.data;
                        if (playingStage != null && playingStage) {
                          return const Icon(
                            Icons.pause_rounded,
                            color: Color.fromARGB(255, 185, 18, 18),
                            size: 20,
                          );
                        } else {
                          return const Icon(
                            Icons.play_arrow_rounded,
                            color: Color.fromARGB(255, 185, 18, 18),
                            size: 20,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await MusicFile.audioPlayer.seekToNext();

                      setState(() {});
                      await MusicFile.audioPlayer.play();
                    },
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      size: 20,
                      color: Color.fromARGB(255, 185, 18, 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
