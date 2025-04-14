import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

void main() {
  runApp(SleepApp());
}

class SleepApp extends StatelessWidget {
  const SleepApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Si quieres que sea transparente
        statusBarIconBrightness: Brightness.dark, // Establece los iconos de la barra de estado a oscuro
      ),
    );
    return MaterialApp(
      title: 'Mi Sueño',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SleepScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});
  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  int selectedIndex = 0; // 0 = Sueño, 1 = Ejercicio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildToggleNavigation(),
            _buildTitleAndNotification(),
            const Divider(height: 1),
            Expanded(
              child: selectedIndex == 0 ? _buildSleepTab() : _buildExerciseTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleNavigation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildTabButton("Sueño", 0),
          _buildTabButton("Ejercicio", 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndNotification() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    color: Color(0xFF05576A), // Fondo azul oscuro como el del degradado
    child: Row(
      children: [
        const Expanded(
          child: Text(
            'Mi Sueño',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Texto blanco para contraste
            ),
          ),
        ),
        Icon(Icons.notifications, color: Colors.white),
      ],
    ),
  );
  
}

  Widget _buildSleepTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 12),
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
    );
  }

  Widget _buildExerciseTab() {
    return Center(
      child: Text(
        'Sección de Ejercicio (por agregar)',
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildSleepTime() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF05576A),
          Color(0xFF0AACD0),
        ],
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
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '7H 42M',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tiempo total',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: LinearProgressIndicator(
            value: 7 / 8,
            minHeight: 20, // Aumenta si quieres un efecto más visible
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
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
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
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(12),
      ),
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
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),

        ],
      ),
    );
  }

  Widget _buildSleepHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding( // Padding para separar el texto del recuadro
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0), // Ajusta el padding según sea necesario
          child: Text('Historial de sueño', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Container( // Recuadro para el contenido del historial
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Hoy',style:  TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
              Text('7 h 42m',style: TextStyle(color: Colors.grey), 
              )
            ],
          ),
        ),
      ],
    );
  }
}
