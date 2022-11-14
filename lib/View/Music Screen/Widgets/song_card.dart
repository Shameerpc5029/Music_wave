import 'package:flutter/material.dart';
import 'package:music_wave/View/Music%20Screen/Widgets/fav_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatelessWidget {
  final AsyncSnapshot<List<SongModel>> item;
  final IconData icon;

  final int index;
  final void Function() onTap;
  final String titleText;
  final String subText;

  const SongCard({
    super.key,
    required this.titleText,
    required this.subText,
    required this.item,
    required this.index,

    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: QueryArtworkWidget(
        artworkBorder: BorderRadius.circular(
          10,
        ),
        quality: 100,
        id: item.data![index].id,
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
        titleText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: FavButton(
        songModel: item.data![index],
      ),
      subtitle: Text(
        subText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
