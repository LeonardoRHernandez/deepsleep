import 'package:flutter/material.dart';
class BuildEncabezadoFijo extends StatelessWidget {
  const BuildEncabezadoFijo({
    super.key,
    required this.context,
    required this.titulo,
  });

  final BuildContext context;
  final String titulo;

  @override
  Widget build(BuildContext context) {

    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mi sueño',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bed, color: Colors.black, size: 28),
                        onPressed: () {
                          mostrarFormularioDormir(context);
                        },
                        tooltip: 'Agregar sueño',
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.black, size: 28),
                        onPressed: () {
                          // Acción de notificaciones si quieres
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
  }
}
void mostrarFormularioDormir(BuildContext context) {
    final dormirController = TextEditingController();
    final despertarController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String labelText = "Hora que te fuiste a dormir";
        var hintText = "Ej. 22:30";
        var labelText2 = "Hora que te despertaste";
        var hintText2 = "Ej. 07:00";
        return AlertDialog(
          title: const Text("Agregar horas de sueño"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LabelSueno(controller: dormirController, labelText: labelText, hintText: hintText),
              const SizedBox(height: 12),
              LabelSueno(controller: despertarController,labelText: labelText2,hintText: hintText2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }
class LabelSueno extends StatelessWidget {
  const LabelSueno({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      keyboardType: TextInputType.datetime,
    );
  }
}
