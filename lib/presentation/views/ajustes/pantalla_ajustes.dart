import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaAjustes extends StatefulWidget {
  final VoidCallback desbloquearPantallas;

  const PantallaAjustes({Key? key, required this.desbloquearPantallas}) : super(key: key);

  @override
  State<PantallaAjustes> createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _estaturaController = TextEditingController();
  final _edadController = TextEditingController();

  bool _formularioCompletado = false;
  String _peso = "", _estatura = "", _edad = "";

  @override
  void initState() {
    super.initState();
    _verificarFormulario();
  }

  Future<void> _verificarFormulario() async {
    final prefs = await SharedPreferences.getInstance();
    final completado = prefs.getBool('formularioCompletado') ?? false;

    if (!completado) {
      _mostrarFormularioInicial();
    } else {
      setState(() {
        _formularioCompletado = true;
        _peso = prefs.getString('peso') ?? '';
        _estatura = prefs.getString('estatura') ?? '';
        _edad = prefs.getString('edad') ?? '';
      });
    }
  }

  void _mostrarFormularioInicial() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text('Configuración Inicial'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _pesoController,
                    decoration: InputDecoration(labelText: 'Peso (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Ingrese su peso' : null,
                  ),
                  TextFormField(
                    controller: _estaturaController,
                    decoration: InputDecoration(labelText: 'Estatura (cm)'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Ingrese su estatura' : null,
                  ),
                  TextFormField(
                    controller: _edadController,
                    decoration: InputDecoration(labelText: 'Edad'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Ingrese su edad' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Guardar y Continuar'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final prefs = await SharedPreferences.getInstance();

                  await prefs.setBool('formularioCompletado', true);
                  await prefs.setString('peso', _pesoController.text);
                  await prefs.setString('estatura', _estaturaController.text);
                  await prefs.setString('edad', _edadController.text);

                  setState(() {
                    _formularioCompletado = true;
                    _peso = _pesoController.text;
                    _estatura = _estaturaController.text;
                    _edad = _edadController.text;
                  });

                  widget.desbloquearPantallas();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_formularioCompletado) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Peso: $_peso kg", style: TextStyle(fontSize: 18)),
          Text("Estatura: $_estatura cm", style: TextStyle(fontSize: 18)),
          Text("Edad: $_edad años", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Bluetooth no implementado aún")),
              );
            },
            icon: Icon(Icons.bluetooth),
            label: Text("Bluetooth"),
          ),
        ],
      ),
    );
  }
}
