import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final String subtitle;
  final Widget traling;
  final int id;

  const FavCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.traling,
    required this.onTap,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: () {
          onTap;
        },
        // leading: const CircleAvatar(),
        leading: QueryArtworkWidget(
          id: id,
          type: ArtworkType.AUDIO,
          keepOldArtwork: true,
          nullArtworkWidget: CircleAvatar(),

          // id: id,
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
      ),
    );
  }
}
