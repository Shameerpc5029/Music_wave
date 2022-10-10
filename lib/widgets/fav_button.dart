import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavButton extends StatefulWidget {
  final SongModel songModel;
  final Widget leadingIcon;

  const FavButton({
    super.key,
    required this.songModel,
    required this.leadingIcon,
  });

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  // @override
  // void initState() {
  //   FavDb.getAllSongs();
  //   super.initState();
  // }

  Color iconColor = Colors.black38;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    // FavDb.getAllSongs();
    return ValueListenableBuilder(
      valueListenable: FavDb.musicListNotifier,
      builder:
          (BuildContext context, List<SongModel> musiclist, Widget? child) {
        return IconButton(
          color: iconColor,
          onPressed: (() {
            buttonPressed();
          }),
          icon: widget.leadingIcon,
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
        FavDb.removeFav(widget.songModel.id);
      });
    }
  }
}
