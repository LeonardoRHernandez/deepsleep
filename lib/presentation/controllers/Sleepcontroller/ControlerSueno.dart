import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:deepsleep/presentation/controllers/Sleepcontroller/historialSueno.dart';
import 'package:deepsleep/data/services/CleintServer.dart'; // Para hacer la petición HTTP

class Sueno with ChangeNotifier {
  String fecha;
  int estrellas;
  String duracion;
  String horaInicio;
  String horaFinal;
  String eficiencia;
  Sueno(
    this.fecha,
    this.estrellas,
    this.duracion,
    this.horaInicio,
    this.horaFinal,
    this.eficiencia,
  );
  Sueno.empty()
    : fecha = "",
      estrellas = 0,
      duracion = "",
      horaInicio = "",
      horaFinal = "",
      eficiencia = "";
}
