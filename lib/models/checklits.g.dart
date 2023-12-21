// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklits.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckAdapter extends TypeAdapter<Check> {
  @override
  final int typeId = 4;

  @override
  Check read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Check(
      id: fields[0] as int,
      title: fields[1] as String,
      type: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Check obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Check _$CheckFromJson(Map<String, dynamic> json) => Check(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$CheckToJson(Check instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
    };
