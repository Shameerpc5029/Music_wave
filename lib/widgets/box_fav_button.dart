import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';

import 'package:on_audio_query/on_audio_query.dart';

class BoxFavButton extends StatefulWidget {
  final SongModel song;

  const BoxFavButton({
    super.key,
    required this.song,
  });

  @override
  State<BoxFavButton> createState() => _BoxFavButtonState();
}

class _BoxFavButtonState extends State<BoxFavButton> {
  @override
  void initState() {
    super.initState();
    buttonPressed();
  }

  IconData icon = Icons.favorite_border_outlined;
  Color iconColor = Colors.blue;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(iconColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              side: BorderSide(
                color: Color.fromARGB(255, 109, 182, 207),
              ),
            ),
          ),
        ),
        onPressed: () async {
          bool isFav = await FavDb.isFav(widget.song.id);

          if (!isFav) {
            FavDb.addFav(widget.song);
          } else {
            FavDb.removeFav(widget.song.id);
          }
          buttonPressed();
        },
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: const Text(
          'Favorite',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void buttonPressed() async {
    bool isFav = await FavDb.isFav(widget.song.id);
    print(isFav);

    icon = isFav ? Icons.favorite : Icons.favorite_border_outlined;
    iconColor = isFav ? Colors.red : Colors.blue;
  }
}
