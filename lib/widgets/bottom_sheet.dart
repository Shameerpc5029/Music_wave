import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class Bottom extends StatefulWidget {
  Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  bool buttonClick = true;
  Text text = Text('Add Playlist');
  Icon iconData = Icon(Icons.playlist_add);
  void onPreesButton() {
    setState(() {
      if (!buttonClick) {
        text;
        iconData;
      } else {
        text = Text('Save');
        iconData = Icon(Icons.save);
      }
    });
  }

  void cancelPreesButton() {
    if (!buttonClick) {
      text;
      iconData;
    } else {
      text = Text('SAve');
      iconData = Icon(Icons.save);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Color.fromARGB(255, 174, 48, 39),
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
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            HeadingText(
                              text: 'Add Playlist',
                            ),
                            WhiteSpace10(),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                labelText: 'Playlist Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                ),
                              ),
                            ),
                            WhiteSpace10(),
                            ElevatedButton(
                                onPressed: (() {
                                  cancelPreesButton();
                                  Navigator.pop(context);
                                }),
                                child: Text('Cancel'))
                          ],
                        ),
                      ),
                    )),
              );
            }));
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
