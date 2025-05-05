import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildSleepTime extends StatelessWidget {
  const BuildSleepTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF05576A), Color(0xFF0AACD0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.31, 1.0],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Consumer<Controllers>(
              builder: (context, provider, child) {
                var ultimoSueno =
                    provider.listsueno.isNotEmpty
                        ? provider.listsueno.last
                        : null;
                var tiempo = ultimoSueno?.duracion ?? "Sin datos";
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$tiempo",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tiempo total',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: const LinearProgressIndicator(
              value: 7 / 8,
              minHeight: 20,
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
