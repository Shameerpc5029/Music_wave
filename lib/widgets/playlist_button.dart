import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';

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
          icon: Icon(icon),
        );
      },
    );
  }

  void buttonPressed() {
    if (!buttonClick) {
      setState(() {
        iconColor = Colors.grey;
        icon = Icons.circle_rounded;
        buttonClick = true;
        FavDb.addPlaylistMusic(widget.songModel, widget.folderName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 174, 48, 39),
            margin: const EdgeInsets.only(bottom: 5, right: 30, left: 30),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.transparent)),
            content: const Text(
              'Song Added!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      });
    } else {
      setState(() {
        icon = Icons.radio_button_off;
        FavDb.removePlaylistMusic(widget.songModel.id, widget.folderName);
        iconColor = Colors.black38;
        buttonClick = false;
      });
    }
  }
}
