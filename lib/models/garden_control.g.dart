// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_control.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GardenControlAdapter extends TypeAdapter<GardenControl> {
  @override
  final int typeId = 1;

  @override
  GardenControl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GardenControl(
      penyadapId: fields[0] as num?,
      icsId: fields[1] as num?,
      timestamp: fields[2] as DateTime,
      lat: fields[3] as num?,
      lng: fields[4] as num?,
      id: fields[5] as int?,
      items: (fields[6] as List).cast<GardenControlItems>(),
    );
  }

  @override
  void write(BinaryWriter writer, GardenControl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.penyadapId)
      ..writeByte(1)
      ..write(obj.icsId)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.lat)
      ..writeByte(4)
      ..write(obj.lng)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GardenControlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GardenControlItemsAdapter extends TypeAdapter<GardenControlItems> {
  @override
  final int typeId = 2;

  @override
  GardenControlItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GardenControlItems(
      id: fields[0] as int,
      title: fields[1] as String,
      value: fields[2] as String?,
      type: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GardenControlItems obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GardenControlItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GardenControl _$GardenControlFromJson(Map<String, dynamic> json) =>
    GardenControl(
      penyadapId: json['penyadapId'] as num?,
      icsId: json['icsId'] as num?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      lat: json['lat'] as num?,
      lng: json['lng'] as num?,
      id: json['id'] as int?,
      items: (json['items'] as List<dynamic>)
          .map((e) => GardenControlItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GardenControlToJson(GardenControl instance) =>
    <String, dynamic>{
      'penyadapId': instance.penyadapId,
      'icsId': instance.icsId,
      'timestamp': instance.timestamp.toIso8601String(),
      'lat': instance.lat,
      'lng': instance.lng,
      'id': instance.id,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

GardenControlItems _$GardenControlItemsFromJson(Map<String, dynamic> json) =>
    GardenControlItems(
      id: json['id'] as int,
      title: json['title'] as String,
      value: json['value'] as String?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$GardenControlItemsToJson(GardenControlItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'value': instance.value,
      'type': instance.type,
    };
