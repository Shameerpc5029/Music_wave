import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavButton extends StatefulWidget {
  final SongModel songModel;

  const FavButton({
    super.key,
    required this.songModel,
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavDb.musicListNotifier,
      builder:
          (BuildContext context, List<SongModel> musiclist, Widget? child) {
        return IconButton(
          icon: Icon(
            icon,
            color: iconColor,
          ),
          onPressed: (() async {
            bool isFav = await FavDb.isFav(widget.songModel.id);
            if (!isFav) {
              FavDb.addFav(widget.songModel);
            } else {
              FavDb.removeFav(widget.songModel.id);
            }
            buttonPressed();
            FavDb.musicListNotifier.notifyListeners();
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
    icon = isFav ? Icons.favorite : Icons.favorite_border_outlined;

    iconColor = isFav ? Colors.red : Colors.black38;
  }
}
