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
              'Favorite Added!',
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
        iconColor = Colors.black38;
        buttonClick = false;
      });
    }
  }
}
