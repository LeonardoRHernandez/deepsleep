import 'package:deepsleep/presentation/controllers/procesarDatos.dart';


double calcularCaloriasPorMinuto({
  required double hr, // Frecuencia cardíaca
  required double pesoKg, // Peso en kilogramos
  required int edad, // Edad en años
}) {
  // Fórmula para calcular calorías por minuto
  double caloriasPorMinuto =
      (-55.0969 + (0.6309 * hr) + (0.1988 * pesoKg) + (0.2017 * edad)) / 4.184;

  return caloriasPorMinuto;
}

double calcularCaloriasPorHora({
  required double hr, // Frecuencia cardíaca
  required double pesoKg, // Peso en kilogramos
  required int edad, // Edad en años
}) {
  // Fórmula para calcular calorías por hora
  double caloriasPorHora =
      calcularCaloriasPorMinuto(hr: hr, pesoKg: pesoKg, edad: edad) * 60;
  return caloriasPorHora;
}

double calcularCaloriasPorDia({
  required double hr, // Frecuencia cardíaca
  required double pesoKg, // Peso en kilogramos
  required int edad, // Edad en años
}) {
  // Fórmula para calcular calorías por día
  double caloriasPorDia =
      calcularCaloriasPorHora(hr: hr, pesoKg: pesoKg, edad: edad) * 24;
  return caloriasPorDia;
}

double calcularCaloriaTotal(
  DateTime inicio,
  DateTime fin,
  RitmoCardiacoProvider provider,
) {
  // Aquí puedes implementar la lógica para calcular la cantidad total de calorías
  // quemadas en un día, sumando las calorías de cada ejercicio.
  // Por ejemplo:;

  //double totalCalorias = 0;
  Duration tiempoTotal = fin.difference(inicio);
  double caloriasPromedio=calcularCaloriasPorMinuto(hr: provider.promedio, pesoKg: 85, edad: 22);
  double caloriasEjercicio = caloriasPromedio * tiempoTotal.inMinutes;

  // totalCalorias += caloriasEjercicio1;
  // totalCalorias += caloriasEjercicio2;
  // ...
  return caloriasEjercicio;
}
