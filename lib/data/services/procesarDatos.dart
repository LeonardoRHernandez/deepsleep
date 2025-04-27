import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

class RitmoCardiacoProvider with ChangeNotifier {
  List<int> _datos = [];
  Timer? _timer;
  Random random = Random();
  DateTime _horaInicio = DateTime.now();
  double _promedio = 0;
  double _min = 0;
  double _max = 0;
  double _ritmoCardiaco = 0;

  List<int> get datos => List.unmodifiable(_datos);
  double get promedio => _promedio;
  double get min => _min;
  double get max => _max;
  double get ritmoCardiaco => _ritmoCardiaco;
  DateTime get horaInicio => _horaInicio;

  // Inicia la generación automática de datos
  void iniciarMonitoreo() {
    _timer?.cancel(); // Cancela cualquier timer existente
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      agregarNuevoDato();
    });
  }

  void detenerMonitoreo() {
    _timer?.cancel();
  }

  void agregarNuevoDato() {
    

    //aqui llamar a la api
    // Simulación de llamada a la API
    int nuevoDato = random.nextInt(41) + 60; // 60-100
    // Simula un nuevo dato entre 60 y 100
    // Si el nuevo dato es diferente de 0, lo agrega a la lista


    if (nuevoDato != 0) {
      _datos.add(nuevoDato);
      _ritmoCardiaco = nuevoDato.toDouble();
      _calcularEstadisticas();
      notifyListeners();
    } // Actualiza todos los widgets escuchando
  }

  void _calcularEstadisticas() {
    if (_datos.isEmpty) return;

    _promedio = _datos.average;
    _min = _datos.min.toDouble();
    _max = _datos.max.toDouble();
  }

  @override
  void dispose() {
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

