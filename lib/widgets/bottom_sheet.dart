import 'package:flutter/material.dart';

import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  bool buttonClick = true;
  Text text = const Text(
    'Add Playlist',
  );
  Icon iconData = const Icon(
    Icons.playlist_add,
  );
  void onPreesButton() {
    setState(() {
      if (!buttonClick) {
        text = const Text(
          'Add Playlist',
        );
        iconData = const Icon(
          Icons.playlist_add,
        );
        buttonClick = true;
      } else {
        text = const Text(
          'Save',
        );
        iconData = const Icon(
          Icons.save,
        );
        buttonClick = false;
      }
    });
  }

  // void cancelPreesButton() {
  //   if (!buttonClick) {
  //     text;
  //     iconData;
  //   } else {
  //     text = Text('SAve');
  //     iconData = Icon(Icons.save);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: const Color.fromARGB(
        255,
        174,
        48,
        39,
      ),
      onPressed: (() {
        onPreesButton();
        buttonClick = false;
        showBottomSheet(
          context: context,
          builder: ((context) {
            return SizedBox(
              height: 220,
              width: 400,
              child: Container(
                padding: const EdgeInsets.all(
                  10,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    255,
                    255,
                    255,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                        const HeadingText(
                          text: 'Add Playlist',
                        ),
                        const WhiteSpace10(),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                              20.0,
                              10.0,
                              20.0,
                              10.0,
                            ),
                            labelText: 'Playlist Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
                            ),
                          ),
                        ),
                        const WhiteSpace10(),
                        ElevatedButton(
                          onPressed: (() {
                            onPreesButton();
                            Navigator.pop(context);
                          }),
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
      icon: iconData,
      label: text,
    );
    // return FloatingActionButton(
    //   onPressed: () {
    //     if (!bottonclik) {
    //       setState(() {
    //         IconData;
    //         bottonclik = true;
    //       });
    //     } else {
    //       setState(() {
    //         IconData = Icon(Icons.save);
    //         bottonclik = false;
    //       });
    //     }
    //   },
    //   child: IconData,
    // );
  }
}
