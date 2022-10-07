import 'package:flutter/material.dart';

import 'package:music_wave/widgets/switch_button.dart';

class CardTile extends StatelessWidget {
  final String tittleText;
  final dynamic icon;
  final Color iconColor;
  final void Function() tapAction;
  final String subText;
  final dynamic trailingIcon;

  const CardTile({
    super.key,
    required this.tittleText,
    required this.icon,
    required this.iconColor,
    required this.tapAction,
    required this.subText,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        // height: 100,
        child: Card(
          // color: Colors.white,
          elevation: 1,
          child: ListTile(
            onTap: () {
              tapAction();
            },
            leading: CircleAvatar(
              backgroundColor: Colors.white10,
              // child: LottieBuilder.asset('assets/lottie/99403-love.json'
              //     // height: 200,
              //     ),
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
            title: Text(
              tittleText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              subText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: trailingIcon,
          ),
        ),
      );
}

class CardTile2 extends StatelessWidget {
  final dynamic icon;
  final String titleText;
  final Function() tapAction;

  const CardTile2({
    super.key,
    required this.icon,
    required this.titleText,
    required this.tapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        0,
      ),
      child: ListTile(
        onTap: () {
          tapAction();
        },
        leading: Icon(
          icon,
          size: 28,
        ),
        title: Text(
          titleText,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class CardTile3 extends StatelessWidget {
  final dynamic icon;
  final String titleText;
  final Function() tapAction;

  const CardTile3({
    super.key,
    required this.icon,
    required this.titleText,
    required this.tapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              leading: Icon(
                icon,
                size: 28,
              ),
              title: Text(
                titleText,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SwitchButton(),
        ],
      ),
    );
  }
}
