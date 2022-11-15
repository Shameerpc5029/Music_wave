import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_wave/Controller/provider/player_provider.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:music_wave/View/widgets/white_space.dart';
import 'package:provider/provider.dart';

bool repetOn = true;
bool shuffleOn = true;

class MusicController extends StatelessWidget {
  const MusicController({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (shuffleOn) {
                  MusicFile.audioPlayer.shuffle();
                  MusicFile.audioPlayer.setShuffleModeEnabled(
                    true,
                  );
                } else {
                  MusicFile.audioPlayer.setShuffleModeEnabled(
                    false,
                  );
                }
                shuffleOn = !shuffleOn;
                Provider.of<PlayerProvider>(context, listen: false)
                    .notifyListeners();
              },
              icon: Icon(
                shuffleOn ? Icons.shuffle : Icons.shuffle_on_outlined,
              ),
              color: Colors.white,
            ),
            RawMaterialButton(
              padding: const EdgeInsets.all(
                15,
              ),
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              onPressed: () async {
                if (MusicFile.audioPlayer.hasPrevious) {
                  await MusicFile.audioPlayer.seekToPrevious();
                  await MusicFile.audioPlayer.play();
                } else {
                  await MusicFile.audioPlayer.play();
                }
              },
              child: const Icon(
                Icons.skip_previous_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
            RawMaterialButton(
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              padding: const EdgeInsets.all(
                15,
              ),
              onPressed: () async {
                if (MusicFile.audioPlayer.playing) {
                  await MusicFile.audioPlayer.pause();
                } else {
                  await MusicFile.audioPlayer.play();
                }
              },
              child: StreamBuilder<bool>(
                stream: MusicFile.audioPlayer.playingStream,
                builder: (context, snapshot) {
                  bool? playingStage = snapshot.data;
                  if (playingStage != null && playingStage) {
                    return const Icon(
                      Icons.pause_rounded,
                      color: Colors.white,
                      size: 45,
                    );
                  } else {
                    return const Icon(
                      color: Colors.white,
                      Icons.play_arrow_rounded,
                      size: 45,
                    );
                  }
                },
              ),
            ),
            RawMaterialButton(
              padding: const EdgeInsets.all(15),
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              onPressed: () async {
                await MusicFile.audioPlayer.seekToNext();
                await MusicFile.audioPlayer.play();
              },
              child: const Icon(
                Icons.skip_next_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                if (repetOn) {
                  MusicFile.audioPlayer.setLoopMode(
                    LoopMode.one,
                  );
                } else {
                  MusicFile.audioPlayer.setLoopMode(
                    LoopMode.off,
                  );
                }
                repetOn = !repetOn;
                Provider.of<PlayerProvider>(context, listen: false)
                    .notifyListeners();
              },
              icon: Icon(
                repetOn ? Icons.repeat : Icons.repeat_on_outlined,
              ),
              color: Colors.white,
            ),
          ],
        ),
        const WhiteSpace40(),
      ],
    );
  }
}
