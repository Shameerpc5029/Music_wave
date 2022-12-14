import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/Model/model/data_model.dart';
import 'package:music_wave/View/widgets/text.dart';
import 'package:music_wave/View/widgets/white_space.dart';
import 'package:provider/provider.dart';

GlobalKey<FormState> fromKey = GlobalKey();
final playlistNameController = TextEditingController();

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    playlistNameController.clear();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Row(
                children: const [
                  HeadingText(
                    text: 'Add Playlist',
                  ),
                ],
              ),
            ),
            const WhiteSpace(),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: fromKey,
              child: Consumer<FavDb>(
                builder: (context, consumer, child) {
                  return TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Please Enter Playlist Name";
                      }
                      final data = consumer.playlistModel
                          .map(
                            (e) => e.playlistName.trim(),
                          )
                          .toList();
                      if (data.contains(
                        playlistNameController.text.trim(),
                      )) {
                        return 'Playlist Name Already Exists';
                      }
                      return null;
                    }),
                    controller: playlistNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(
                        20.0,
                        10.0,
                        20.0,
                        10.0,
                      ),
                      labelText: 'Enter Playlist Name',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const WhiteSpace10(),
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(
                          255,
                          174,
                          48,
                          39,
                        ),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        addplaylistCliked(context);
                      } else {
                        return;
                      }
                      playlistNameController.clear();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Save Playlist',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addplaylistCliked(context) async {
    final add = playlistNameController.text.trim();

    if (add.isNotEmpty) {
      final playAdd = ListModel(
        playlistName: add,
      );
      // FavDb.addPlaylist(
      //   playAdd,
      // );
      Provider.of<FavDb>(context, listen: false).addPlaylist(playAdd);
    }
  }
}
