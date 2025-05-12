import 'package:flutter/material.dart';
import 'package:deepsleep/data/models/suenoModel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BuildSleepDetails extends StatelessWidget {
  const BuildSleepDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Sueno>('suenoBox').listenable(),
      builder: (context, Box<Sueno> box, _) {
        final suenos = box.values.toList();
        final sleepDatalast = suenos.isNotEmpty ? suenos.last : null;

        if (sleepDatalast == null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BuildDetailCard(icon: '🕒', label: 'Inicio', value: 'Sin datos'),
              BuildDetailCard(icon: '⏰', label: 'Fin', value: 'Sin datos'),
              BuildDetailCard(icon: '💤', label: 'Eficiencia', value: 'Sin datos'),
            ],
          );
        }

        var eficiencia = sleepDatalast.eficiencia;
        if (eficiencia == "0") {
          eficiencia = "XXX";
        } else {
          eficiencia = "$eficiencia%";
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildDetailCard(
              icon: '🕒',
              label: 'Inicio',
              value: sleepDatalast.horaInicio,
            ),
            BuildDetailCard(
              icon: '⏰',
              label: 'Fin',
              value: sleepDatalast.horaFinal,
            ),
            BuildDetailCard(
              icon: '💤',
              label: 'Eficiencia',
              value: eficiencia,
            ),
          ],
        );
      },
    );
  }
}

class BuildDetailCard extends StatelessWidget {
  const BuildDetailCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
