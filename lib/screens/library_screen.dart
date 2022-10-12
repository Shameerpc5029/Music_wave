import 'package:flutter/material.dart';
import 'package:music_wave/db/functions/db_funtions.dart';
import 'package:music_wave/db/model/data_model.dart';
import 'package:music_wave/screens/favorate_screen.dart';
import 'package:music_wave/screens/playlist_screen.dart';
import 'package:music_wave/screens/search_screen.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/remove_alert.dart';
import 'package:music_wave/widgets/show_bottom_sheet.dart';
import 'package:music_wave/widgets/text.dart';
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
    // playlistCount();
    setState(() {
      totalcount();
    });
  }

  int counter = 0;

  void totalcount() async {
    int? count = await FavDb.countFav();
    setState(() {
      counter = count!;
    });
  }

  // int playlistCounter = 0;
  // void playlistCount() async {
  //   int? countplay = await FavDb.countplay();
  //   setState(() {
  //     playlistCounter = countplay!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: ((context) {
              return ShowBottomSheet(
                closePress: () {
                  playlistNameController.clear();
                  Navigator.pop(context);
                },
                savePress: () {
                  addplaylistCliked();

                  Navigator.pop(context);
                  playlistNameController.clear();
                },
                controller: playlistNameController,
              );
            }),
          );
        },
        label: const Text(
          "Add Playlist",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(
          Icons.playlist_add,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(
            10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  5,
                ),
                child: Row(
                  children: const [
                    HeadingText(
                      //playlist heading
                      text: 'Playlists',
                    ),
                  ],
                ),
              ),
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
                          color: const Color.fromARGB(255, 225, 236, 246),
                          child: InkWell(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return RemoveAlert(
                                    title: 'Playlist',
                                    contant:
                                        'Do you want to remove this playlist?',
                                    yesPress: () {
                                      FavDb.removePlaylist(
                                          playlist[currentIndex].playlistName);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  );
                                }),
                              );
                            },
                            child: Center(
                              child: CardTile2(
                                  icon: Icons.playlist_play_rounded,
                                  titleText: playlist[index].playlistName,
                                  tapAction: (() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: ((context) {
                                      return PlaylistScreen(
                                        folderName:
                                            playlist[index].playlistName,
                                      );
                                    })));
                                  })),
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: playlist.length,
                  );
                },
              )
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
        final playAdd = ListModel(playlistName: add);
        FavDb.addPlaylist(playAdd);
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
        margin: EdgeInsets.only(bottom: 80, left: 10, right: 10),
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
