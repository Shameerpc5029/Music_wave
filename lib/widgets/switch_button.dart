import 'package:flutter/material.dart';



class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        value: status,
        onChanged: (value) {
          setState(() {
            
            status = value;
          });
        });
  }

  modeChange() {
    if (status = false) {
      ThemeData.light();
    } else {
      ThemeData.dark();
    }
  }
}
