// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kuisoner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KuisionerAdapter extends TypeAdapter<Kuisioner> {
  @override
  final int typeId = 5;

  @override
  Kuisioner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kuisioner(
      question: fields[0] as Check,
      value: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Kuisioner obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KuisionerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
