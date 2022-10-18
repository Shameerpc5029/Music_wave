import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_wave/screens/all_song_screen.dart';
import 'package:music_wave/screens/library_screen.dart';
import 'package:music_wave/screens/search_screen.dart';
import 'package:music_wave/screens/settings_screen.dart';
import 'package:music_wave/widgets/mini_player.dart';
import 'package:music_wave/widgets/music_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  void navBottonBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = [
    
    const AllSong(),
    const LibraryScreen(),
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
                      index: MusicFile.audioPlayer.currentIndex!,
                    )
                  ],
                ),
              GNav(
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
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    navBottonBar(
                      index,
                    );
                  });
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
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
