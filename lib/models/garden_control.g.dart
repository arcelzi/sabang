// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_control.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GardenControl _$GardenControlFromJson(Map<String, dynamic> json) =>
    GardenControl(
      penyadapId: json['penyadapId'] as String?,
      icsId: json['icsId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      lat: json['lat'] as num?,
      lng: json['lng'] as num?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$GardenControlToJson(GardenControl instance) =>
    <String, dynamic>{
      'penyadapId': instance.penyadapId,
      'icsId': instance.icsId,
      'timestamp': instance.timestamp?.toIso8601String(),
      'lat': instance.lat,
      'lng': instance.lng,
      'id': instance.id,
    };
