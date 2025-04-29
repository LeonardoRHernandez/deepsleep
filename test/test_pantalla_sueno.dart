import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deepsleep/presentation/views/Sueno/pantalla_sueno.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/recommendation.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/recordAndAverage.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepTime.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepHistory.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/sleepDetails.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/encabezado.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';

void main() {
  testWidgets('PantallaSueno renders all expected widgets', (WidgetTester tester) async {
    // Envolver la pantalla con el Provider adecuado
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Controllers(), // Aquí se debe crear el Controller para las pruebas
        child: MaterialApp(home: PantallaSueno()),
      ),
    );

    // Verificar que el encabezado "Mi sueño" esté presente
    expect(find.text('Mi sueño'), findsOneWidget);
    debugPrint('Verificado: El encabezado "Mi sueño" está presente.');

    // Verificar que el widget de tiempo de sueño esté presente
    expect(find.byType(BuildSleepTime), findsOneWidget);
    debugPrint('Verificado: El widget de tiempo de sueño está presente.');

    // Verificar que el widget de registro y promedio esté presente
    expect(find.byType(BuildRecordAndAverage), findsOneWidget);
    debugPrint('Verificado: El widget de registro y promedio está presente.');

    // Verificar que el widget de recomendaciones esté presente
    expect(find.byType(BuildRecommendation), findsOneWidget);
    debugPrint('Verificado: El widget de recomendaciones está presente.');

    // Verificar que el widget de detalles del sueño esté presente
    expect(find.byType(BuildSleepDetails), findsOneWidget);
    debugPrint('Verificado: El widget de detalles del sueño está presente.');

    // Verificar que el widget de historial de sueño esté presente
    expect(find.byType(BuildSleepHistory), findsOneWidget);
    debugPrint('Verificado: El widget de historial de sueño está presente.');
  });

  testWidgets('PantallaSueno scrolls correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Controllers(), // Proveedor para los test
        child: MaterialApp(home: PantallaSueno()),
      ),
    );

    // Asegúrate de que el widget sea scrollable
    final scrollable = find.byType(SingleChildScrollView);
    expect(scrollable, findsOneWidget);
    debugPrint('Verificado: La pantalla es desplazable.');

    // Realizar desplazamiento hacia abajo
    await tester.drag(scrollable, Offset(0, -300));
    await tester.pumpAndSettle();

    // Verifica que los widgets aún sean visibles después de desplazarse
    expect(find.byType(BuildSleepTime), findsOneWidget);
    debugPrint('Verificado: El widget de tiempo de sueño sigue visible tras desplazamiento.');
    expect(find.byType(BuildRecordAndAverage), findsOneWidget);
    debugPrint('Verificado: El widget de registro y promedio sigue visible tras desplazamiento.');
    expect(find.byType(BuildRecommendation), findsOneWidget);
    debugPrint('Verificado: El widget de recomendaciones sigue visible tras desplazamiento.');
    expect(find.byType(BuildSleepDetails), findsOneWidget);
    debugPrint('Verificado: El widget de detalles del sueño sigue visible tras desplazamiento.');
    expect(find.byType(BuildSleepHistory), findsOneWidget);
    debugPrint('Verificado: El widget de historial de sueño sigue visible tras desplazamiento.');
  });
}
