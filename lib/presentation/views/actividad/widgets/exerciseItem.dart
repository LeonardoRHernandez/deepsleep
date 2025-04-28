

import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/historialExercice.dart';
class BuildExerciseItem extends StatelessWidget {
  const BuildExerciseItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.kcal,
  });

  final String title;
  final String subtitle;
  final int kcal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.fitness_center, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange),
              SizedBox(width: 4),
            ],
          ),
          Text(
            "$kcal kcal",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BuildListaEjercicios extends StatelessWidget {
  BuildListaEjercicios({super.key});
  //var exerciseList= ListaEjercicios().exerciseList;
  @override
  Widget build(BuildContext context) {
    // Lista de ejercicios
    final List<Map<String, dynamic>> ejercicios = ListaEjercicios().exerciseList;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ejercicios.length,
      itemBuilder: (context, index) {
        final ejercicio = ejercicios[index];
        return Column(
          children: [
            BuildExerciseItem(
              title: ejercicio["title"],
              subtitle: ejercicio["subtitle"],
              kcal: ejercicio["kcal"],
            ),
            const SizedBox(height: 6),
          ],
        );
      },
    );
  }
}
