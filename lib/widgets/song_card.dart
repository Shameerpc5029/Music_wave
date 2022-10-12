import 'package:flutter/material.dart';

import 'package:music_wave/widgets/fav_button.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatefulWidget {
  final AsyncSnapshot<List<SongModel>> item;

  final Widget leadingIcon;
  final int index;
  final void Function() onTap;
  final String titleText;
  final String subText;

  final FontWeight fontWeight;
  const SongCard({
    super.key,
    required this.titleText,
    required this.subText,
    required this.fontWeight,
    required this.item,
    required this.index,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: QueryArtworkWidget(
        artworkBorder: BorderRadius.circular(10),
        quality: 100,
        id: widget.item.data![widget.index].id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
            ),
            child: const Icon(Icons.music_note)),
      ),
      title: Text(
        widget.titleText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: widget.fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: FavButton(
        leadingIcon: widget.leadingIcon,
        songModel: widget.item.data![widget.index],
      ),
      subtitle: Text(
        widget.subText,
        style: const TextStyle(
            fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
