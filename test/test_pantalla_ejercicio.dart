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
  testWidgets('PantallaEjercicio todos los widgets son renderizados correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Controllers(),
        child: MaterialApp(home: PantallaEjercicio()),
      ),
    );

    expect(find.text('Mi ejercicio'), findsOneWidget);
    expect(find.byType(ProgresoWidget), findsOneWidget);
    expect(find.byType(BuildMetricos), findsOneWidget);
    expect(find.byType(BuildListaEjercicios), findsOneWidget);
    expect(find.byType(BuildGraficoCardiaco), findsOneWidget);
  });

  testWidgets('PantallaEjercicio hace scroll correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Controllers(),
        child: MaterialApp(home: PantallaEjercicio()),
      ),
    );

    final scrollable = find.byType(SingleChildScrollView);
    expect(scrollable, findsOneWidget);

    await tester.drag(scrollable, Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.byType(ProgresoWidget), findsOneWidget);
    expect(find.byType(BuildMetricos), findsOneWidget);
    expect(find.byType(BuildListaEjercicios), findsOneWidget);
    expect(find.byType(BuildGraficoCardiaco), findsOneWidget);
  });

  testWidgets('PantallaEjercicio lista ejercicios correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Controllers(),
        child: MaterialApp(home: PantallaEjercicio()),
      ),
    );

    expect(find.byType(BuildExerciseItem), findsWidgets);
  });
}
