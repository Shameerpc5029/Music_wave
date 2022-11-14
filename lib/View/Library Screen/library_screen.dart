import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/Model/functions/db_funtions.dart';
import 'package:music_wave/Model/model/data_model.dart';
import 'package:music_wave/View/Library%20Screen/Favorite/favorate_screen.dart';
import 'package:music_wave/View/Library%20Screen/Playlist/playlist_screen.dart';
import 'package:music_wave/View/widgets/card.dart';
import 'package:music_wave/View/widgets/remove_alert.dart';
import 'package:music_wave/View/Library%20Screen/Playlist/Widgets/show_bottom_sheet.dart';
import 'package:music_wave/View/widgets/white_space.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({
    Key? key,
  }) : super(key: key);

  final playlistNameController = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FavDb>(context,listen: false).getAllPlaylist();
    });
    log("libr");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Playlists',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(
            10,
          ),
          child: Column(
            children: [
              CardTile(
                //favorate
                subText: 'counter Songs'.toString(),
                tittleText: 'Favorite Songs',
                icon: Icons.favorite,

                iconColor: Colors.red,
                tapAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const FavorateScreen()),
                    ),
                  );
                },
              ),
              const WhiteSpace10(),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: ((context) {
                            return const ShowBottomSheet();
                          }),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                      label: const Text(
                        "Add Playlist",
                      ),
                    )
                  ],
                ),
              ),
              Consumer<FavDb>(
                builder: (context, value, child) {
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        height: 70,
                        child: Card(
                          elevation: 5,
                          child: Center(
                            child: ListTile(
                              leading: const Icon(
                                Icons.playlist_play_rounded,
                                size: 40,
                              ),
                              title: Text(
                                value.playlistModel[index].playlistName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return RemoveAlert(
                                        title: 'Playlist',
                                        contant:
                                            'Do you want to remove this playlist?',
                                        yesPress: () {
                                          // FavDb.removePlaylist(
                                          //   playlist[index].playlistName,
                                          // );
                                          value.removePlaylist(value
                                              .playlistModel[index]
                                              .playlistName);
                                          Navigator.pop(context);
                                        },
                                      );
                                    }),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_sweep_outlined,
                                  color: Colors.red,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return PlaylistScreen(
                                        folderName: value
                                            .playlistModel[index].playlistName,
                                      );
                                    }),
                                  ),
                                ).then((value) {
                                  // setState(() {
                                  print("helo");
                                  //    });
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: value.playlistModel.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addplaylistCliked(context) async {
    final add = playlistNameController.text.trim();

    if (add.isEmpty) {
      return;
    } else {
      //setState(() {
      final playAdd = ListModel(
        playlistName: add,
      );
      // FavDb.addPlaylist(
      //   playAdd,
      // );
      Provider.of<FavDb>(context, listen: false).addPlaylist(playAdd);
      //  });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(
          seconds: 1,
        ),
        backgroundColor: Color.fromARGB(
          255,
          34,
          104,
          12,
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: 80,
          left: 10,
          right: 10,
        ),
        content: Text(
          'Playlist Added',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
