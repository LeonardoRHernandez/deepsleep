import 'package:deepsleep/data/models/suenoModel.dart';
import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/statCard.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BuildRecordAndAverage extends StatelessWidget {
  const BuildRecordAndAverage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Sueno>('suenoBox').listenable(),
      builder: (context, Box<Sueno> box, _) {
        final historial = box.values.toList();

        String tiempoMaximo = calcularTiempoMaximo(historial);
        List<String> partes = tiempoMaximo.split('|');
        String tiempo = partes[0];
        String fecha = partes[1];

        String promedio7Dias = calcularPromedioUltimos7Dias(historial);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildStatCard(
              icon: '🏆',
              title: 'Tu récord',
              value: tiempo,
              subtitle: fecha,
            ),
            BuildStatCard(
              icon: '📊',
              title: 'Promedio',
              value: promedio7Dias,
              subtitle: 'Últimos 7 registros',
            ),
          ],
        );
      },
    );
  }
}

String calcularTiempoMaximo(List<Sueno> historialSueno) {
  String tiempoMaximo = '';
  String fechaMaxima = '';
  int maxHoras = 0;
  int maxMinutos = 0;

  for (var sueno in historialSueno) {
    String tiempo = sueno.duracion;
    String fecha = sueno.fecha;

    List<String> partes = tiempo.split('h');
    int horas = int.tryParse(partes[0].trim()) ?? 0;
    int minutos = int.tryParse(partes[1].replaceAll('m', '').trim()) ?? 0;

    if (horas > maxHoras || (horas == maxHoras && minutos > maxMinutos)) {
      maxHoras = horas;
      maxMinutos = minutos;
      tiempoMaximo = "${horas}H\n${minutos}M";
      fechaMaxima = fecha;
    }
  }

  return "$tiempoMaximo|$fechaMaxima";
}

String calcularPromedioUltimos7Dias(List<Sueno> historialSueno) {
  if (historialSueno.isEmpty) return "0H\n0M";

  int totalHoras = 0;
  int totalMinutos = 0;
  int diasContados = 0;

  for (var i = historialSueno.length - 1; i >= 0 && diasContados < 7; i--) {
    String tiempo = historialSueno[i].duracion;

    List<String> partes = tiempo.split('h');
    int horas = int.tryParse(partes[0].trim()) ?? 0;
    int minutos = int.tryParse(partes[1].replaceAll('m', '').trim()) ?? 0;

    totalHoras += horas;
    totalMinutos += minutos;
    diasContados++;
  }

  totalHoras += totalMinutos ~/ 60;
  totalMinutos = totalMinutos % 60;

  if (diasContados > 0) {
    int promedioHoras = totalHoras ~/ diasContados;
    int promedioMinutos = totalMinutos ~/ diasContados;

    return "${promedioHoras}H\n${promedioMinutos}M";
  } else {
    return "0H\n0M";
  }
}
