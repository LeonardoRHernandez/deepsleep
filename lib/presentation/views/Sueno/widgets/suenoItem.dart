import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/controllers/Sleepcontroller/historialSueno.dart';
import 'package:provider/provider.dart';
import 'package:deepsleep/presentation/controllers/procesarDatos.dart';
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
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
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
    var Lissuenos = Provider.of<RitmoCardiacoProvider>(context).listsueno;
    final List<Map<String, dynamic>> suenos = Lissuenos.historialSueno;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: suenos.length,
      itemBuilder: (context, index) {
        final sueno = suenos[suenos.length - 1 - index];
        return Column(
          children: [
            BuildsuenoItem(
              data: sueno['data'],
              cantidadEstrellas: sueno['cantidadEstrellas'],
              data2: sueno['data2'],
            ),
            const SizedBox(height: 6),
          ],
        );
      },
    );
  }
}