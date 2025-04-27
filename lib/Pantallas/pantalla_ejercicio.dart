// Pantallas/pantalla_ejercicio.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PantallaEjercicio extends StatefulWidget {
  const PantallaEjercicio({super.key});

  @override
  State<PantallaEjercicio> createState() => _PantallaEjercicioState();
}

class _PantallaEjercicioState extends State<PantallaEjercicio> {
  bool _esSemanal = true;

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
    final String titulo = _esSemanal ? "Progreso Semanal" : "Progreso Mensual";
    final double valor = _esSemanal ? 8.5 / 10 : 32.0 / 40;
    final String texto = _esSemanal ? "8.5h / 10h" : "32h / 40h";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _esSemanal = !_esSemanal;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.swap_horiz, size: 18, color: Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: valor,
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Text(
                texto,
                style: const TextStyle(
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
        const SizedBox(height: 6),
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
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ritmo Cardíaco",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 72),
                        FlSpot(1, 75),
                        FlSpot(2, 78),
                        FlSpot(3, 76),
                        FlSpot(4, 80),
                        FlSpot(5, 85),
                        FlSpot(6, 78),
                        FlSpot(7, 90),
                        FlSpot(8, 87),
                        FlSpot(9, 100),
                      ],
                      isCurved: true,
                      color: Colors.redAccent,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _CardiacoDato(label: "Promedio", value: "75 PPM"),
              _CardiacoDato(label: "Mínimo", value: "60 PPM"),
              _CardiacoDato(label: "Máximo", value: "100 PPM"),
            ],
          ),
        ],
      ),
    );
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
          Row(
            children: [
              IconButton(
              icon: const Icon(Icons.accessibility_new_sharp, color: Colors.black, size: 28),
                onPressed: () {
                  print("Aqui va la accion del boton");
                },
                tooltip: 'Agregar sueño', // Tooltip al dejar presionado
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black, size: 28),
                onPressed: () {
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardiacoDato extends StatelessWidget {
  final String label;
  final String value;

  const _CardiacoDato({required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
