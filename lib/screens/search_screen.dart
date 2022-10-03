import 'package:flutter/material.dart';

import 'package:music_wave/widgets/search_bar.dart';
import 'package:music_wave/widgets/text.dart';
import 'package:music_wave/widgets/white_space.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SearchBar(),
            const WhiteSpace10(),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
              ),
              child: Row(
                children: const [
                  HeadingText(
                    text: 'History',
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                  ),
                  child: Text(
                    'One day',
                  ),
                ),
                IconButton(
                  splashRadius: 5,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 10,
                  ),
                ),
                const Text(
                  'Ole melody',
                ),
                IconButton(
                  splashRadius: 5,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
