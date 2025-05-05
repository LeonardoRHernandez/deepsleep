import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
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
  DateTime horaDormir = DateTime.now();
  DateTime horaDespertar = DateTime.now();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text(
              "Hora que te fuiste a dormir",
              style: TextStyle(color: Colors.white),
            ),
            content: TimePickerSpinner(
              is24HourMode: true,
              normalTextStyle: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              highlightedTextStyle: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              spacing: 40,
              itemHeight: 60,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  horaDormir = time;
                });
              },
            ),

            actions: [
              TextButton(
                child: const Text(
                  "Cancelar",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white10,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Siguiente"),
                onPressed: () {
                  Navigator.of(context).pop();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text(
                              "Hora que te despertaste",
                              style: TextStyle(color: Colors.white),
                            ),
                            content: TimePickerSpinner(
                              is24HourMode: true,
                              normalTextStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              highlightedTextStyle: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                              spacing: 40,
                              itemHeight: 60,
                              isForce2Digits: true,
                              onTimeChange: (time) {
                                setState(() {
                                  horaDespertar = time;
                                });
                              },
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white10,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Guardar"),
                                onPressed: () {
                                  String horaDormirStr =
                                      "${horaDormir.hour.toString().padLeft(2, '0')}:${horaDormir.minute.toString().padLeft(2, '0')}";
                                  String horaDespertarStr =
                                      "${horaDespertar.hour.toString().padLeft(2, '0')}:${horaDespertar.minute.toString().padLeft(2, '0')}";

                                  String data = procesarDatos(
                                    horaDormirStr,
                                    horaDespertarStr,
                                  );
                                  DateTime hoy = DateTime.now();
                                  String fechaFormateada =
                                      "${hoy.year}-${hoy.month.toString().padLeft(2, '0')}-${hoy.day.toString().padLeft(2, '0')}";

                                  Provider.of<Controllers>(
                                    context,
                                    listen: false,
                                  ).agregarSueno(
                                    Sueno(
                                      fechaFormateada,
                                      0,
                                      data,
                                      horaDormirStr,
                                      horaDespertarStr,
                                      "0",
                                    ),
                                  );
                                  var suenoBox = Hive.box<Sueno>('suenoBox');
                                  suenoBox.add(
                                    Sueno(
                                      fechaFormateada,
                                      5,
                                      data,
                                      horaDormirStr,
                                      horaDespertarStr,
                                      "70",
                                    ),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Datos de sueño guardados con éxito",
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
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

    return "${horas.toString().padLeft(2, '0')}h ${minutos.toString().padLeft(2, '0')}m";
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
