import 'package:deepsleep/data/models/ejercicioModel.dart';
import 'package:deepsleep/data/models/sensorModel.dart';
import 'package:deepsleep/data/models/suenoModel.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/actividad.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:deepsleep/presentation/controllers/ExerciseController/graficoController.dart';
import 'package:deepsleep/data/services/CleintServer.dart'; // importa el servicio BLE
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart'; // para pedir permisos

class Actividad with ChangeNotifier {
  final void Function(Sueno)? onNuevoSueno;
  DateTime? _inicioSueno;
final List<Sueno> _historialSueno = [];

  Actividad({this.onNuevoSueno}) {
    _activity.addListener(notifyListeners);
  }
  bool _estaDormido = false;
DateTime _ultimoMovimiento = DateTime.now();

bool get estaDormido => _estaDormido;

  final ActivityDetector _activity = ActivityDetector();
  final BLEService _ble = BLEService();
  double _promedio = 0;
  double _min = 0;
  double _max = 0;
  double _ritmoCardiaco = 0;
  double _steps = 0;
  double _ax = 0;
  double _ay = 0;
  double _az = 0;
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
  double get steps => _steps;
  double get ax => _ax;
  double get ay => _ay;
  final List<Ejercicio> _ejercicios = [
    //Ejercicio("Cardio Intenso", "15 oct","1h 20 min", 300),
    //Ejercicio("Entrenamiento de Fuerza", "14 oct","0h 40 min", 450),
    //Ejercicio("Yoga", "13 oct","0h 30 min", 200),
    //Ejercicio("Caminata", "12 oct","1h 10 min", 250),
    //Ejercicio("Natación", "11 oct","0h 50 min", 400),
    //Ejercicio("Ciclismo", "10 oct","1h 30 min", 350),
    //Ejercicio("Pilates", "9 oct","0h 45 min", 220),
    Ejercicio("Entrenamiento HIIT", "8 oct", "0h 30 min", 500),
    Ejercicio("Zumba", "7 oct", "1h", 300),
    //Ejercicio("Entrenamiento de Resistencia", "6 oct","1h 15 min", 400),
  ];
  //List<Ejercicio> get ejercicios => _ejercicios;
  void agregarEjercicio(Ejercicio nuevoEjercicio) {
    _ejercicios.add(nuevoEjercicio);
    notifyListeners();
  }
  void evaluarSueno() async {
  double movimiento = sqrt(_ax * _ax + _ay * _ay + _az * _az);
  final ahora = DateTime.now();

  if (movimiento > 10 || _steps > 0) {
    _ultimoMovimiento = ahora;
  }

  final segundosSinMovimiento = ahora.difference(_ultimoMovimiento).inSeconds;
  //print("Duracion: $segundosSinMovimiento");
  if (segundosSinMovimiento > 60 && _ritmoCardiaco < 60) {
    if (!_estaDormido) {
      _inicioSueno = ahora;
    }
    _estaDormido = true;
  } else {
    if (_estaDormido && _inicioSueno != null) {
      DateTime finSueno = ahora;

      Duration duracion = finSueno.difference(_inicioSueno!);
      String duracionTexto =
          "${duracion.inHours}h ${duracion.inMinutes.remainder(60)}m";

      String fecha = "${_inicioSueno!.day}/${_inicioSueno!.month}/${_inicioSueno!.year}";
      String horaInicio = "${_inicioSueno!.hour}:${_inicioSueno!.minute.toString().padLeft(2, '0')}";
      String horaFinal = "${finSueno.hour}:${finSueno.minute.toString().padLeft(2, '0')}";
      //la eficiencia funcionna igual que las estrellas
      String eficiencia = "${(duracion.inHours / 8 * 100).clamp(0, 100).toStringAsFixed(2)}%";
      //estrelas salen de 0 a 5 dependiendo si durmio 8 horas o menos dividiendolo en 5 partes iguales
      // 0-1.6 horas = 0 estrellas
      int estrellas = duracion.inHours > 8
          ? 5
          : (duracion.inHours / 1.6).floor().clamp(0, 5);
      print("Duracion: $duracionTexto");
      //print("estrellas: $estrellas");
      final nuevoSueno = Sueno(
        fecha,
        estrellas,
        duracionTexto,
        horaInicio,
        horaFinal,
        eficiencia,
      );

      _historialSueno.add(nuevoSueno);
      final box = await Hive.openBox<Sueno>('suenoBox');
      await box.add(nuevoSueno);
      if (onNuevoSueno != null) {
  onNuevoSueno!(nuevoSueno); // se lo pasa al controlador
}

      _inicioSueno = null;
    }

    _estaDormido = false;
  }
  

  notifyListeners();
}



  void agregaDatoBLE(
    BuildContext context, {
    required int heartRate,
    required int ritmoPromedio,
    required int steps,
    required double ax,
    required double ay,
    required double az,
  }) {
    final detector = context.read<ActivityDetector>();
    //print(detector.extraerSesionesActivas());

    detector.update(
      SensorData(
        timestamp: DateTime.now(),
        ritmoPromedio:ritmoPromedio,
        heartRate: heartRate,
        accelX: ax,
        accelY: ay,
        accelZ: az,
        steps: steps,
      ),
    );
  }

  ActivityDetector get actividad => _activity;
  List<Ejercicio> get ejerciciosList => _ejercicios;
  void agregarDatoBLE(Map<String, dynamic> nuevoDato) {
    if (nuevoDato["heartRate"] > 30) {
      //print("paso el if");

      _ritmoCardiaco = nuevoDato["heartRate"].toDouble();
      _datos.add(_ritmoCardiaco.toInt());
      //Log.d("Datos: $_datos");

      _estadistica = _graficar.calcularEstadisticas(_datos);
      _promedio = _estadistica["P"]!;
      _min = _estadistica["Mn"]!;
      _max = _estadistica["Mx"]!;
      _estado = _ble.estado;

      _ritmoCardiaco = nuevoDato["heartRate"].toDouble();

      _steps = nuevoDato["steps"].toDouble();
      //print("Tipo de x: ${nuevoDato["X"]?.runtimeType}");
      Map<String, dynamic> acc = nuevoDato["accelerometer"];
      //print("Tipo de acc: $acc");
      _ax = acc["x"].toDouble();
      _ay = acc["y"].toDouble();
      _az = acc["z"].toDouble();
      //final nuevas = detector.extraerSesionesActivas();
      //_resumenDiario.addAll(nuevas);

      _activity.update(
        SensorData(
          timestamp: DateTime.now(),
          heartRate: _ritmoCardiaco.toInt(),
          ritmoPromedio: _promedio.toInt(),
          accelX: _ax,
          accelY: _ay,
          accelZ: _az,
          steps: _steps.toInt(),
        ),
      );
      
      //print("noticar a listeners");
       _activity.extraerSesionesActivas(_ejercicios);
      // if (actividad.isNotEmpty) {
      //   //print("Actividad: $actividad");
      //   //print("Actividad: $actividad");
      //   _ejercicios.add(
      //     Ejercicio(
      //       actividad[0].activity.toString(),
      //       actividad[0].startTime.toString(),
      //       actividad[0].duration.inMinutes.toString(),
      //       actividad[0].averageHeartRate.toInt(),
      //     ),
      //   );
        
      // }
      //print("Ejercicio: ${_ejercicios.last}");
      notifyListeners();
    }
  }

  Future<void> iniciarMonitoreo() async {
    if (!_puedeEscanear) return;

    await _pedirPermisos();

    _ble.startScan(
      onData: (data) {
        if (data.containsKey("heartRate")) {
          agregarDatoBLE(data);
          //print("Ritmo cardiaco: ${data["heartRate"]} nuevodato");
        }
      },
    );
    //agregaDatoBLE(context, heartRate: heartRate, steps: steps, ax: ax, ay: ay, az: az);

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
