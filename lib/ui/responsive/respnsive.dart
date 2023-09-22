import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  const Responsive({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //if our width is less then 600 pixels then consider it is a a mobile
    if (size.width < 600) {
      return mobile;
    }

    //otherwise desktop
    else{
      return desktop;
    }
 
  }
}
