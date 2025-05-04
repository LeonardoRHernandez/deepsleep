import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:deepsleep/data/models/suenoModel.dart';
import 'package:hive/hive.dart';

class BuildEncabezadoFijo extends StatelessWidget {
  const BuildEncabezadoFijo({
    super.key,
    required this.context,
    required this.titulo,
  });

  final BuildContext context;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Mi sueño',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.bed, color: Colors.black, size: 28),
                onPressed: () {
                  mostrarFormularioDormir(context);
                },
                tooltip: 'Agregar sueño',
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  // Acción de notificaciones si quieres
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void mostrarFormularioDormir(BuildContext context) {
  final dormirController = TextEditingController();
  final despertarController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      String labelText = "Hora que te fuiste a dormir";
      var hintText = "Ej. 22:30";
      var labelText2 = "Hora que te despertaste";
      var hintText2 = "Ej. 07:00";
      return AlertDialog(
        title: const Text("Agregar horas de sueño"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelSueno(
              controller: dormirController,
              labelText: labelText,
              hintText: hintText,
            ),
            const SizedBox(height: 12),
            LabelSueno(
              controller: despertarController,
              labelText: labelText2,
              hintText: hintText2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              // Obtén las horas ingresadas
              String horaDormir = dormirController.text;
              String horaDespertar = despertarController.text;

              // Procesar los datos de sueño
              String data = procesarDatos(horaDormir, horaDespertar);

              // Lógica para guardar los datos de sueño
              DateTime hoy = DateTime.now();
              String fechaFormateada =
                  "${hoy.year}-${hoy.month.toString().padLeft(2, '0')}-${hoy.day.toString().padLeft(2, '0')}";

              Provider.of<Controllers>(
                context,
                listen:
                    false, //asignar estos valorees a un objeto de la clase Sueno
              ).listsueno.agregarSueno(
                Sueno(
                  fechaFormateada,
                  5,
                  data,
                  horaDormir,
                  horaDespertar,
                  "70",
                ),
              );
              // Guardar en Hive
              var suenoBox = Hive.box<Sueno>('suenoBox');
              suenoBox.add(
                Sueno(
                  fechaFormateada,
                  5,
                  data,
                  horaDormir,
                  horaDespertar,
                  "70",
                ),
              );
              // Mostrar mensaje de éxito
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Datos de sueño guardados con éxito"),
                  duration: Duration(seconds: 2),
                ),
              );

              // Cerrar el diálogo
              Navigator.of(context).pop();
            },
            child: const Text("Guardar"),
          ),
        ],
      );
    },
  );
}

String procesarDatos(String horaDormir, String horaDespertar) {
  try {
    // Convierte las horas en objetos DateTime
    final formato = RegExp(r'^\d{2}:\d{2}$'); // Valida el formato HH:mm
    if (!formato.hasMatch(horaDormir) || !formato.hasMatch(horaDespertar)) {
      return "Formato de hora inválido. Usa HH:mm.";
    }

    final dormir = _convertirHoraADateTime(horaDormir);
    final despertar = _convertirHoraADateTime(horaDespertar);

    // Si la hora de despertar es menor que la de dormir, asumimos que es al día siguiente
    final despertarFinal =
        despertar.isBefore(dormir)
            ? despertar.add(const Duration(days: 1))
            : despertar;

    // Calcula la duración del sueño
    final duracion = despertarFinal.difference(dormir);

    // Formatea la duración en horas y minutos
    final horas = duracion.inHours;
    final minutos = duracion.inMinutes % 60;

    return "${horas}h ${minutos}m";
  } catch (e) {
    return "Error al procesar los datos: $e";
  }
}

DateTime _convertirHoraADateTime(String hora) {
  final partes = hora.split(':');
  final horas = int.parse(partes[0]);
  final minutos = int.parse(partes[1]);
  return DateTime(
    0,
    1,
    1,
    horas,
    minutos,
  ); // Fecha ficticia para calcular solo la hora
}

class LabelSueno extends StatelessWidget {
  const LabelSueno({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
      keyboardType: TextInputType.datetime,
    );
  }
}

//List<Sueno> suenos = suenoBox.values.toList(); para leer los sueños guardados
