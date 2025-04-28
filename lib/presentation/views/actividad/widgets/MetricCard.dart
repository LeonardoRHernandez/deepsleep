import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/GastoCalorico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildMetricCard extends StatelessWidget {
  const BuildMetricCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}


class BuildMetricos extends StatelessWidget {
  const BuildMetricos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Consumer<Controllers>(
          builder: (context,provider, child) {
            double calorias=0;
            
            calorias=calcularCaloriaTotal(provider.horaInicio, DateTime.now(), provider);
            return BuildMetricCard(icon: Icons.local_fire_department, value: "${calorias.toInt()} kcal", label: "Quemadas", color: Colors.blue);
          }
        )),
        const SizedBox(width: 12),
        Expanded(child: Consumer<Controllers>(
          builder: (context,provider, child) {
            return BuildMetricCard(icon: Icons.favorite, value: "${provider.actividad.ritmoCardiaco.toInt()} PPM", label: "Ritmo cardíaco", color: Colors.purple);
          }
        )),
      ],
    );
  }
}