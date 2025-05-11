import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deepsleep/presentation/views/ajustes/pantalla_ajustes.dart';
import 'package:deepsleep/presentation/views/ajustes/widgets/encabezado_ajustes.dart';
import 'package:deepsleep/presentation/views/ajustes/widgets/tarjeta_dato.dart';
import 'package:deepsleep/presentation/views/ajustes/widgets/formulario_ajustes.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PantallaAjustes Tests', () {
    testWidgets('Todos los widgets son renderizados correctamente', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'formularioCompletado': true,
        'peso': '70',
        'estatura': '175',
        'edad': '25',
        'genero': 'Masculino',
      });

      debugPrint('[]');
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Controllers(),
          child: MaterialApp(
            home: PantallaAjustes(desbloquearPantallas: ({bool redirigirASueno = false}) {
            }),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EncabezadoAjustes), findsOneWidget);
      expect(find.byType(TarjetaDato), findsNWidgets(4));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
    testWidgets('Hace scroll correctamente', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'formularioCompletado': true,
        'peso': '70',
        'estatura': '175',
        'edad': '25',
        'genero': 'Masculino',
      });

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Controllers(),
          child: MaterialApp(
            home: PantallaAjustes(
              desbloquearPantallas: ({bool redirigirASueno = false}) {
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable);
      debugPrint('[]');
      expect(scrollable, findsOneWidget);
      await tester.fling(scrollable, const Offset(0, -300), 1000);
      await tester.pumpAndSettle();
      expect(find.byType(TarjetaDato), findsWidgets);
    });
    testWidgets('Renderiza CircularProgressIndicator si el formulario no está completado',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'formularioCompletado': false,
      });

      debugPrint('[]');
      await tester.pumpWidget(
        MaterialApp(
          home: PantallaAjustes(
            desbloquearPantallas: ({bool redirigirASueno = false}) {            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Renderiza datos del perfil si el formulario está completado',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'formularioCompletado': true,
        'peso': '70',
        'estatura': '175',
        'edad': '25',
        'genero': 'Masculino',
      });

      debugPrint('[]');
      await tester.pumpWidget(
        MaterialApp(
          home: PantallaAjustes(
            desbloquearPantallas: ({bool redirigirASueno = false}) {
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EncabezadoAjustes), findsOneWidget);
      expect(find.text('Perfil'), findsOneWidget);
      expect(find.byType(TarjetaDato), findsNWidgets(4));
      expect(find.text('70 kg'), findsOneWidget);
      expect(find.text('175 cm'), findsOneWidget);
      expect(find.text('25 años'), findsOneWidget);
      expect(find.text('Masculino'), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byType(FormularioAjustes), findsNothing);
    });
  });
}
