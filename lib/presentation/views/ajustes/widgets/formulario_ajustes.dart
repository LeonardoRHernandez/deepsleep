import 'package:flutter/material.dart';

class FormularioAjustes extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController pesoController;
  final TextEditingController estaturaController;
  final TextEditingController edadController;
  final VoidCallback onGuardar;

  const FormularioAjustes({
    super.key,
    required this.formKey,
    required this.pesoController,
    required this.estaturaController,
    required this.edadController,
    required this.onGuardar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Configuración Inicial'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: pesoController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => 
                  value == null || value.isEmpty ? 'Ingrese su peso' : null,
              ),
              TextFormField(
                controller: estaturaController,
                decoration: const InputDecoration(labelText: 'Estatura (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) => 
                  value == null || value.isEmpty ? 'Ingrese su estatura' : null,
              ),
              TextFormField(
                controller: edadController,
                decoration: const InputDecoration(labelText: 'Edad'),
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
          onPressed: onGuardar,
          child: const Text('Guardar y Continuar'),
        ),
      ],
    );
  }
}