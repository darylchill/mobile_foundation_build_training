import 'package:flutter/material.dart';

class HeroLogo extends StatelessWidget {
  const HeroLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: 'hero',
      child: FlutterLogo(
        size: 100.0,
      ),
    );
  }
}
