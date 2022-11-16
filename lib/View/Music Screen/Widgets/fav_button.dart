// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavButton extends StatelessWidget {
  final SongModel songModel;

  FavButton({
    super.key,
    required this.songModel,
  });

  IconData icon = Icons.favorite_border_outlined;

  Color iconColor = Colors.black38;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      buttonPressed(context);
    });
    return Consumer<FavDb>(
      builder: (context, value, child) {
        return IconButton(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          onPressed: (() async {
            bool isFav = await value.isFav(songModel.id);
            if (!isFav) {
              value.addFav(songModel);
            } else {
              value.removeFav(songModel.id);
            }

            buttonPressed(context);
          }),
        );
      },
    );
  }

  void buttonPressed(context) async {
    bool isFav =
        await Provider.of<FavDb>(context, listen: false).isFav(songModel.id);
    icon = isFav ? Icons.favorite : Icons.favorite_border_outlined;
    iconColor = isFav ? Colors.red : Colors.black38;
  }
}
