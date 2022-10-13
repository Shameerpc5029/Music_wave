import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavButton extends StatefulWidget {
  final SongModel songModel;
  final IconData icon;
  const FavButton({
    super.key,
    required this.songModel,
    required this.icon,
  });

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  @override
  void initState() {
    super.initState();

    buttonPressed();
  }

  IconData icon = Icons.favorite_border_outlined;
  Color iconColor = Colors.black38;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavDb.musicListNotifier,
      builder:
          (BuildContext context, List<SongModel> musiclist, Widget? child) {
        return IconButton(
          icon: Icon(
            widget.icon,
            color: iconColor,
          ),
          onPressed: (() {
            setState(
              () {
                if (!buttonClick) {
                  FavDb.addFav(widget.songModel);
                  buttonClick = true;
                } else {
                  FavDb.removeFav(widget.songModel.id);
                  buttonClick = false;
                }
                buttonPressed();
              },
            );
          }),
        );
      },
    );
  }

  // void buttonPressed() async {
  //   bool isFav = await FavDb.isFav(widget.songModel.id);

  //   if (!isFav) {
  //     setState(() {
  //       iconColor = Colors.red;

  //       FavDb.addFav(widget.songModel);
  //     });

  //     print(isFav);
  //   } else {
  //     setState(() {
  //       iconColor = Colors.black38;

  //       FavDb.removeFav(widget.songModel.id);
  //     });
  //   }
  // }

  void buttonPressed() async {
    bool isFav = await FavDb.isFav(widget.songModel.id);
    print(isFav);
    // icon = isFav ? Icons.favorite : Icons.favorite_border_outlined;
    iconColor = isFav ? Colors.red : Colors.black38;
  }
}
