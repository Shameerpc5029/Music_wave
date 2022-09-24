import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavButton extends StatefulWidget {
  final SongModel songModel;
  const FavButton({super.key, required this.songModel});

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  Color iconColor = Colors.black38;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    FavDb.getAllSongs();
    return ValueListenableBuilder(
      valueListenable: FavDb.musicListNotifier,
      builder:
          (BuildContext context, List<SongModel> musiclist, Widget? child) {
        return IconButton(
          color: iconColor,
          onPressed: (() {
            buttonPressed();

            // Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            //   return PlayerScreen(
            //     song: widget.item.data![widget.index],
            //     audioPlayer: audioPlayer,
            //   );
            // })));
          }),
          icon: const Icon(
            Icons.favorite,
          ),
        );
      },
    );
  }

  void buttonPressed() {
    if (!buttonClick) {
      setState(() {
        iconColor = Colors.red;
        buttonClick = true;
        FavDb.addFav(widget.songModel);
      });
    } else {
      setState(() {
        iconColor = Colors.black38;
        buttonClick = false;
      });
    }
  }
}
