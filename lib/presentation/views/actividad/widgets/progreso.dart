import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/procesarDatos.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/historialExercice.dart';
class ProgresoWidget extends StatefulWidget {
  const ProgresoWidget({super.key});

  @override
  State<ProgresoWidget> createState() => _ProgresoWidgetState();
}

class _ProgresoWidgetState extends State<ProgresoWidget> {
  bool _esSemanal = true; // Ahora es mutable

  @override
  Widget build(BuildContext context) {
    // var Ejercicio = ListaEjercicios().exerciseList; // Lista de ejercicios
            
    //         ; // Promedio de horas de ejercicio
    // var promedioSemanal = calcularPromedioSemanalYMensual(Ejercicio); // Promedio de horas de sueño
    String titulo = _esSemanal ? "Progreso Semanal" : "Progreso Mensual";
    double valor = _esSemanal ? 8.5 / 10 : 32.0 / 40;
    String texto = _esSemanal ? "8.5h / 10h" : "32h / 40h";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _esSemanal = !_esSemanal; // Modifica el estado interno
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.swap_horiz, size: 18, color: Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: valor,
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Text(
                texto,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Map<String, String> calcularPromedioSemanalYMensual(List<Map<String, dynamic>> ejercicios) {
  int totalHorasSemanal = 0;
  int totalMinutosSemanal = 0;
  int totalHorasMensual = 0;
  int totalMinutosMensual = 0;

  DateTime hoy = DateTime.now();
  int diasEnMes = DateTime(hoy.year, hoy.month + 1, 0).day; // Días en el mes actual

  for (var ejercicio in ejercicios) {
    String fecha = ejercicio['subtitle'].split(' - ')[0]; // Ejemplo: "15 oct"
    String tiempo = ejercicio['subtitle'].split(' - ')[1]; // Ejemplo: "1h 20 min"

    // Convierte la fecha a un objeto DateTime
    DateTime fechaEjercicio = DateTime(
      hoy.year,
      _mesEnNumero(fecha.split(' ')[1]), // Convierte "oct" a 10
      int.parse(fecha.split(' ')[0]),
    );

    // Convierte el tiempo en horas y minutos
    List<String> partesTiempo = tiempo.split('h');
    int horas = int.parse(partesTiempo[0].trim());
    int minutos = int.parse(partesTiempo[1].replaceAll('min', '').trim());

    // Suma al total mensual
    totalHorasMensual += horas;
    totalMinutosMensual += minutos;

    // Si el ejercicio está dentro de los últimos 7 días, suma al total semanal
    if (hoy.difference(fechaEjercicio).inDays <= 7) {
      totalHorasSemanal += horas;
      totalMinutosSemanal += minutos;
    }
  }

  // Convierte los minutos totales en horas y minutos
  totalHorasSemanal += totalMinutosSemanal ~/ 60;
  totalMinutosSemanal = totalMinutosSemanal % 60;

  totalHorasMensual += totalMinutosMensual ~/ 60;
  totalMinutosMensual = totalMinutosMensual % 60;

  // Calcula los promedios
  int promedioHorasSemanal = totalHorasSemanal ~/ 7;
  int promedioMinutosSemanal = totalMinutosSemanal ~/ 7;

  int promedioHorasMensual = totalHorasMensual ~/ diasEnMes;
  int promedioMinutosMensual = totalMinutosMensual ~/ diasEnMes;

  return {
    "promedioSemanal": "${promedioHorasSemanal}h ${promedioMinutosSemanal}m",
    "promedioMensual": "${promedioHorasMensual}h ${promedioMinutosMensual}m",
  };
}

int _mesEnNumero(String mes) {
  const meses = {
    "ene": 1,
    "feb": 2,
    "mar": 3,
    "abr": 4,
    "may": 5,
    "jun": 6,
    "jul": 7,
    "ago": 8,
    "sep": 9,
    "oct": 10,
    "nov": 11,
    "dic": 12,
  };
  return meses[mes.toLowerCase()] ?? 0;
}