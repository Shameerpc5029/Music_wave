import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_wave/screens/player_screen.dart';
import 'package:music_wave/widgets/card.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorate Songs'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 174, 48, 39),
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: ((context, index) {
              return SongCard(
                titleText: 'Pala Palli',
                subText: 'Athul Narukara and Jakes Bejoy',
                fontWeight: FontWeight.bold,
                leadingUrl:
                    'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg',
                icon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                tapAction: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return PlayerScreen();
                  })));
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
