// Pantallas/pantalla_ejercicio.dart
import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/Grafico.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/MetricCard.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/exerciseItem.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/encabezado.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/progreso.dart';

class PantallaEjercicio extends StatefulWidget {
  const PantallaEjercicio({super.key});

  @override
  State<PantallaEjercicio> createState() => _PantallaEjercicioState();
}

class _PantallaEjercicioState extends State<PantallaEjercicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BuildEncabezadoFijo(titulo: "Mi ejercicio"),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgresoWidget(),
                    const SizedBox(height: 16),
                    BuildMetricos(),
                    const SizedBox(height: 16),
                    BuildListaEjercicios(),
                    const SizedBox(height: 16),
                    BuildGraficoCardiaco(),
                    const SizedBox(height: 16),
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