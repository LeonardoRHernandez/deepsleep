import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEService {
  final Guid serviceUuid = Guid("0000abcd-0000-1000-8000-00805f9b34fb");
  final Guid characteristicUuid = Guid("00001234-0000-1000-8000-00805f9b34fb");
  int _estado = 0 ;// 0: Escaneando, 1: Conectado, 2: Error, 3: Desconectado
  int get estado => _estado;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? notifyCharacteristic;

  Function(Map<String, dynamic>)? onDataReceived;
  bool isConnecting = false;

  void startScan({Function(Map<String, dynamic>)? onData}) {
    onDataReceived = onData;
    _tryConnect();
  }

  void _tryConnect() async {
    if (isConnecting) return;
    isConnecting = true;

    print("🔍 Iniciando escaneo BLE...");
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));

    FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult r in results) {
        print("📱 Dispositivo detectado: ${r.device.name} (${r.device.id})");
        print("🔍 UUIDs anunciados: ${r.advertisementData.serviceUuids}");

        // Comparación flexible con UUID "abcd"
        if (r.advertisementData.serviceUuids.any(
          (uuid) => uuid.toString().toLowerCase().contains("abcd"),
        )) {
          print("✅ Coincidencia encontrada, conectando a ${r.device.name}");
          await FlutterBluePlus.stopScan();
          connectedDevice = r.device;
          await _connectToDevice(connectedDevice!);
          isConnecting = false;
          _estado = 1;
          return;
        }
      }
    });

    // Si después de un tiempo no encuentra, volver a intentar
    await Future.delayed(const Duration(seconds: 12));
    if (connectedDevice == null) {
      print("❌ No se encontró el dispositivo. Reintentando...");
      isConnecting = false;
      _estado = 0;
      _tryConnect();
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          print("Dispositivo desconectado. Reintentando...");
          connectedDevice = null;
          _estado = 3;
          _tryConnect(); // reconecta
        }
      });

      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService s in services) {
        if (s.uuid == serviceUuid) {
          for (BluetoothCharacteristic c in s.characteristics) {
            if (c.uuid == characteristicUuid) {
              notifyCharacteristic = c;
              await c.setNotifyValue(true);

              c.value.listen((event) {
                try {
                  if (event.isEmpty) return; // Ignorar valores vacíos

                  final decoded = utf8.decode(Uint8List.fromList(event));
                  final data = jsonDecode(decoded);

                  if (data is Map<String, dynamic>) {
                    print("Datos recibidos: $data");
                    onDataReceived?.call(data);
                  } else {
                    //print("⚠️ Datos recibidos no son un Map: $data");
                  }
                } catch (e) {
                  //print("❗ Error al procesar datos BLE: $e");
                }
              });
            }
          }
        }
      }
    } catch (e) {
      print("Error al conectar con el dispositivo BLE: $e");
      connectedDevice = null;
      await Future.delayed(const Duration(seconds: 3));
      _estado = 2;
      _tryConnect(); // intenta reconectar
    }
  }

  Future<void> disconnect() async {
    await connectedDevice?.disconnect();
    connectedDevice = null;
  }
}
