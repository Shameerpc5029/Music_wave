import 'package:flutter/material.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/music_slider.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/volume_slider.dart';
import 'package:music_wave/widgets/white_space.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Color iconColor = Colors.black38;
  bool buttonClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Player',
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
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                ),
                child: Row(
                  children: const [
                    HeadingText(
                      text: 'Next Song',
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: ((context, index) {
                    return SongCard(
                      fontWeight: FontWeight.bold,
                      titleText: 'Song ${1 + index}',
                      subText: 'Artist ${1 + index}',
                      leadingUrl:
                          'assets/images/[CITYPNG.COM]HD Music Graffiti Background Illustration Art PNG - 1255x1255.png',
                      icon: const Icon(Icons.favorite),
                      tapAction: (() {}),
                    );
                  })),
              const WhiteSpace10(),
              const VolumeSlider(),
              const WhiteSpace10(),
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
              const WhiteSpace10(),
              ListTile(
                title: const HeadingText(
                  text: 'Manavalan Thug',
                ),
                subtitle: const SubTitle(
                  titleText: 'Dabze,SA',
                ),
                trailing: IconButton(
                  onPressed: (() {}),
                  icon: const Icon(
                    Icons.playlist_add,
                  ),
                ),
              ),
              const MusicSlide(),
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
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    const Image(
                      height: 142,
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/Thallumaala-Malayalam-2022-20220816184649-500x500.jpeg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            buttonPressed();
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: iconColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),),
      ),
    );
  }

  void buttonPressed() {
    if (!buttonClick) {
      setState(() {
        iconColor = Colors.red;
        buttonClick = true;
      });
    } else {
      setState(() {
        iconColor = Colors.black38;
        buttonClick = false;
      });
    }
  }
}
