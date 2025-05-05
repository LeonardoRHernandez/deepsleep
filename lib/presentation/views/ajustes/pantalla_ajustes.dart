import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deepsleep/presentation/views/ajustes/widgets/encabezado_ajustes.dart';
import 'package:deepsleep/presentation/views/ajustes/widgets/tarjeta_dato.dart';
import 'package:deepsleep/presentation/views/ajustes/widgets/formulario_ajustes.dart';

class PantallaAjustes extends StatefulWidget {
  final void Function({bool redirigirASueno}) desbloquearPantallas;

  const PantallaAjustes({
    Key? key,
    required this.desbloquearPantallas,
  }) : super(key: key);

  @override
  State<PantallaAjustes> createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _estaturaController = TextEditingController();
  final _edadController = TextEditingController();

  bool _formularioCompletado = false;
  String _peso = "", _estatura = "", _edad = "", _genero = "";

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
        _genero = prefs.getString('genero') ?? '';
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.desbloquearPantallas(redirigirASueno: false);
      });
    }
  }

  void _mostrarFormularioInicial() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FormularioAjustes(
        formKey: _formKey,
        pesoController: _pesoController,
        estaturaController: _estaturaController,
        edadController: _edadController,
        generoInicial: _genero.isNotEmpty ? _genero : null,
        onGuardar: (generoSeleccionado) {
          setState(() {
            _genero = generoSeleccionado;
          });
          _guardarDatos();
        },
      ),
    );
  }

  Future<void> _guardarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('formularioCompletado', true);
    await prefs.setString('peso', _pesoController.text);
    await prefs.setString('estatura', _estaturaController.text);
    await prefs.setString('edad', _edadController.text);
    await prefs.setString('genero', _genero);

    setState(() {
      _formularioCompletado = true;
      _peso = _pesoController.text;
      _estatura = _estaturaController.text;
      _edad = _edadController.text;
    });

    widget.desbloquearPantallas();
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
            const EncabezadoAjustes(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(25),
                children: [
                  TarjetaDato(
                    titulo: "Peso",
                    valor: "$_peso kg",
                    icono: Icons.monitor_weight,
                    color: Colors.orange,
                  ),
                  TarjetaDato(
                    titulo: "Estatura",
                    valor: "$_estatura cm",
                    icono: Icons.height,
                    color: Colors.green,
                  ),
                  TarjetaDato(
                    titulo: "Edad",
                    valor: "$_edad años",
                    icono: Icons.cake,
                    color: Colors.blue,
                  ),
                  TarjetaDato(
                    titulo: "Género",
                    valor: _genero,
                    icono: _genero == 'Masculino'
                        ? Icons.male
                        : Icons.female,
                    color: _genero == 'Masculino'
                        ? Colors.blue
                        : Colors.pink,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Bluetooth no implementado aún")),
                      );
                    },
                    icon: const Icon(Icons.bluetooth),
                    label: const Text("Bluetooth"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
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
        label: const Text("Editar datos",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}