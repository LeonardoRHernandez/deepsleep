import 'package:flutter/material.dart';
import 'package:deepsleep/presentation/views/Sueno/widgets/suenoItem.dart';
class BuildSleepHistory extends StatelessWidget {
  const BuildSleepHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text('Historial de sueño', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        BuildListaSueno()
      ],
    );
  }
}
