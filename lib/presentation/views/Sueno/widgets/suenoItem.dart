import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:deepsleep/data/models/suenoModel.dart';

class BuildsuenoItem extends StatelessWidget {
  const BuildsuenoItem({
    super.key,
    required this.data,
    required this.cantidadEstrellas,
    required this.data2,
  });

  final String data;
  final int cantidadEstrellas;
  final String data2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data, style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: List.generate(
              cantidadEstrellas,
              (index) => const Icon(Icons.star, color: Colors.yellow),
            ),
          ),
          Text(data2, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class BuildListaSueno extends StatelessWidget {
  const BuildListaSueno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box<Sueno>(
            'suenoBox',
          ).listenable(), // Escucha cambios en la caja
      builder: (context, Box<Sueno> box, _) {
        final suenos = box.values.toList();

        if (suenos.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("No hay sueños guardados aún."),
          );
        }

        return Column(
          children:
              suenos.reversed.map((sueno) {
                return Column(
                  children: [
                    BuildsuenoItem(
                      data: sueno.duracion,
                      cantidadEstrellas: sueno.estrellas,
                      data2: sueno.fecha,
                    ),
                    const SizedBox(height: 6),
                  ],
                );
              }).toList(),
        );
      },
    );
  }
}
