import 'package:flutter/material.dart';

class PantallaAjustes extends StatelessWidget {
  const PantallaAjustes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Estás en ajustes',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}