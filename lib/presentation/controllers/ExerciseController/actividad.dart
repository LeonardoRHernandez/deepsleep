import 'dart:math';
import 'package:deepsleep/data/models/ejercicioModel.dart';
import 'package:flutter/foundation.dart';
import 'package:deepsleep/data/models/sensorModel.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/ControlerActividad.dart';

class ActivityDetector extends ChangeNotifier {
  String _nombreMes(int mes) {
  const meses = [
    "ene", "feb", "mar", "abr", "may", "jun",
    "jul", "ago", "sep", "oct", "nov", "dic"
  ];
  return meses[mes - 1];
}

String _nombreActividad(UserActivity tipo) {
  switch (tipo) {
    case UserActivity.walking:
      return "Caminata";
    case UserActivity.exercising:
      return "Ejercicio";
    default:
      return "Desconocido";
  }
}

int _caloriasEstimadas(UserActivity tipo, int minutos, double hr) {
  final met = tipo == UserActivity.exercising ? 7.0 : 3.5;
  final peso = 85.0; // en kg, ajustable si quieres
  return ((met * 3.5 * peso / 200) * minutos).round();
}

  final List<SensorData> _window = [];
  final List<ActivitySession> _history = [];
  List<ActivitySession> get history => List.unmodifiable(_history);

  int _lastStepCount = 0;

  UserActivity _currentState = UserActivity.resting;
  DateTime _currentStateStart = DateTime.now();

  UserActivity? _pendingState;
  DateTime? _pendingSince;

  Duration activityHoldDuration = const Duration(seconds: 5);
  Duration windowSize = const Duration(seconds: 10);

  UserActivity get currentState => _currentState;
  //DateTime _currentStateStart = DateTime.now();

  Duration get duracionActual => DateTime.now().difference(_currentStateStart);

  void update(SensorData data) {
    final now = data.timestamp;

    _window.add(data);
    _window.removeWhere((d) => now.difference(d.timestamp) > windowSize);

    if (_window.length < 3) return;

    final avgHeartRate =
        _window.map((d) => d.heartRate).reduce((a, b) => a + b) /
        _window.length;
    final avgAccel =
        _window
            .map(
              (d) => sqrt(
                d.accelX * d.accelX + d.accelY * d.accelY + d.accelZ * d.accelZ,
              ),
            )
            .reduce((a, b) => a + b) /
        _window.length;

    final stepDelta = data.steps - _lastStepCount;
    _lastStepCount = data.steps;

    final detected = _classify(avgHeartRate, avgAccel, stepDelta);

    if (detected != _currentState) {
      if (_pendingState != detected) {
        _pendingState = detected;
        _pendingSince = now;
      } else {
        final duration = now.difference(_pendingSince!);
        if (duration >= activityHoldDuration) {
          _saveCurrentSession(now);
          _currentState = detected;
          _currentStateStart = now;
          _pendingState = null;
          _pendingSince = null;
          notifyListeners();
        }
      }
    } else {
      _pendingState = null;
      _pendingSince = null;
    }
  }

  void _saveCurrentSession(DateTime now) {
    final heartRates =
        _window
            .where((d) => d.timestamp.isAfter(_currentStateStart))
            .map((d) => d.heartRate)
            .toList();

    if (heartRates.isNotEmpty) {
      final avgHR = heartRates.reduce((a, b) => a + b) / heartRates.length;
      _history.add(
        ActivitySession(
          activity: _currentState,
          startTime: _currentStateStart,
          endTime: now,
          averageHeartRate: avgHR,
        ),
      );
    }
  }

  void extraerSesionesActivas(List<Ejercicio> actividad) {
    // Filtrar sesiones activas
    // final activas = _history.where((s) => s.activity == UserActivity.walking).toList();
    // final activas = _history.where((s) => s.activity == UserActivity.exercising).toList();
    // final activas = _history.where((s) => s.activity == UserActivity.resting).toList();
  final activas = _history.where(
    (s) =>
        s.activity == UserActivity.walking ||
        s.activity == UserActivity.exercising,
  ).toList();

  // Eliminar del historial
  _history.removeWhere((s) => activas.contains(s));

  // Procesar cada sesión a Ejercicio
  for (final s in activas) {
    final duracion = s.endTime.difference(s.startTime);
    final minutos = duracion.inMinutes;
    final duracionStr = "${duracion.inHours}h ${minutos.remainder(60)}min";

    final fecha = "${s.endTime.day} ${_nombreMes(s.endTime.month)} ${s.endTime.year}";

    final kcal = _caloriasEstimadas(s.activity, minutos, s.averageHeartRate);

    final ejercicio = Ejercicio(
      _nombreActividad(s.activity),
      fecha,
      duracionStr,
      kcal,
    );
  
    actividad.add(ejercicio);
  }

  notifyListeners();
}


  UserActivity _classify(double heartRate, double accel, int stepsDelta) {
    // if (heartRate > 120 && accel > 3.0 && stepsDelta > 20) {
    //   return UserActivity.exercising;
    // } else if (heartRate > 90 && accel > 1.5 && stepsDelta > 10) {
    //   return UserActivity.walking;
    // } else {
    //   return UserActivity.resting;
    // }
    if (heartRate > 120) {
      return UserActivity.exercising;
    } else if (heartRate > 90) {
      return UserActivity.walking;
    } else {
      return UserActivity.resting;
    }
  }
}
