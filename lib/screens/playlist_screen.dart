import 'package:flutter/material.dart';
import 'package:music_wave/widgets/card.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Playlist',
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return SongCard(
              fontWeight: FontWeight.bold,
              titleText: 'Track $index',
              subText: 'Tittle $index',
              leadingUrl:
                  'assets/images/[CITYPNG.COM]HD Music Graffiti Background Illustration Art PNG - 1255x1255.png',
              icon: const Icon(
                Icons.favorite,
              ),
              tapAction: (() {}),
            );
          },
        ),
      ),
    );
  }
}
