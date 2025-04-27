import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
//import 'dart:async';
import 'package:deepsleep/data/services/procesarDatos.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/graficoController.dart';
class BuildGraficoCardiaco extends StatefulWidget {
  const BuildGraficoCardiaco({
    super.key,
  });

  @override
  State<BuildGraficoCardiaco> createState() => _BuildGraficoCardiacoState();
}

class _BuildGraficoCardiacoState extends State<BuildGraficoCardiaco> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ritmo Cardíaco",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Consumer<RitmoCardiacoProvider>(
                builder: (context, provider, child) {

                  return LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(show: false),
                      //gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots:list20Graf(provider),
                          isCurved: true,
                          color: Colors.redAccent,
                          barWidth: 3,
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
          const SizedBox(height: 16),
          Consumer<RitmoCardiacoProvider>(
            builder: (context, provider, child) {
              return Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _CardiacoDato(label: "Promedio", value: "${provider.promedio.toInt()} PPM"),
                  _CardiacoDato(label: "Mínimo", value: "${provider.min.toInt()} PPM"),
                  _CardiacoDato(label: "Máximo", value: "${provider.max.toInt()} PPM"),
                ],
              );
            }
          ),
        ],
      ),
    );
  }


}

class _CardiacoDato extends StatelessWidget {
  final String label;
  final String value;

  const _CardiacoDato({required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
