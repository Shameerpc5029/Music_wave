import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_wave/screens/player_screen.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatefulWidget {
  final AsyncSnapshot<List<SongModel>> item;
  final AudioPlayer player;
  final int index;
  final String titleText;
  final String subText;

  final dynamic icon;

  final FontWeight fontWeight;
  const SongCard({
    super.key,
    required this.titleText,
    required this.subText,
    required this.icon,
    required this.fontWeight,
    required this.item,
    required this.index,
    required this.player,
  });

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  final audioPlayer = AudioPlayer();
  playSong(String? uri) {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
    } on Exception {
      log("Error pasing song");
    }
  }

  Color iconColor = Colors.black38;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Card(
        elevation: 1,
        child: ListTile(
          onTap: (() {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return PlayerScreen(
                  songModel: widget.item.data![widget.index],
                  audioPlayer: widget.player);
            })));
          }),
          leading: QueryArtworkWidget(
            id: widget.item.data![widget.index].id,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: CircleAvatar(
              radius: MediaQuery.of(context).size.aspectRatio * 50,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.music_note),
            ),
          ),
          // leading: ClipRRect(
          //   borderRadius: BorderRadius.circular(
          //     10,
          //   ),
          //   child: Image(
          //     fit: BoxFit.fill,
          //     width: 50,
          //     height: 50,
          //     image: AssetImage(
          //       widget.leadingUrl,
          //     ),
          //   ),
          // ),
          title: Text(
            widget.titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: widget.fontWeight,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // trailing: FavoriteButton(
          //   iconSize: 35,
          //   isFavorite: true,
          //   valueChanged: (isFavorite) {
          //     print("its Favorate");
          //   },
          // ),
          trailing: IconButton(
            color: iconColor,
            onPressed: (() {
              buttonPressed();
            }),
            icon: const Icon(
              Icons.favorite,
            ),
          ),
          subtitle: Text(
            widget.subText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  void buttonPressed() {
    if (!buttonClick) {
      setState(() {
        iconColor = Colors.red;
        buttonClick = true;
      });
    } else {
      setState(() {
        iconColor = Colors.black38;
        buttonClick = false;
      });
    }
  }
}
