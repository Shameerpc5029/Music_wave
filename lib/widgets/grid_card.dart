import 'package:flutter/material.dart';
import 'package:music_wave/screens/player_screen.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          const ScrollPhysics();

          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return const PlayerScreen();
                  })));
                },
                child: SizedBox(
                  width: 150,
                  height: 89,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                          width: 150,
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/[CITYPNG.COM]HD Music Graffiti Background Illustration Art PNG - 1255x1255.png',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {},
                            child: const Icon(
                              Icons.play_arrow_rounded,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  'Manavalan Thag',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  'Artist Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
