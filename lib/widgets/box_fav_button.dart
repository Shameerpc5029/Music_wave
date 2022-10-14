import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';

import 'package:on_audio_query/on_audio_query.dart';

class BoxFavButton extends StatefulWidget {
  final SongModel song;
  final void Function() onTap;
  final Color color;
  final IconData icon;

  const BoxFavButton({
    super.key,
    required this.song,
    required this.onTap,
    required this.icon,
    required this.color,
  });

  @override
  State<BoxFavButton> createState() => _BoxFavButtonState();
}

class _BoxFavButtonState extends State<BoxFavButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SizedBox(
        width: 200,
        child: ValueListenableBuilder(
          valueListenable: FavDb.musicListNotifier,
          builder:
              (BuildContext context, List<SongModel> musiclist, Widget? child) {
            return ElevatedButton.icon(
              label: Text(
                'Favorite',
                style:
                    TextStyle(color: widget.color, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
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
              onPressed: widget.onTap,
              icon: Icon(
                widget.icon,
                color: widget.color,
              ),
            );
          },
        ),
      ),
    );
  }
}
