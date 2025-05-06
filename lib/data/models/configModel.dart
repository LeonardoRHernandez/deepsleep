import 'package:hive/hive.dart';
part 'configModel.g.dart';

@HiveType(typeId: 1)
class Configuracion {
  @HiveField(0)
  int peso;
  @HiveField(1)
  int altura;
  @HiveField(2)
  int edad;
  @HiveField(3)
  String sexo;

  Configuracion(this.peso, this.altura, this.edad, this.sexo);
  Configuracion.empty() : peso = 0, altura = 0, edad = 0, sexo = "";
}
