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

  return Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          // Encabezado mejorado
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.shade700,
                  Colors.deepPurple.shade400,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white10,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Perfil",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 3,
                  width: 60,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),
          
          // Resto del contenido (igual que antes)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(25),
              children: [
                _buildTarjetaDato("Peso", "$_peso kg", Icons.monitor_weight, Colors.orange),
                _buildTarjetaDato("Estatura", "$_estatura cm", Icons.height, Colors.green),
                _buildTarjetaDato("Edad", "$_edad años", Icons.cake, Colors.blue),

                const SizedBox(height: 20),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: _editarDatos,
      icon: const Icon(Icons.edit, color: Colors.white),
      label: const Text("Editar datos", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.deepPurple,
    ),
  );
}

  Widget _buildTarjetaDato(String titulo, String valor, IconData icono, Color color) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icono, color: color),
        ),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(valor, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}