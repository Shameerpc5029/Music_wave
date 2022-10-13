// import 'package:flutter/material.dart';
// import 'package:music_wave/db/functions/db_funtions.dart';
// import 'package:music_wave/screens/all_song_screen.dart';
// import 'package:music_wave/screens/search_screen.dart';
// import 'package:music_wave/widgets/fav_button.dart';
// import 'package:music_wave/widgets/music_file.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class BoxFavButton extends StatefulWidget {
//   final List< SongModel> song;
//   final IconData icon;
//   final int index;
//   const BoxFavButton({
//     super.key,
//     required this.song,
//     required this.icon, required this.index,
//   });

//   @override
//   State<BoxFavButton> createState() => _BoxFavButtonState();
// }

// class _BoxFavButtonState extends State<BoxFavButton> {
//   @override
//   void initState() {
//     super.initState();
//     // buttonPressed();
//   }

//   // IconData icon = Icons.favorite_border_outlined;
//   Color iconColor = Colors.blue;
//   bool buttonClick = false;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 200,
//       // child: ElevatedButton.icon(
//       //   style: ButtonStyle(
//       //     foregroundColor: MaterialStateProperty.all(iconColor),
//       //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//       //       const RoundedRectangleBorder(
//       //         borderRadius: BorderRadius.only(
//       //             bottomLeft: Radius.circular(10),
//       //             bottomRight: Radius.circular(10)),
//       //         side: BorderSide(
//       //           color: Color.fromARGB(255, 109, 182, 207),
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       //   onPressed: () {
//       //     setState(
//       //       () {
//       //         if (!buttonClick) {
//       //           FavDb.addFav(widget.song);
//       //           buttonClick = true;
//       //         } else {
//       //           FavDb.removeFav(widget.song.id);
//       //           buttonClick = false;
//       //         }
//       //         buttonPressed();
//       //       },
//       //     );
//       //   },
//       //   icon: Icon(
//       //     widget.icon,
//       //     color: iconColor,
//       //   ),
//       //   label: const Text(
//       //     'Favorite',
//       //     style: TextStyle(
//       //       fontWeight: FontWeight.bold,
//       //     ),
//       //   ),
//       // ),
//       child:
//           FavButton(songModel: widget.song[widget.index], icon: Icons.favorite),
//     );
//   }

//   // void buttonPressed() async {
//   //   bool isFav = await FavDb.isFav(widget.song.id);
//   //   print(isFav);
//   //   // icon = isFav ? Icons.favorite : Icons.favorite_border_outlined;
//   //   iconColor = isFav ? Colors.red : Colors.black;
//   // }

//   // void buttonPressed() {
//   //   if (!buttonClick) {
//   //     setState(
//   //       () {
//   //         iconColor = Colors.red;
//   //         buttonClick = true;
//   //         FavDb.addFav(widget.song);
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             margin: const EdgeInsets.all(10),
//   //             behavior: SnackBarBehavior.floating,
//   //             duration: const Duration(seconds: 1),
//   //             shape:
//   //                 OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//   //             content: const Text('Favorite Added!'),
//   //           ),
//   //         );
//   //       },
//   //     );
//   //   } else {
//   //     setState(
//   //       () {
//   //         iconColor = Colors.blue;
//   //         buttonClick = false;
//   //         FavDb.removeFav(widget.song.id);
//   //       },
//   //     );
//   //   }
//   // }
// }
