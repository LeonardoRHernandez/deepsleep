import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:deepsleep/presentation/controllers/ExerciseController/ControlerActividad.dart';
import 'package:deepsleep/data/models/suenoModel.dart';
import 'package:hive/hive.dart';

import 'package:deepsleep/presentation/controllers/ExerciseController/graficoController.dart';

class Controllers with ChangeNotifier {
  Controllers() {
    _actividad.addListener(notifyListeners);
    cargarSuenoDesdeHive();
  }

  final _sueno = Sueno.empty();
  Sueno get sueno => _sueno;
  final _actividad = Actividad();
  Actividad get actividad => _actividad;
  final List<Sueno> _listsueno = []; //ListSueno();
  Timer? _timer;
  final DateTime _horaInicio = DateTime.now();
  DateTime get horaInicio => _horaInicio;
  List<Sueno> get listsueno => _listsueno;
  final Graficar _graficar = Graficar();
  List<FlSpot> get list20Graf => _graficar.list20Graf(_actividad.datos);
  List<FlSpot> get listGraf => _graficar.listGraf(_actividad.datos);
  // Inicia la generación automática de datos

  void agregarSueno(Sueno nuevoSueno) {
    _listsueno.add(nuevoSueno);
    notifyListeners();
  }

  Future<void> cargarSuenoDesdeHive() async {
    // Cargar datos desde Hive
    final box = Hive.box<Sueno>('suenoBox');
    _listsueno.clear();
    _listsueno.addAll(box.values.toList());
    notifyListeners();
  }

  void detenerMonitoreo() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _actividad.removeListener(notifyListeners);
    _timer?.cancel();
    super.dispose();
  }
}

// Extensiones para cálculos
extension ListIntX on List<int> {
  double get average => isEmpty ? 0 : reduce((a, b) => a + b) / length;
  int get min => reduce((a, b) => a < b ? a : b);
  int get max => reduce((a, b) => a > b ? a : b);
}
