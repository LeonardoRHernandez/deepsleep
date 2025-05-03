import 'package:flutter/material.dart';
import 'presentation/views/Sueno/pantalla_sueno.dart';
import 'presentation/views/actividad/pantalla_ejercicio.dart';
import 'presentation/views/ajustes/pantalla_ajustes.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:deepsleep/presentation/controllers/ExerciseController/ControlerActividad.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Controllers(),
        ),
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
  int _selectedIndex = 1;
  bool _isFirstTimeAjustes = true; 
  bool _isUnlocked = false; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   void _desbloquearPantallas() {
    setState(() {
      _isUnlocked = true; 
      _isFirstTimeAjustes = false; 
      _selectedIndex = 0; 
    });
  }

  @override
    Widget build(BuildContext context) {
    final List<Widget> pantallas = <Widget>[
      PantallaSueno(),
      PantallaAjustes(desbloquearPantallas: _desbloquearPantallas), // Pasar la función aquí
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
          BottomNavigationBarItem(
            icon: Icon(Icons.bedtime),
            label: 'Sueño',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _isFirstTimeAjustes && !_isUnlocked ? Colors.red : Colors.green,
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
