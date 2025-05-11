import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotoBluetooh extends StatefulWidget {
  const BotoBluetooh({super.key});

  @override
  State<BotoBluetooh> createState() => BotoBluetoohState();
}

class BotoBluetoohState extends State<BotoBluetooh> {
  String bluetooth = "Bluetooth no implementado aún";
  bool _isProcessing = false;

  Future<void> accion(int estado) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    switch (estado) {
      case 0:
        bluetooth = "Escaneando dispositivos";
        break;
      case 1:
        bluetooth = "Conectado";
        break;
      case 2:
        bluetooth = "Error de conexión";
        break;
      case 3:
        bluetooth = "Bluetooth desconectado";
        break;
      default:
        bluetooth = "Bluetooth no implementado aún";
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(bluetooth)));

    await Future.delayed(const Duration(seconds: 5));
    setState(() => _isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controllers>(
      builder: (context, provider, _) {
        return ElevatedButton.icon(
          onPressed:
              _isProcessing
                  ? null
                  : () {
                    accion(provider.estado);
                  },
          icon: const Icon(Icons.bluetooth),
          label: Text(_isProcessing ? "Procesando..." : "Bluetooth"),
          style: ElevatedButton.styleFrom(
            backgroundColor: _isProcessing ? Colors.grey : Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      },
    );
  }
}
