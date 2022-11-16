

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_wave/Controller/provider/splash_provider.dart';

import 'package:music_wave/View/widgets/white_space.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context).gotMainScreen(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ),
              const WhiteSpace(),
              const Text(
                "Music Wave",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

}
