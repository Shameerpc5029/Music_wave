import 'package:flutter/material.dart';

import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class Bottom extends StatefulWidget {
  const Bottom({
    super.key,
  });

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  bool buttonClick = false;
//edit
  Text text = const Text(
    'Add Playlist',
  );
  Icon iconData = const Icon(
    Icons.playlist_add,
  );
  void onPreesButton() {
    setState(() {
      // buttonClick ? text : text = Text('data');
      if (buttonClick) {
        text = const Text(
          'Add Playlist',
        );
        iconData = const Icon(
          Icons.playlist_add,
        );
        buttonClick = false;
      } else {
        text = const Text(
          'Save Playlist',
        );
        iconData = const Icon(
          Icons.save,
        );
        buttonClick = true;
      }
    });
  }

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
        buttonClick = true;
        showBottomSheet(
          enableDrag: false,
          context: context,
          builder: ((context) {
            return Container(
              height: 200,
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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Icon(
                      //   Icons.arrow_drop_down_rounded,
                      // ),
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
            );
          }),
        );
      }),
      icon: iconData,
      label: text,
    );
  }
}
