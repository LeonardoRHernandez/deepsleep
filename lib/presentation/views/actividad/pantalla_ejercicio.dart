// Pantallas/pantalla_ejercicio.dart
import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/Grafico.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/MetricCard.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/exerciseItem.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/encabezado.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/progreso.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/procesarDatos.dart';
import 'dart:async';

class PantallaEjercicio extends StatefulWidget {
  const PantallaEjercicio({super.key});

  @override
  State<PantallaEjercicio> createState() => _PantallaEjercicioState();
}

class _PantallaEjercicioState extends State<PantallaEjercicio> {
  @override
  void initState() {
    super.initState();
    _iniciarAutoActualizacion();
  }

  void _iniciarAutoActualizacion() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false; // Verifica si el widget está montado
      Provider.of<RitmoCardiacoProvider>(
        context,
        listen: false,
      ).agregarNuevoDato();
      return true; // Retorna true para continuar el ciclo
    });
  }
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