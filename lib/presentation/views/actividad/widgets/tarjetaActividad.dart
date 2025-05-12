import 'package:deepsleep/data/models/sensorModel.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../path_to_your/activity_detector.dart'; // Asegúrate de importar correctamente
import 'package:deepsleep/presentation/controllers/ExerciseController/actividad.dart';

class ActivityStatusCard extends StatefulWidget {
  const ActivityStatusCard({super.key});

  @override
  State<ActivityStatusCard> createState() => _ActivityStatusCardState();
}

class _ActivityStatusCardState extends State<ActivityStatusCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controllers>(
      builder: (context, provider, child) {
        final actividad = provider.actividad.actividad.currentState;
        final duracion = provider.actividad.actividad.duracionActual;

        String label;
        IconData icon;
        Color color;

        switch (actividad) {
          case UserActivity.resting:
            label = "inactividad";
            icon = Icons.bed;
            color = Colors.blueGrey;
            break;
          case UserActivity.walking:
            label = "En marcha";
            icon = Icons.directions_walk;
            color = Colors.orange;
            break;
          case UserActivity.exercising:
            label = "Ejercicio intenso";
            icon = Icons.fitness_center;
            color = Colors.redAccent;
            break;
        }

        final minutos = duracion.inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        final segundos = duracion.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        final tiempo = "$minutos:$segundos";

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(width: 16),

                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text("Duración: $tiempo", style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        );
      },
    );
  }
}
