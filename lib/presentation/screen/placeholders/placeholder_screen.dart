import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Night Timer iniciado correctamente',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
