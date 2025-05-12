import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:deepsleep/presentation/controllers/ExerciseController/graficoController.dart';
import 'package:deepsleep/data/services/CleintServer.dart'; // importa el servicio BLE
import 'package:permission_handler/permission_handler.dart'; // para pedir permisos

class Actividad with ChangeNotifier {
  final BLEService _ble = BLEService();
  double _promedio = 0;
  double _min = 0;
  double _max = 0;
  double _ritmoCardiaco = 0;
  final List<int> _datos = [];
  Map<String, double> _estadistica = {"P": 0, "Mn": 0, "MX": 0};
  final Graficar _graficar = Graficar();

  bool _puedeEscanear = true; // control para evitar escaneo frecuente

  List<int> get datos => List.unmodifiable(_datos);
  double get promedio => _promedio;
  double get min => _min;
  double get max => _max;
  double get ritmoCardiaco => _ritmoCardiaco;
  int _estado = 0; // 0: Escaneando, 1: Conectado, 2: Error, 3: Desconectado
  int get estado => _estado;
  

  void agregarDatoBLE(int nuevoDato) {
    if (nuevoDato > 30) {
      _datos.add(nuevoDato);
      _ritmoCardiaco = nuevoDato.toDouble();
      _estadistica = _graficar.calcularEstadisticas(_datos);
      _promedio = _estadistica["P"]!;
      _min = _estadistica["Mn"]!;
      _max = _estadistica["Mx"]!;
      _estado =_ble.estado;
      notifyListeners();
    }
  }

  Future<void> iniciarMonitoreo() async {
    if (!_puedeEscanear) return;
    _puedeEscanear = false;

    await _pedirPermisos();

    _ble.startScan(onData: (data) {
      if (data.containsKey("heartRate")) {
        agregarDatoBLE(data["heartRate"].toInt());
        print("Ritmo cardiaco: ${data["heartRate"]} nuevodato");
      }
    });

    // Esperar 10 segundos antes de permitir nuevo escaneo
    Future.delayed(const Duration(seconds: 1), () {
      _puedeEscanear = true;
    });
  }

  void detenerMonitoreo() {
    _ble.disconnect();
  }

  Future<void> _pedirPermisos() async {
    await [
      Permission.location,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetooth,
    ].request();
  }
}
