import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_wave/View/Library%20Screen/Playlist/Widgets/playlist_button.dart';

import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongCard extends StatefulWidget {
  final AsyncSnapshot<List<SongModel>> item;
  final AudioPlayer audioPlayer;
  final String folderName;
  final int index;
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
    required this.folderName,
  });

  @override
  State<PlaylistSongCard> createState() => _PlaylistSongCardState();
}

class _PlaylistSongCardState extends State<PlaylistSongCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: QueryArtworkWidget(
        artworkBorder: BorderRadius.circular(
          10,
        ),
        id: widget.item.data![widget.index].id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: Colors.amber,
          ),
          child: const Icon(
            Icons.music_note,
          ),
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
      ),
      subtitle: Text(
        widget.subText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
