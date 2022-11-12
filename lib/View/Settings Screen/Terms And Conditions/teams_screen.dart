import 'package:flutter/material.dart';
import 'package:music_wave/View/Settings%20Screen/Terms%20And%20Conditions/widgets/teams_text.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              10,
            ),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const TeamsText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
