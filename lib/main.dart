import 'package:flutter/material.dart';
import 'presentation/views/Sueno/pantalla_sueno.dart';
import 'presentation/views/actividad/pantalla_ejercicio.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/procesarDatos.dart';

void main() {
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RitmoCardiacoProvider(),
        ),
      ],
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
      Provider.of<RitmoCardiacoProvider>(
        context,
        listen: false,
      ).agregarNuevoDato();
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
      body: _selectedIndex == 0 ? const PantallaSueno() : const PantallaEjercicio(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bedtime),
            label: 'Sueño',
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
