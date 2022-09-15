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
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Color.fromARGB(255, 33, 194, 117),
                  //     offset: const Offset(
                  //       15.0,
                  //       50.0,
                  //     ),
                  //     blurRadius: 30.0,
                  //     spreadRadius: .100,
                  //   ),
                  // ],
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(20),
                  //     bottomRight: Radius.circular(20)),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.topLeft,
                  //   stops: [
                  //     0.1,
                  //     0.5,
                  //     0.5,
                  //     0.9,
                  //   ],
                  //   colors: [
                  //     Color.fromARGB(255, 174, 48, 39),
                  //     Color.fromARGB(255, 232, 172, 172),
                  //     Color.fromARGB(255, 232, 172, 172),
                  //     Color.fromARGB(255, 174, 48, 39),
                  //   ],
                  // ),
                  // color: Color.fromARGB(255, 144, 131, 131),
                  image: DecorationImage(
                    scale: 1.4,
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ),
              title: const Text(
                'Music Wave',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 180, 30, 30),
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
