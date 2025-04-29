import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deepsleep/presentation/views/actividad/pantalla_ejercicio.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/encabezado.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/progreso.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/MetricCard.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/Grafico.dart';
import 'package:deepsleep/presentation/views/actividad/widgets/exerciseItem.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';

void main() {
  testWidgets('PantallaEjercicio renders all expected widgets', (WidgetTester tester) async {
    // Envolver la pantalla con el Provider adecuado
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Controllers(), // Aquí se debe crear el Controller para las pruebas
        child: MaterialApp(home: PantallaEjercicio()),
      ),
    );

    // Verificar que el encabezado "Mi ejercicio" esté presente
    expect(find.text('Mi ejercicio'), findsOneWidget);

    // Verificar que el widget de progreso esté presente
    expect(find.byType(ProgresoWidget), findsOneWidget);

    // Verificar que el widget de métricas esté presente
    expect(find.byType(BuildMetricos), findsOneWidget);

    // Verificar que la lista de ejercicios esté presente
    expect(find.byType(BuildListaEjercicios), findsOneWidget);

    // Verificar que el gráfico cardíaco esté presente
    expect(find.byType(BuildGraficoCardiaco), findsOneWidget);
  });

  testWidgets('PantallaEjercicio scrolls correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Controllers(), // Proveedor para los test
        child: MaterialApp(home: PantallaEjercicio()),
      ),
    );

    // Asegúrate de que el widget sea scrollable
    final scrollable = find.byType(SingleChildScrollView);
    expect(scrollable, findsOneWidget);

    // Realizar desplazamiento hacia abajo
    await tester.drag(scrollable, Offset(0, -300));
    await tester.pumpAndSettle();

    // Verifica que los widgets aún sean visibles después de desplazarse
    expect(find.byType(ProgresoWidget), findsOneWidget);
    expect(find.byType(BuildMetricos), findsOneWidget);
    expect(find.byType(BuildListaEjercicios), findsOneWidget);
    expect(find.byType(BuildGraficoCardiaco), findsOneWidget);
  });
}
