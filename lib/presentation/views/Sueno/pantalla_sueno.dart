// Pantallas/pantalla_sueno.dart
import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/recommendation.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/recordAndAverage.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepTime.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepHistory.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepDetails.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/encabezado.dart';

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
