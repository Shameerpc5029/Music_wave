import 'package:flutter/material.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/grid_card.dart';
import 'package:music_wave/widgets/text.dart';

class AllSong extends StatelessWidget {
  const AllSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: HeadingText(text: 'Suggested Songs '),
              ),
            ],
          ),
          GridCard(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: HeadingText(text: 'All Songs'),
              ),
            ],
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return SongCard(
                titleText: 'Manavalan Thug',
                subText: 'Dabzee',
                leadingUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwa8LQj93pfyktzQypRq78HaKu_DQ_K6Nu09tOYVxP&s',
                icon: Icon(Icons.favorite),
                tapAction: (() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return PlayerScreen();
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
