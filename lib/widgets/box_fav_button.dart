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
        onPressed: () {
          buttonPressed();
        },
        icon: const Icon(Icons.favorite),
        label: const Text(
          'Favorite',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void buttonPressed() {
    if (!buttonClick) {
      setState(
        () {
          iconColor = Colors.red;
          buttonClick = true;
          FavDb.addFav(widget.song);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              margin: const EdgeInsets.all(10),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              content: const Text('Favorite Added!'),
            ),
          );
        },
      );
    } else {
      setState(
        () {
          iconColor = Colors.blue;
          buttonClick = false;
          FavDb.removeFav(widget.song.id);
        },
      );
    }
  }
}
