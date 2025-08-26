import 'package:flutter/material.dart';
import 'package:new_app/widgets/flutter_logo.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Screen'),
      ),
      body: const Center(
        child: Column(
          children: [
            HeroLogo(),
            Text('This is the new screen.')
          ],
        ),
      ),
    );
  }
}
