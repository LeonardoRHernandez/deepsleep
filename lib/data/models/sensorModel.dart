enum UserActivity {
  resting,
  walking,
  exercising,
}
class ActivitySession {
  final UserActivity activity;
  final DateTime startTime;
  final DateTime endTime;
  final double averageHeartRate;

  ActivitySession({
    required this.activity,
    required this.startTime,
    required this.endTime,
    required this.averageHeartRate,
  });

  Duration get duration => endTime.difference(startTime);

  @override
  String toString() {
    return "$activity | ${duration.inSeconds}s | HR: ${averageHeartRate.toStringAsFixed(1)}";
  }
}
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

