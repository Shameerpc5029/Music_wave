import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScrollCard extends StatefulWidget {
  final dynamic id;
  final ArtworkType type;
  const ScrollCard({super.key, required this.id, required this.type});

  @override
  State<ScrollCard> createState() => _ScrollCardState();
}

class _ScrollCardState extends State<ScrollCard> {
  Color iconColor = Colors.black38;
  bool buttonClick = false;

  @override
  Widget build(BuildContext context) {
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
                  QueryArtworkWidget(
                      id: widget.id,
                      type: widget.type,
                      keepOldArtwork: true,
                      quality: 100,
                      artworkFit: BoxFit.fill,
                      artworkBorder: BorderRadius.circular(0),
                      artworkHeight: 142,
                      artworkWidth: 500,
                      nullArtworkWidget: Container(
                        color: Colors.blue,
                        height: 142,
                        child: const Center(
                            child: Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 50,
                        )),
                      )),
                  // const Image(
                  //   height: 142,
                  //   fit: BoxFit.cover,
                  //   image: AssetImage(
                  //     'assets/images/Thallumaala-Malayalam-2022-20220816184649-500x500.jpeg',
                  //   ),
                  // ),
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
                        icon: const Icon(Icons.favorite),
                        color: iconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
