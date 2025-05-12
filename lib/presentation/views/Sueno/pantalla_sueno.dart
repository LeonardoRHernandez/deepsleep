// Pantallas/pantalla_sueno.dart
import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/recommendation.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/recordAndAverage.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepTime.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepHistory.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepDetails.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/encabezado.dart';
import 'package:provider/provider.dart' show Consumer;

class PantallaSueno extends StatefulWidget {
  const PantallaSueno({super.key});

  @override
  State<PantallaSueno> createState() => _PantallaSuenoState();
}

class _PantallaSuenoState extends State<PantallaSueno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado fijo arriba
            BuildEncabezadoFijo(context: context, titulo: "Mi sueño"),
            // Contenido scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    BuildSleepTime(),
                    const SizedBox(height: 20),
                    BuildRecordAndAverage(),
                    const SizedBox(height: 16),
                    BuildRecommendation(),
                    const SizedBox(height: 16),
                    BuildSleepDetails(),
                    const SizedBox(height: 20),

                    // 👇 Aquí se muestra si el usuario está dormido o no
                    Consumer<Controllers>(
                      builder: (context, controllers, _) {
                        final estaDormido = controllers.actividad.estaDormido;
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                estaDormido
                                    ? Colors.blue[50]
                                    : Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: estaDormido ? Colors.blue : Colors.green,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                estaDormido
                                    ? Icons.nightlight_round
                                    : Icons.wb_sunny,
                                color: estaDormido ? Colors.blue : Colors.green,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                estaDormido
                                    ? "Usuario dormido 😴"
                                    : "Usuario despierto 🙂",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      estaDormido
                                          ? Colors.blue[800]
                                          : Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),
                    BuildSleepHistory(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
