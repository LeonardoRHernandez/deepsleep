import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class DataFetcher {
  final String baseUrl;

  DataFetcher({required this.baseUrl});

  /// Obtiene datos del servidor y retorna la frecuencia cardíaca.
  Future<int> fetchData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // Parseamos el JSON de la respuesta
        final data = jsonDecode(response.body);

        // Validamos que los datos contengan las claves esperadas
        if (data.containsKey('heartRate') && data.containsKey('steps')) {
          print('Heart Rate: ${data['heartRate']}');
          print('Steps: ${data['steps']}');
          return int.parse(data['heartRate']);
        } else {
          print('Error: Respuesta no contiene los datos esperados.');
          return 0;
        }
      } else {
        //Manejo de errores HTTP
        print('Error al obtener los datos: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      // Manejo de excepciones (por ejemplo, problemas de red)
      //print('Excepción al obtener los datos: $e');
      return 0;
    }
  }
}
