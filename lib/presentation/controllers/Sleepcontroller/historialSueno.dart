// class Listsueno {

//     // Lista de datos para generar los widgets dinámicamente
//     final List<Map<String, dynamic>> _historialSueno = [
//       {"data2": "10 oct", "cantidadEstrellas": 5, "data": "7 h 42m","horaInicio": "23:14","horaFinal": "07:02","eficiencia": "94%"},
//       // {"data2": "11 oct", "cantidadEstrellas": 4, "data": "7 h 42m","horaInicio": "23:14","horaFinal": "07:02","eficiencia":"90%"},
//       // {"data2": "12 oct", "cantidadEstrellas": 3, "data": "7 h 42m","horaInicio": "23:14","horaFinal": "07:02","eficiencia":"85%"},
//       // {"data2": "13 oct", "cantidadEstrellas": 2, "data": "7 h 42m","horaInicio": "23:14","horaFinal": "07:02","eficiencia":"80%"},
//       // {"data2": "14 oct", "cantidadEstrellas": 1, "data": "7 h 42m","horaInicio": "23:14","horaFinal": "07:02","eficiencia":"75%"},
//     ];

//   List<Map<String, dynamic>> get historialSueno => _historialSueno;
//   // Método para agregar un nuevo sueño a la lista
//   void agregarSueno(String data2, int cantidadEstrellas, String data, String horaInicio, String horaFinal, String eficiencia) {
//     _historialSueno.add({"data2": data2, "cantidadEstrellas": cantidadEstrellas, "data": data,"horaInicio": horaInicio, "horaFinal": horaFinal,"eficiencia": eficiencia});
//   }
// }
import 'package:deepsleep/data/models/suenoModel.dart';

class ListSueno {
  // Lista de objetos Sueno
  final List<Sueno> _historialSueno = [
    Sueno("10 oct", 5, "7 h 42m", "23:14", "07:02", "94"),
    // Puedes agregar más objetos aquí
  ];

  List<Sueno> get historialSueno => _historialSueno;

  // Método para agregar un nuevo sueño
  void agregarSueno(Sueno nuevoSueno) {
    _historialSueno.add(nuevoSueno);
  }
}
