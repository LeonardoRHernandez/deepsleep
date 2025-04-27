import 'package:flutter/material.dart';
class BuildRecommendation extends StatelessWidget {
  const BuildRecommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.yellow[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: const [
          Icon(Icons.lightbulb_outline, color: Colors.orange),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Recomendación: Intenta acostarte 30 minutos antes para alcanzar tu meta de 8 horas',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}