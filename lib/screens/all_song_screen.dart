import 'package:flutter/material.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/grid_card.dart';
import 'package:music_wave/widgets/song_card.dart';
import 'package:music_wave/widgets/text.dart';

class AllSong extends StatelessWidget {
  const AllSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(
        20,
      ),
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: HeadingText(
                  text: 'Suggested Songs',
                ),
              ),
            ],
          ),
          const GridCard(),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: HeadingText(
                  text: 'All Songs',
                ),
              ),
            ],
          ),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return SongCard(
                titleText: 'Manavalan Thug',
                subText: 'Dabzee',
                leadingUrl:
                    'assets/images/Thallumaala-Malayalam-2022-20220816184649-500x500.jpeg',
                icon: const Icon(
                  Icons.favorite,
                ),
                tapAction: (() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return const PlayerScreen();
                  })));
                }),
                fontWeight: FontWeight.bold,
              );
            }),
          ),
        ],
      ),
    ));
  }
}
