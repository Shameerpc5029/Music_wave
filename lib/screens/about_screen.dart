import 'package:flutter/material.dart';
import 'package:music_wave/widgets/about_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
            ),
            floating: true,
            pinned: true,
            expandedHeight: 230,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    scale: 2,
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ),
              title: const Text(
                'Music Wave',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                    255,
                    180,
                    30,
                    30,
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const AboutText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
