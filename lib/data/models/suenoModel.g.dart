// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suenoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SuenoAdapter extends TypeAdapter<Sueno> {
  @override
  final int typeId = 0;

  @override
  Sueno read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sueno(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sueno obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fecha)
      ..writeByte(1)
      ..write(obj.estrellas)
      ..writeByte(2)
      ..write(obj.duracion)
      ..writeByte(3)
      ..write(obj.horaInicio)
      ..writeByte(4)
      ..write(obj.horaFinal)
      ..writeByte(5)
      ..write(obj.eficiencia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuenoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
