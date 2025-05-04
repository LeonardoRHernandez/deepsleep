import 'package:flutter/material.dart';

class TarjetaDato extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;

  const TarjetaDato({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icono, color: color),
        ),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(valor, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}