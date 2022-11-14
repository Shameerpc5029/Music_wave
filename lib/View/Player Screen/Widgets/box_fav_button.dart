import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';

class BoxFavButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SizedBox(
          width: 200,
          child: ElevatedButton.icon(
            label: Text(
              'Favorite',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
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
            onPressed: onTap,
            icon: Icon(
              icon,
              color: color,
            ),
          )),
    );
  }
}
