import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget traling;

  const FavCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.traling,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
          onTap: () {},
          leading: CircleAvatar(),
          // leading: QueryArtworkWidget(

          //   type: ArtworkType.AUDIO,
          //   keepOldArtwork: true,
          // ),
          title: Text(
            title,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              color: Colors.black38,
            ),
          ),
          trailing: traling),
    );
  }
}
