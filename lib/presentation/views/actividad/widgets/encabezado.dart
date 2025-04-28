
import 'package:flutter/material.dart';
class BuildEncabezadoFijo extends StatelessWidget {
  const BuildEncabezadoFijo({
    super.key,
    required this.titulo,
  });

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
              icon: const Icon(Icons.accessibility_new_sharp, color: Colors.black, size: 28),
                onPressed: () {
                  // Acción para agregar sueño
                },
                tooltip: 'Agregar Actividad', // Tooltip al dejar presionado
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black, size: 28),
                onPressed: () {
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
