import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:deepsleep/presentation/controllers/ExerciseController/graficoController.dart';

class Actividad with ChangeNotifier {
  Timer? _timer;
  double _promedio = 0;
  double _min = 0;
  double _max = 0;
  double _ritmoCardiaco = 0;
  final List<int> _datos = [];
  final Random _random = Random();
  Map<String, double> _estadistica = {"P": 0, "Mn": 0, "MX": 0};
  final Graficar _graficar = Graficar();
  List<int> get datos => List.unmodifiable(_datos);
  double get promedio => _promedio;
  double get min => _min;
  double get max => _max;
  double get ritmoCardiaco => _ritmoCardiaco;
  void agregarNuevoDato() async {
    int nuevoDato = _random.nextInt(10) + 60; // 60-100
    if (nuevoDato > 30) {
      _datos.add(nuevoDato);
      notifyListeners();
      _ritmoCardiaco = nuevoDato.toDouble();
      _estadistica = _graficar.calcularEstadisticas(_datos);
      _promedio = _estadistica["P"]!;
      _min = _estadistica["Mn"]!;
      _max = _estadistica["Mx"]!;
      
    }
  }

  void iniciarMonitoreo() {
    _timer?.cancel(); // Cancela cualquier timer existente
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      agregarNuevoDato();
    });
  }
  void detenerMonitoreo() {
  _timer?.cancel();
}
}
