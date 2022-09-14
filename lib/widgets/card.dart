import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: ListTile(
        onTap: () {
          tapAction();
        },
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),
        title: Text(
          tittleText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(subText),
        ),
        trailing: trailingIcon,
      ),
    );
  }
}

class CardTile2 extends StatelessWidget {
  final dynamic icon;
  final String titleText;
  final Function() tapAction;
  final FontWeight fontWeight;
  const CardTile2({
    super.key,
    required this.icon,
    required this.titleText,
    required this.tapAction,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: ListTile(
        onTap: () {
          tapAction();
        },
        leading: Icon(
          icon,
          size: 30,
        ),
        title: Text(
          titleText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SongCard extends StatelessWidget {
  final String titleText;
  final String subText;
  final String leadingUrl;
  final dynamic icon;
  final Function() tapAction;
  FontWeight fontWeight;
  SongCard(
      {super.key,
      required this.titleText,
      required this.subText,
      required this.leadingUrl,
      required this.icon,
      required this.tapAction,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 1,
        child: ListTile(
          onTap: tapAction,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(
              10,
            ),
            child: Image(
              fit: BoxFit.fill,
              width: 50,
              height: 50,
              image: NetworkImage(
                leadingUrl,
              ),
            ),
          ),
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: fontWeight,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: icon,
          ),
          subtitle: Text(
            subText,
          ),
        ),
      ),
    );
  }
}
