class SensorData {
  final DateTime timestamp;
  final int heartRate;
  final double accelX;
  final double accelY;
  final double accelZ;
  final int steps;

  SensorData({
    required this.timestamp,
    required this.heartRate,
    required this.accelX,
    required this.accelY,
    required this.accelZ,
    required this.steps,
  });
}
