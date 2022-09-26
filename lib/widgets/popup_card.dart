import 'package:flutter/material.dart';

class PopUpcard extends StatelessWidget {
  const PopUpcard({super.key});

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
