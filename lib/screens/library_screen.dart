import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/db/model/data_model.dart';
import 'package:music_wave/screens/favorate_screen.dart';
import 'package:music_wave/screens/playlist_screen.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/remove_alert.dart';
import 'package:music_wave/widgets/show_bottom_sheet.dart';
import 'package:music_wave/widgets/white_space.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final playlistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FavDb.getAllPlaylist();
    totalcount();
  }

  int counter = 0;

  void totalcount() async {
    int? count = await FavDb.countFav();
    setState(() {
      counter = count!;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                subText: '$counter Songs'.toString(),
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
              ValueListenableBuilder(
                valueListenable: FavDb.playListNotifier,
                builder: (BuildContext context, List<ListModel> playlist,
                    Widget? child) {
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
                                playlist[index].playlistName,
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
                                          FavDb.removePlaylist(
                                            playlist[index].playlistName,
                                          );
                                          Navigator.pop(
                                            context,
                                          );
                                          setState(() {});
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
                                        folderName:
                                            playlist[index].playlistName,
                                      );
                                    }),
                                  ),
                                ).then((value) {
                                  setState(() {
                                    print("helo");
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: playlist.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addplaylistCliked() async {
    final add = playlistNameController.text.trim();

    if (add.isEmpty) {
      return;
    } else {
      setState(() {
        final playAdd = ListModel(
          playlistName: add,
        );
        FavDb.addPlaylist(
          playAdd,
        );
      });
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
