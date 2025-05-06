import 'package:flutter/material.dart';

class FormularioAjustes extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController pesoController;
  final TextEditingController estaturaController;
  final TextEditingController edadController;
  final String? generoInicial;
  final void Function(String genero) onGuardar;

  const FormularioAjustes({
    super.key,
    required this.formKey,
    required this.pesoController,
    required this.estaturaController,
    required this.edadController,
    this.generoInicial,
    required this.onGuardar,
  });

  @override
  State<FormularioAjustes> createState() => _FormularioAjustesState();
}

class _FormularioAjustesState extends State<FormularioAjustes> {
  String? _genero;

  @override
  void initState() {
    super.initState();
    _genero = widget.generoInicial;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Configuración Inicial'),
      content: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: widget.pesoController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese su peso' : null,
              ),
              TextFormField(
                controller: widget.estaturaController,
                decoration: const InputDecoration(labelText: 'Estatura (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese su estatura' : null,
              ),
              TextFormField(
                controller: widget.edadController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese su edad' : null,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Género',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('Masculino'),
                          selected: _genero == 'Masculino',
                          onSelected: (selected) {
                            setState(() {
                              _genero = selected ? 'Masculino' : null;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('Femenino'),
                          selected: _genero == 'Femenino',
                          onSelected: (selected) {
                            setState(() {
                              _genero = selected ? 'Femenino' : null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.formKey.currentState!.validate() && _genero != null) {
              widget.onGuardar(_genero!);
              Navigator.of(context).pop();
            } else if (_genero == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Seleccione su género')),
              );
            }
          },
          child: const Text('Guardar y Continuar'),
        ),
      ],
    );
  }
}