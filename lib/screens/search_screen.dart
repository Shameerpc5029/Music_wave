import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_wave/widgets/search_bar.dart';
import 'package:music_wave/widgets/text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SearchBar(),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Row(
            children: [
              HeadingText(text: 'History'),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text('One day'),
            ),
            IconButton(
              splashRadius: 5,
              onPressed: () {
                print("object");
              },
              icon: Icon(
                Icons.close,
                size: 10,
              ),
            ),
            Text('Ole melody'),
            IconButton(
              splashRadius: 5,
              onPressed: () {
                print("object");
              },
              icon: Icon(
                Icons.close,
                size: 10,
              ),
            ),
          ],
        )
      ],
    ));
  }
}
