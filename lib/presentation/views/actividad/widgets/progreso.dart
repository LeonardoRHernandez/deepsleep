import 'package:flutter/material.dart';
class ProgresoWidget extends StatefulWidget {
  const ProgresoWidget({super.key});

  @override
  State<ProgresoWidget> createState() => _ProgresoWidgetState();
}

class _ProgresoWidgetState extends State<ProgresoWidget> {
  bool _esSemanal = true; // Ahora es mutable

  @override
  Widget build(BuildContext context) {
    String titulo = _esSemanal ? "Progreso Semanal" : "Progreso Mensual";
    double valor = _esSemanal ? 8.5 / 10 : 32.0 / 40;
    String texto = _esSemanal ? "8.5h / 10h" : "32h / 40h";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _esSemanal = !_esSemanal; // Modifica el estado interno
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.swap_horiz, size: 18, color: Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: valor,
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Text(
                texto,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
//   Widget _buildProgreso(bool esSemanal) {
//     //final bool _esSemanal = true;
//     String titulo = esSemanal ? "Progreso Semanal" : "Progreso Mensual";
//     double valor = esSemanal ? 8.5 / 10 : 32.0 / 40;
//     String texto = esSemanal ? "8.5h / 10h" : "32h / 40h";

//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 esSemanal = !esSemanal;
//               });
//             },
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   titulo,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[800],
//                   ),
//                 ),
//                 SizedBox(width: 6),
//                 Icon(Icons.swap_horiz, size: 18, color: Colors.blue),
//               ],
//             ),
//           ),
//           SizedBox(height: 8),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: LinearProgressIndicator(
//                   value: valor,
//                   minHeight: 20,
//                   backgroundColor: Colors.grey[300],
//                   valueColor:AlwaysStoppedAnimation<Color>(Colors.green),
//                 ),
//               ),
//               Text(
//                 texto,
//                 style:TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
