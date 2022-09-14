import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/music_slider.dart';
import 'package:music_wave/widgets/player_controler.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/volume_slider.dart';
import 'package:music_wave/widgets/white_space.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Player'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 174, 48, 39),
          leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    HeadingText(text: 'Next Song'),
                  ],
                ),
              ),
              SongCard(
                fontWeight: FontWeight.bold,
                titleText: 'Song 1',
                subText: 'Helloo',
                leadingUrl:
                    'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg',
                icon: Icon(Icons.favorite),
                tapAction: (() {}),
              ),
              SongCard(
                fontWeight: FontWeight.bold,
                titleText: 'Song 1',
                subText: 'Helloo',
                leadingUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwa8LQj93pfyktzQypRq78HaKu_DQ_K6Nu09tOYVxP&s',
                icon: Icon(Icons.favorite),
                tapAction: (() {}),
              ),
              const WhiteSpace10(),
              VolumeSlider(),
              const WhiteSpace10(),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: SizedBox(
              //     height: 160,
              //     child: Card(
              //       child: Image(
              //           fit: BoxFit.fill,
              //           image: NetworkImage(
              //               'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg')),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 150,
                child: ScrollSnapList(
                  itemBuilder: scroll,
                  itemCount: 5,
                  itemSize: 150,
                  onItemFocus: (index) {},
                  dynamicItemSize: true,
                  focusOnItemTap: true,
                ),
              ),
              WhiteSpace10(),
              ListTile(
                title: HeadingText(text: 'Manavalan Thug'),
                subtitle: SubTitle(titleText: 'Dabze,SA'),
                trailing: IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    Icons.playlist_add,
                  ),
                ),
              ),
              MusicSlide(),
            ],
          ),
        ));
  }

  Widget scroll(BuildContext context, int index) {
    return SizedBox(
      width: 150,
      child: Card(
        elevation: 12,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Column(
              children: [
                Image(
                  height: 142,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg'),
                ),
              ],
            )),
      ),
    );
  }
}
