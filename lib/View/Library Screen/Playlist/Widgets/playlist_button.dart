import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistButton extends StatelessWidget {
  final SongModel songModel;

  final String folderName;
  PlaylistButton({
    super.key,
    required this.songModel,
    required this.folderName,
  });

  // @override
  Color iconColor = Colors.black38;

  IconData icon = Icons.radio_button_off;

  bool buttonClick = false;

  @override
  Widget build(BuildContext context) {

    return Consumer<FavDb>(
      builder: (context, value, child) {
        return IconButton(
          color: iconColor,
          onPressed: (() {
            // buttonPressed();
            if (!buttonClick) {
              //setState(() {
              iconColor = Colors.blue;
              icon = Icons.radio_button_checked;
              buttonClick = true;
              value.addPlaylistMusic(songModel, folderName);
              // FavDb.addPlaylistMusic(
              //   songModel,
              //   folderName,
              // );
              //   });
            } else {
              // setState(() {
              icon = Icons.radio_button_off;
              // FavDb.removePlaylistMusic(
              //   songModel.id,
              //   folderName,
              // );
              value.removePlaylistMusic(songModel.id, folderName);
              iconColor = Colors.black38;
              buttonClick = false;
              // });

            }
          }),
          icon: Icon(
            icon,
          ),
        );
      },
    );
  }
}
