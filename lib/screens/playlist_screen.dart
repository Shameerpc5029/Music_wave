import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_wave/widgets/card.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 174, 48, 39),
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text('Playlist'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 174, 48, 39),
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return SongCard(
              fontWeight: FontWeight.bold,
                titleText: 'Track $index',
                subText: 'Tittle $index',
                leadingUrl:
                    'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg',
                icon: Icon(Icons.favorite),
                tapAction: (() {}));
          },
        ),
      ),
    );
  }
}
