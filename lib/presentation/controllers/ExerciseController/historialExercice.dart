import 'package:flutter/material.dart';
class ListaEjercicios {
  final List<Map<String, dynamic>> _ejercicios = [//lista de prueba
      {"title": "Cardio Intenso", "subtitle": "15 oct - 1h 20 min", "kcal": 300},
      {"title": "Entrenamiento de Fuerza", "subtitle": "14 oct - 40 min", "kcal": 450},
      // {"title": "Yoga", "subtitle": "13 oct - 30 min", "kcal": 200},
      //{"title": "Caminata", "subtitle": "12 oct - 1h 10 min", "kcal": 250},
      //{"title": "Natación", "subtitle": "11 oct - 50 min", "kcal": 400},
      // {"title": "Ciclismo", "subtitle": "10 oct - 1h 30 min", "kcal": 350},
      // {"title": "Pilates", "subtitle": "9 oct - 45 min", "kcal": 220},
      // {"title": "Entrenamiento HIIT", "subtitle": "8 oct - 30 min", "kcal": 500},
      // {"title": "Zumba", "subtitle": "7 oct - 1h", "kcal": 300},
      // {"title": "Entrenamiento de Resistencia", "subtitle": "6 oct - 1h 15 min", "kcal": 400},
    ];
  List<Map<String, dynamic>> get exerciseList => _ejercicios;
//aqui obtenemos las lista de ejercicios
  
  
}