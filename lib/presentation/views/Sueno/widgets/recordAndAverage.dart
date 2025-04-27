import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/statCard.dart';
class BuildRecordAndAverage extends StatelessWidget {
  const BuildRecordAndAverage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildStatCard(icon: '🏆', title: 'Tu récord', value: '8H\n15M', subtitle: '12 de enero'),
        BuildStatCard(icon: '📊', title: 'Promedio', value: '7H\n18M', subtitle: 'Últimos 7 días'),
      ],
    );
  }
}
