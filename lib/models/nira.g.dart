// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nira.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nira _$NiraFromJson(Map<String, dynamic> json) => Nira(
      id: json['id'] as int?,
      penyadapld: json['penyadapld'] as int?,
      purchaserld: json['purchaserld'] as int?,
      ph: json['ph'] as num?,
      sugarLevel: json['sugarLevel'] as num?,
      volume: json['volume'] as num?,
      lat: json['lat'] as num?,
      lng: json['lng'] as num?,
      amount: json['amount'] as num?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      checkedAt: json['checkedAt'] == null
          ? null
          : DateTime.parse(json['checkedAt'] as String),
      auditedAt: json['auditedAt'] == null
          ? null
          : DateTime.parse(json['auditedAt'] as String),
    );

Map<String, dynamic> _$NiraToJson(Nira instance) => <String, dynamic>{
      'id': instance.id,
      'penyadapld': instance.penyadapld,
      'purchaserld': instance.purchaserld,
      'ph': instance.ph,
      'sugarLevel': instance.sugarLevel,
      'volume': instance.volume,
      'lat': instance.lat,
      'lng': instance.lng,
      'amount': instance.amount,
      'timestamp': instance.timestamp.toIso8601String(),
      'paidAt': instance.paidAt?.toIso8601String(),
      'checkedAt': instance.checkedAt?.toIso8601String(),
      'auditedAt': instance.auditedAt?.toIso8601String(),
    };
