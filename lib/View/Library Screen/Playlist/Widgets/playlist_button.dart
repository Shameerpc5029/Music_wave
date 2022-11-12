import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';

import 'package:on_audio_query/on_audio_query.dart';

class PlaylistButton extends StatefulWidget {
  final SongModel songModel;

  final String folderName;
  const PlaylistButton({
    super.key,
    required this.songModel,
    required this.folderName,
  });

  @override
  State<PlaylistButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<PlaylistButton> {
  @override
  void initState() {
    FavDb.getAllSongs();
    super.initState();
  }

  Color iconColor = Colors.black38;
  IconData icon = Icons.radio_button_off;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavDb.musicListNotifier,
      builder:
          (BuildContext context, List<SongModel> musiclist, Widget? child) {
        return IconButton(
          color: iconColor,
          onPressed: (() {
            buttonPressed();
          }),
          icon: Icon(
            icon,
          ),
        );
      },
    );
  }

  void buttonPressed() {
    if (!buttonClick) {
      setState(() {
        iconColor = Colors.blue;
        icon = Icons.radio_button_checked;
        buttonClick = true;
        FavDb.addPlaylistMusic(
          widget.songModel,
          widget.folderName,
        );
      });
    } else {
      setState(() {
        icon = Icons.radio_button_off;
        FavDb.removePlaylistMusic(
          widget.songModel.id,
          widget.folderName,
        );
        iconColor = Colors.black38;
        buttonClick = false;
      });
    }
  }
}
