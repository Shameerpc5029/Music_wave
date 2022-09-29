import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class ShowBottomSheet extends StatelessWidget {
  final void Function() savePress;
  final void Function() closePress;

  final TextEditingController controller;
  const ShowBottomSheet(
      {super.key,
      required this.controller,
      required this.savePress,
      required this.closePress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: closePress,
                    icon: Icon(
                      Icons.close_rounded,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: const [
                  HeadingText(
                    text: 'Add Playlist',
                  ),
                ],
              ),
            ),
            const WhiteSpace(),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  10.0,
                  20.0,
                  10.0,
                ),
                labelText: 'Playlist Name',
                hintText: 'Enter Playlist Name',
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),
            const WhiteSpace10(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(
                            255,
                            174,
                            48,
                            39,
                          ),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: savePress,
                      icon: const Icon(Icons.save),
                      label: const Text('Save Playlist'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
