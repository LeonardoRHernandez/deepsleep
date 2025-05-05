import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:deepsleep/data/models/suenoModel.dart';
import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/statCard.dart';
import 'package:provider/provider.dart';

class BuildRecordAndAverage extends StatelessWidget {
  const BuildRecordAndAverage({super.key});

  @override
  Widget build(BuildContext context) {
    //String tiempoMaximo=calcularTiempoMaximo(provider.listsueno.historialSueno);
    var provider = Provider.of<Controllers>(context);
    String tiempoMaximo = calcularTiempoMaximo(provider.listsueno);
    List<String> partes = tiempoMaximo.split('|');
    String tiempo = partes[0]; // Tiempo máximo
    String fecha = partes[1]; // Fecha asociada al tiempo máximo

    String Promedio7Dias = calcularPromedioUltimos7Dias(provider.listsueno);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildStatCard(
          icon: '🏆',
          title: 'Tu récord',
          value: '$tiempo',
          subtitle: '$fecha',
        ),
        BuildStatCard(
          icon: '📊',
          title: 'Promedio',
          value: '$Promedio7Dias',
          subtitle: 'Últimos 7 registros',
        ),
      ],
    );
  }
}

String calcularTiempoMaximo(List<Sueno> historialSueno) {
  String tiempoMaximo = '';
  String fechaMaxima = '';
  int maxHoras = 0;
  int maxMinutos = 0;

  for (var sueno in historialSueno) {
    String tiempo = sueno.duracion; // Ejemplo: "7h 42m"
    String fecha = sueno.fecha; // Fecha asociada al sueño

    // Divide el tiempo en horas y minutos
    List<String> partes = tiempo.split('h');
    int horas = int.parse(partes[0]);
    int minutos = int.parse(partes[1].replaceAll('m', '').trim());

    // Verifica si este tiempo es mayor que el máximo actual
    if (horas > maxHoras || (horas == maxHoras && minutos > maxMinutos)) {
      maxHoras = horas;
      maxMinutos = minutos;
      tiempoMaximo = "${horas}H\n${minutos}M";
      fechaMaxima = fecha; // Actualiza la fecha asociada al tiempo máximo
    }
  }

  return "$tiempoMaximo|$fechaMaxima"; // Retorna ambos valores separados por un delimitador
}

String calcularPromedioUltimos7Dias(List<Sueno> historialSueno) {
  if (historialSueno.isEmpty) {
    return "0H\n0M"; // Si no hay datos, retorna 0
  }
  int totalHoras = 0;
  int totalMinutos = 0;
  int diasContados = 0;

  // Itera sobre los últimos 7 elementos del historial
  for (var i = historialSueno.length - 1; i >= 0 && diasContados < 7; i--) {
    String tiempo = historialSueno[i].duracion; // Ejemplo: "7h 42m"

    // Divide el tiempo en horas y minutos
    List<String> partes = tiempo.split('h');
    int horas = int.parse(partes[0]);
    int minutos = int.parse(partes[1].replaceAll('m', '').trim());

    // Suma las horas y minutos al total
    totalHoras += horas;
    totalMinutos += minutos;
    diasContados++;
  }

  // Convierte los minutos totales en horas y minutos
  totalHoras += totalMinutos ~/ 60;
  totalMinutos = totalMinutos % 60;

  // Calcula el promedio
  if (diasContados > 0) {
    int promedioHoras = totalHoras ~/ diasContados;
    int promedioMinutos = totalMinutos ~/ diasContados;

    return "${promedioHoras}H\n${promedioMinutos}M";
  } else {
    return "0H\n0M"; // Si no hay datos, retorna 0
  }
}
