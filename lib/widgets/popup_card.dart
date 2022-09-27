import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';

class PopUpcard extends StatelessWidget {
  final Function onPress;
  const PopUpcard({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      splashRadius: 50,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      offset: const Offset(
        -30,
        20,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              onTap: () {
                onPress;
              },
              value: 1,
              child: Row(
                children: const [
                  Icon(
                    Icons.favorite,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Unlike'),
                ],
              )),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: const [
                Icon(
                  Icons.playlist_add,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Add Playlist',
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: const [
                Icon(
                  Icons.share,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Share Music',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
