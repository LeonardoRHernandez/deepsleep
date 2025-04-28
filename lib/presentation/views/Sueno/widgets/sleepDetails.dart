import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/procesarDatos.dart';

class BuildSleepDetails extends StatelessWidget {
  const BuildSleepDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RitmoCardiacoProvider>(context);
    var sleepDatalast =
        provider
            .listsueno
            .historialSueno[provider.listsueno.historialSueno.length - 1];
    var eficiencia = sleepDatalast["eficiencia"];
    if (eficiencia == "0"){
      eficiencia = "XXX";
    } else {
      eficiencia = "${eficiencia}%";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildDetailCard(
          icon: '🕒',
          label: 'Inicio',
          value: '${sleepDatalast["horaInicio"]}',
        ),
        BuildDetailCard(
          icon: '⏰',
          label: 'Fin',
          value: '${sleepDatalast["horaFinal"]}',
        ),
        BuildDetailCard(
          icon: '💤',
          label: 'Eficiencia',
          value:'$eficiencia',
        ),
      ],
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
