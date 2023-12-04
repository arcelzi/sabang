// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_control.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GardenControl _$GardenControlFromJson(Map<String, dynamic> json) =>
    GardenControl(
      penyadapId: json['penyadapId'] as num?,
      icsId: json['icsId'] as num?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
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
      'timestamp': instance.timestamp?.toIso8601String(),
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
