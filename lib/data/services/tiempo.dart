import 'package:intl/intl.dart';
/// Obtiene la hora actual en formato HH:mm
String obtenerHoraActual() {
  DateTime ahora = DateTime.now(); // Obtiene la hora actual
  String horaFormateada = DateFormat('HH:mm').format(ahora); // Formatea la hora
  return horaFormateada;
}