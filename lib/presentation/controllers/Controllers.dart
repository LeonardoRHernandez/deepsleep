
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:deepsleep/presentation/controllers/Sleepcontroller/historialSueno.dart'; // Para hacer la petición HTTP
import 'package:deepsleep/presentation/controllers/ExerciseController/ControlerActividad.dart';
import 'package:deepsleep/presentation/controllers/Sleepcontroller/ControlerSueno.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/graficoController.dart';
class Controllers with ChangeNotifier {
  Controllers() {
    _actividad.addListener(notifyListeners);
  }


  final _sueno = Sueno();
  Sueno get sueno => _sueno;
  final _actividad = Actividad();
  Actividad get actividad => _actividad;
  final _listsueno = Listsueno();
  Timer? _timer;
  final DateTime _horaInicio = DateTime.now();
  DateTime get horaInicio => _horaInicio;
  Listsueno get listsueno => _listsueno;
  final Graficar _graficar = Graficar();
  List<FlSpot> get list20Graf => _graficar.list20Graf(_actividad.datos);
  List<FlSpot> get listGraf => _graficar.listGraf(_actividad.datos);
  // Inicia la generación automática de datos

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
