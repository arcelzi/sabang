// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nira.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nira _$NiraFromJson(Map<String, dynamic> json) => Nira(
      id: json['id'] as int,
      ph: (json['ph'] as num).toDouble(),
      sugarlevel: (json['sugarlevel'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
    );

Map<String, dynamic> _$NiraToJson(Nira instance) => <String, dynamic>{
      'id': instance.id,
      'ph': instance.ph,
      'sugarlevel': instance.sugarlevel,
      'volume': instance.volume,
    };
