import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/Controllers.dart';
import 'package:deepsleep/presentation/controllers/Sleepcontroller/ControlerSueno.dart';

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
  BuildListaSueno({super.key});
  //var exerciseList= ListaEjercicios().exerciseList;
  @override
  Widget build(BuildContext context) {
    // Lista de ejercicios
    var Lissuenos =
        Provider.of<Controllers>(context).listsueno; //lista de sueños
    final List<Sueno> suenos = Lissuenos.historialSueno;
    //final List<Map<String, dynamic>> suenosMap = Lissuenos.historialSueno;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: suenos.length,
      itemBuilder: (context, index) {
        final sueno =
            suenos[suenos.length -
                1 -
                index]; // Acceder al sueño en orden inverso
        return Column(
          children: [
            BuildsuenoItem(
              // data: sueno['data'],
              // cantidadEstrellas: sueno['cantidadEstrellas'],
              // data2: sueno['data2'],
              data: sueno.duracion,
              cantidadEstrellas: sueno.estrellas,
              data2: sueno.fecha,
            ),
            const SizedBox(height: 6),
          ],
        );
      },
    );
  }
}
