import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaAjustes extends StatefulWidget {
  final void Function({bool redirigirASueno}) desbloquearPantallas;

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

      // Llamar al callback en el siguiente frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.desbloquearPantallas(redirigirASueno: false);
    });
    }
  }

  void _mostrarFormularioInicial() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Configuración Inicial'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _pesoController,
                    decoration: const InputDecoration(labelText: 'Peso (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty ? 'Ingrese su peso' : null,
                  ),
                  TextFormField(
                    controller: _estaturaController,
                    decoration: const InputDecoration(labelText: 'Estatura (cm)'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty ? 'Ingrese su estatura' : null,
                  ),
                  TextFormField(
                    controller: _edadController,
                    decoration: const InputDecoration(labelText: 'Edad'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty ? 'Ingrese su edad' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
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
              child: const Text('Guardar y Continuar'),
            ),
          ],
        );
      },
    );
  }

  void _editarDatos() {
    _pesoController.text = _peso;
    _estaturaController.text = _estatura;
    _edadController.text = _edad;
    _mostrarFormularioInicial();
  }

  @override
  Widget build(BuildContext context) {
    if (!_formularioCompletado) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mis datos", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    _buildDato("Peso", "$_peso kg"),
                    _buildDato("Estatura", "$_estatura cm"),
                    _buildDato("Edad", "$_edad años"),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _editarDatos,
                      icon: const Icon(Icons.edit),
                      label: const Text("Editar datos"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Bluetooth no implementado aún")),
                );
              },
              icon: const Icon(Icons.bluetooth),
              label: const Text("Bluetooth"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDato(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text("$titulo: ",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(valor, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}