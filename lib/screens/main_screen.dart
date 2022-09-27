import 'package:flutter/material.dart';
import 'package:music_wave/screens/all_song_screen.dart';
import 'package:music_wave/screens/library_screen.dart';
import 'package:music_wave/screens/search_screen.dart';
import 'package:music_wave/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({Key? key,}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}
 
class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  void navBottonBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = [
    const AllSong(),
   const  LibraryScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromARGB(255, 174, 48, 39),
      //   onPressed: () {
      //     print("object");
      //   },
      //   child: Icon(
      //     Icons.play_arrow,
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => navBottonBar(index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.music_note,
            ),
            label: "play",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
            ),
            label: "play",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "play",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: "play",
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
