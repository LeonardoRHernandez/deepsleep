import 'package:flutter/material.dart';

class PantallaAjustes extends StatelessWidget {
  final VoidCallback desbloquearPantallas;

  const PantallaAjustes({super.key, required this.desbloquearPantallas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            desbloquearPantallas();  // Llama a la función que desbloquea los botones
          },
          child: const Text(
            'Desbloquear Sueño y Ejercicio',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
