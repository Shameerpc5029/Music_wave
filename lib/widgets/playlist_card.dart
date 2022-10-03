import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistCard extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final String subtitle;
  final Widget traling;
  final int id;

  const PlaylistCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.traling,
    required this.id,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: QueryArtworkWidget(
        artworkBorder: BorderRadius.circular(10),
        id: id,
        type: ArtworkType.AUDIO,
        keepOldArtwork: true,
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
        title,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          color: Colors.black38,
        ),
      ),
      trailing: traling,
    );
  }
}
