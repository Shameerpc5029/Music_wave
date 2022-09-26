import 'package:flutter/material.dart';

class FavCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final String subtitle;
  final Widget traling;

  const FavCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.traling,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: () {
          onTap;
        },
        leading: const CircleAvatar(),
        // leading: QueryArtworkWidget(

        //   type: ArtworkType.AUDIO,
        //   keepOldArtwork: true,
        // ),
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
