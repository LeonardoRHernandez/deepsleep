// Pantallas/pantalla_ejercicio.dart
import 'package:flutter/material.dart';

class PantallaEjercicio extends StatelessWidget {
  const PantallaEjercicio({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          _buildEncabezadoFijo("Mi ejercicio"),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgreso(),
                  const SizedBox(height: 16),
                  _buildMetricos(),
                  const SizedBox(height: 16),
                  _buildListaEjercicios(),
                  const SizedBox(height: 16),
                  _buildGraficoCardiaco(),
                  const SizedBox(height: 16),
                  _buildBotonAgregar(context),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildProgreso() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Progreso Semanal", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: 8.5 / 10,
                minHeight: 20, // Más ancho
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            const Text(
              "8.5h / 10h",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
        ],
      ),
    );
  }

  Widget _buildMetricos() {
    return Row(
      children: [
        Expanded(child: _buildMetricCard(Icons.local_fire_department, "1,200 kcal", "Quemadas", Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: _buildMetricCard(Icons.favorite, "75 PPM", "Ritmo cardíaco", Colors.purple)),
      ],
    );
  }

  Widget _buildMetricCard(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildListaEjercicios() {
    return Column(
      children: [
        _buildExerciseItem("Cardio Intenso", "15 oct - 1h 20 min", 300),
        const SizedBox(height: 12),
        _buildExerciseItem("Entrenamiento de Fuerza", "14 oct - 40 min", 450),
      ],
    );
  }

  Widget _buildExerciseItem(String title, String subtitle, int kcal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const Icon(Icons.fitness_center, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange),
              SizedBox(width: 4),
            ],
          ),
          Text("$kcal kcal", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildGraficoCardiaco() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ritmo Cardíaco", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Icon(Icons.show_chart, size: 60, color: Colors.redAccent),
        ],
      ),
    );
  }

Widget _buildBotonAgregar(BuildContext context) {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade800.withOpacity(0.4),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          _mostrarFormularioDormir(context); 
        },
        icon: const Icon(Icons.fitness_center, size: 24),
        label: const Text(
          "Agregar ejercicio",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),
    ),
  );
}


  void _mostrarFormularioDormir(BuildContext context) {
    final dormirController = TextEditingController();
    final despertarController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Agregar horas de sueño"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dormirController,
                decoration: const InputDecoration(
                  labelText: "Hora que te fuiste a dormir",
                  hintText: "Ej. 22:30",
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: despertarController,
                decoration: const InputDecoration(
                  labelText: "Hora que te despertaste",
                  hintText: "Ej. 07:00",
                ),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildEncabezadoFijo(String titulo) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Icon(Icons.notifications, color: Colors.black),
      ],
    ),
  );
}
