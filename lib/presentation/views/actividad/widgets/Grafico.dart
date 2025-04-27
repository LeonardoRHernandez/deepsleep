import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class BuildGraficoCardiaco extends StatelessWidget {
  const BuildGraficoCardiaco({
    super.key,
  });

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
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 72),
                        FlSpot(1, 75),
                        FlSpot(2, 78),
                        FlSpot(3, 76),
                        FlSpot(4, 80),
                        FlSpot(5, 85),
                        FlSpot(6, 78),
                        FlSpot(7, 90),
                        FlSpot(8, 87),
                        FlSpot(9, 100),
                      ],
                      isCurved: true,
                      color: Colors.redAccent,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _CardiacoDato(label: "Promedio", value: "75 PPM"),
              _CardiacoDato(label: "Mínimo", value: "60 PPM"),
              _CardiacoDato(label: "Máximo", value: "100 PPM"),
            ],
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
