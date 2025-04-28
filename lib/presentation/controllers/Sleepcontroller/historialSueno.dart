import 'package:flutter/material.dart';

class Listsueno {
  
    // Lista de datos para generar los widgets dinámicamente
    final List<Map<String, dynamic>> _historialSueno = [
      {"data2": "14 oct", "cantidadEstrellas": 5, "data": "7 h 42m","horaInicio": "23:14","horaFinal": "07:02"},
      {"data2": "13 oct", "cantidadEstrellas": 4, "data": "6 h 30m","horaInicio": "23:14","horaFinal": "07:02"},
      {"data2": "12 oct", "cantidadEstrellas": 3, "data": "5 h 15m","horaInicio": "23:14","horaFinal": "07:02"},
      {"data2": "11 oct", "cantidadEstrellas": 2, "data": "4 h 50m","horaInicio": "23:14","horaFinal": "07:02"},
      {"data2": "10 oct", "cantidadEstrellas": 1, "data": "3 h 20m","horaInicio": "23:14","horaFinal": "07:02"},
      
    ];

  List<Map<String, dynamic>> get historialSueno => _historialSueno;
  // Método para agregar un nuevo sueño a la lista
  void agregarSueno(String data2, int cantidadEstrellas, String data, String horaInicio, String horaFinal) {
    _historialSueno.add({"data2": data2, "cantidadEstrellas": cantidadEstrellas, "data": data,"horaInicio": horaInicio, "horaFinal": horaFinal});
  }
}
