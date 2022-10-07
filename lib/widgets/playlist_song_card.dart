

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_wave/widgets/playlist_button.dart';

import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongCard extends StatefulWidget {
  final AsyncSnapshot<List<SongModel>> item;
  final AudioPlayer audioPlayer;
  final Widget leadingIcon;
  final String folderName;
  final int index;
  // final void Function() onTap;
  final String titleText;
  final String subText;

  final FontWeight fontWeight;
  const PlaylistSongCard({
    super.key,
    required this.titleText,
    required this.subText,
    required this.fontWeight,
    required this.item,
    required this.index,
    required this.audioPlayer,
    required this.leadingIcon,
    required this.folderName,
  });

  @override
  State<PlaylistSongCard> createState() => _PlaylistSongCardState();
}

class _PlaylistSongCardState extends State<PlaylistSongCard> {
  // playSong(String? uri) {
  //   try {
  //     widget.audioPlayer.setAudioSource(
  //       AudioSource.uri(
  //         Uri.parse(uri!),
  //       ),
  //     );
  //     widget.audioPlayer.play();
  //   } on Exception {
  //     log("Error pasing song");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // FavDb.getAllSongs();
    return ListTile(
      onTap: (() {
        // MusicFile.audioPlayer.setAudioSource(
        //     MusicFile.createSongList(widget.item.data!,),
        //     initialIndex: widget.index,);
        // MusicFile.audioPlayer.play();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: ((context) {
        //       return PlayerScreen(
        //         songModel: widget.item.data!,
        //         index: widget.index,
        //       );
        //     }),
        //   ),
        // );
      }),
      leading: QueryArtworkWidget(
        artworkBorder: BorderRadius.circular(10),
        id: widget.item.data![widget.index].id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
          ),
          child: const Icon(Icons.music_note),
        ),
      ),
      title: Text(
        widget.titleText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: widget.fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: PlaylistButton(
          folderName: widget.folderName,
          songModel: widget.item.data![widget.index],
          leadingIcon: widget.leadingIcon),
      subtitle: Text(
        widget.subText,
        style: const TextStyle(
            fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
