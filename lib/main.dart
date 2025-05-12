import 'package:deepsleep/presentation/controllers/ExerciseController/actividad.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/views/Sueno/pantalla_sueno.dart';
import 'presentation/views/actividad/pantalla_ejercicio.dart';
import 'presentation/views/ajustes/pantalla_ajustes.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:deepsleep/data/models/suenoModel.dart';
import 'package:deepsleep/data/models/configModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  //await prefs.clear(); // ⚠️ BORRA TODOS LOS DATOS
  await Hive.initFlutter(); //Persistencia de datos con Hive
  Hive.registerAdapter(SuenoAdapter()); // ¡Importante!
  Hive.registerAdapter(ConfiguracionAdapter()); // ¡Importante!
  await Hive.openBox<Sueno>('suenoBox'); // Abre la caja de sueños

  await Hive.openBox<Configuracion>(
    'configuracionBox',
  ); // Abre la caja de configuracion
  //await Hive.box<Sueno>('suenoBox').clear(); //para limpiar la caja en pruebas

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controllers()),
        ChangeNotifierProvider(create: (_) => ActivityDetector()),
      ],
      child: const MiApp(),
    ),
  );
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final actividad =
          Provider.of<Controllers>(context, listen: false).actividad;
      actividad.iniciarMonitoreo();
    });
  }

  int _selectedIndex = 1;
  bool _isFirstTimeAjustes = true;
  bool _isUnlocked = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _desbloquearPantallas({bool redirigirASueno = true}) {
    setState(() {
      _isUnlocked = true;
      _isFirstTimeAjustes = false;
      if (redirigirASueno) {
        _selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pantallas = <Widget>[
      PantallaSueno(),
      PantallaAjustes(
        desbloquearPantallas: _desbloquearPantallas,
      ), // Pasar la función aquí
      PantallaEjercicio(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deep Sleep"),
        backgroundColor: Colors.blueAccent,
      ),

      body: pantallas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (_isUnlocked || index == 1) {
            _onItemTapped(index);
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bedtime), label: 'Sueño'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color:
                  _isFirstTimeAjustes && !_isUnlocked
                      ? Colors.red
                      : Colors.green,
            ),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Ejercicio',
          ),
        ],
      ),
    );
  }
}
