// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfiguracionAdapter extends TypeAdapter<Configuracion> {
  @override
  final int typeId = 1;

  @override
  Configuracion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Configuracion(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Configuracion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.altura)
      ..writeByte(2)
      ..write(obj.edad)
      ..writeByte(3)
      ..write(obj.sexo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfiguracionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
