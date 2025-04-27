// Pantallas/pantalla_sueno.dart
import 'package:flutter/material.dart';

class PantallaSueno extends StatelessWidget {
  const PantallaSueno({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado fijo arriba
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mi sueño',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bed, color: Colors.black, size: 28),
                        onPressed: () {
                          _mostrarFormularioDormir(context);
                        },
                        tooltip: 'Agregar sueño',
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.black, size: 28),
                        onPressed: () {
                          // Acción de notificaciones si quieres
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Contenido scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSleepTime(),
                    const SizedBox(height: 20),
                    _buildRecordAndAverage(),
                    const SizedBox(height: 16),
                    _buildRecommendation(),
                    const SizedBox(height: 16),
                    _buildSleepDetails(),
                    const SizedBox(height: 20),
                    _buildSleepHistory(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepTime() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF05576A), Color(0xFF0AACD0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.31, 1.0],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('7H 42M', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 10),
                Text('Tiempo total', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: const LinearProgressIndicator(
              value: 7 / 8,
              minHeight: 20,
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordAndAverage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard('🏆', 'Tu récord', '8H\n15M', '12 de enero'),
        _buildStatCard('📊', 'Promedio', '7H\n18M', 'Últimos 7 días'),
      ],
    );
  }

  Widget _buildStatCard(String icon, String title, String value, String subtitle) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRecommendation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.yellow[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: const [
          Icon(Icons.lightbulb_outline, color: Colors.orange),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Recomendación: Intenta acostarte 30 minutos antes para alcanzar tu meta de 8 horas',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDetailCard('🕒', 'Inicio', '23:14'),
        _buildDetailCard('⏰', 'Despertar', '07:02'),
        _buildDetailCard('💤', 'Eficiencia', '94%'),
      ],
    );
  }

  Widget _buildDetailCard(String icon, String label, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSleepHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text('Historial de sueño', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Hoy', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
              Text('7 h 42m', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
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
