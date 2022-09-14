import 'package:flutter/material.dart';
import 'package:music_wave/screens/player_screen.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          physics:
          ScrollPhysics();

          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return PlayerScreen();
                  })));
                },
                child: Image(
                  width: 150,
                  height: 99,
                  fit: BoxFit.fill,
                  image: AssetImage(
                      'assets/images/Thallumaala-Malayalam-2022-20220816184649-500x500.jpeg'),
                ),
              ),
              ListTile(
                title: Text(
                  'Manavalan Thag',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  'Hello',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        });
  }
}
