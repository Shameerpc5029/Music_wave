import 'package:flutter/material.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/song_card.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorate Songs'),
        centerTitle: true,
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: ((context, index) {
              return SongCard(
                titleText: 'Pala Palli',
                subText: 'Athul Narukara and Jakes Bejoy',
                fontWeight: FontWeight.bold,
                leadingUrl: 'assets/images/image.jpeg',
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                tapAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return const PlayerScreen();
                      }),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
