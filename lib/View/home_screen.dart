import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_wave/Controller/provider/home_provider.dart';
import 'package:music_wave/View/Music%20Screen/all_song_screen.dart';
import 'package:music_wave/View/Library%20Screen/library_screen.dart';
import 'package:music_wave/View/Search%20Screen/search_screen.dart';
import 'package:music_wave/View/Settings%20Screen/settings_screen.dart';
import 'package:music_wave/View/Mini%20Player/mini_player.dart';
import 'package:music_wave/View/widgets/music_file.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Widget screen = pages[0];

  static List<Widget> pages = [
     AllSong(),
     LibraryScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 5,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              if (MusicFile.audioPlayer.currentIndex != null)
                Column(
                  children: [
                    MiniPlayer(
                      // index: MusicFile.audioPlayer.currentIndex!,
                    )
                  ],
                ),
              Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return GNav(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    tabActiveBorder: Border.all(
                      width: 1.5,
                      color: Colors.black,
                    ),
                    tabBorderRadius: 10,
                    gap: 10,
                    haptic: true,
                    activeColor: const Color.fromARGB(
                      255,
                      174,
                      48,
                      39,
                    ),
                    selectedIndex: value.selectedIndex,
                    onTabChange: (index) {
                      value.navBottonBar(index);
                    },
                    tabs: const [
                      GButton(
                        icon: Icons.music_note,
                        text: 'Music',
                      ),
                      GButton(
                        icon: Icons.library_music_rounded,
                        text: 'Library',
                      ),
                      GButton(
                        icon: Icons.search_rounded,
                        text: 'Search',
                      ),
                      GButton(
                        icon: Icons.settings,
                        text: 'Settings',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: pages[Provider.of<HomeProvider>(context).selectedIndex],
    );
  }
}
