import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:deepsleep/data/models/sensorModel.dart';

class ActivityDetector extends ChangeNotifier {
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

  List<ActivitySession> extraerSesionesActivas() {
    final activas =
        _history
            .where(
              (s) =>
                  s.activity == UserActivity.walking ||
                  s.activity == UserActivity.exercising,
            )
            .toList();

    // Eliminarlas del historial original
    _history.removeWhere((s) => activas.contains(s));

    return activas;
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
