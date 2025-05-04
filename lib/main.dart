import 'package:flutter/material.dart';
import 'presentation/views/Sueno/pantalla_sueno.dart';
import 'presentation/views/actividad/pantalla_ejercicio.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:deepsleep/data/models/suenoModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //Persistencia de datos con Hive
  Hive.registerAdapter(SuenoAdapter()); // ¡Importante!
  await Hive.openBox<Sueno>('suenoBox'); // Abre la caja de sueños

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Controllers())],
      child: const MiApp(),
    ),
  );
  //const MiApp());
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
    _iniciarAutoActualizacion();
  }

  void _iniciarAutoActualizacion() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false; // Verifica si el widget está montado
      Provider.of<Controllers>(
        context,
        listen: false,
      ).actividad.agregarNuevoDato();
      return true; // Retorna true para continuar el ciclo
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deep Sleep"),
        backgroundColor: Colors.blueAccent,
      ),
      body:
          _selectedIndex == 0
              ? const PantallaSueno()
              : const PantallaEjercicio(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bedtime), label: 'Sueño'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Ejercicio',
          ),
        ],
      ),
    );
  }
}
