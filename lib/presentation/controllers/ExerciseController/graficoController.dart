import 'package:fl_chart/fl_chart.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';
List<FlSpot> list20Graf(Controllers provider) {
  return provider.datos
                                  .sublist(
                                    provider.datos.length > 40
                                        ? provider.datos.length - 40
                                        : 0,
                                  )
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => FlSpot(
                                      (entry.key +
                                              (provider.datos.length > 40
                                                  ? provider.datos.length - 40
                                                  : 0))
                                          .toDouble(),
                                      entry.value.toDouble(),
                                    ),
                                  )
                                  .toList();
}
