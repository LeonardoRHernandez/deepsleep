import 'package:fl_chart/fl_chart.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:provider/provider.dart';

class Graficar {
  Graficar();
  // Constructor
  final List<FlSpot> _data = [];
  List<FlSpot> get data => _data;

  List<FlSpot> listGraf(List<int> provider) => provider
    .asMap()
    .entries
    .map(
      (entry) => FlSpot(
        entry.key.toDouble(),
        entry.value.toDouble(),
      ),
    )
    .toList();

    
    
  
  List<FlSpot> list20Graf(List<int> provider) => provider
        .sublist(provider.length > 40 ? provider.length - 40 : 0)
        .asMap()
        .entries
        .map( 
          (entry) => FlSpot(
            (entry.key +
                    (provider.length > 40
                        ? provider.length - 40
                        : 0))
                .toDouble(),
            entry.value.toDouble(),
          ),
        )
        .toList();

  Map<String, double> calcularEstadisticas(List<int> datos) {
    if (datos.isEmpty) return {"P": 0, "Mn": 0, "MX": 0};

    double promedio = datos.average;
    double min = datos.min.toDouble();
    double max = datos.max.toDouble();
    return {"P": promedio, "Mn": min, "Mx": max};
  }
}
