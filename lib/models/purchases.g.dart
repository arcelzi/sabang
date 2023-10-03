// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Purchases _$PurchasesFromJson(Map<String, dynamic> json) => Purchases(
      id: json['id'] as int?,
      penyadapld: json['penyadapld'] as int?,
      purchaserld: json['purchaserld'] as int?,
      ph: json['ph'] as String?,
      sugarLevel: json['sugarLevel'] as String?,
      volume: json['volume'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      amount: json['amount'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
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

Map<String, dynamic> _$PurchasesToJson(Purchases instance) => <String, dynamic>{
      'id': instance.id,
      'penyadapld': instance.penyadapld,
      'purchaserld': instance.purchaserld,
      'ph': instance.ph,
      'sugarLevel': instance.sugarLevel,
      'volume': instance.volume,
      'lat': instance.lat,
      'lng': instance.lng,
      'amount': instance.amount,
      'timestamp': instance.timestamp?.toIso8601String(),
      'paidAt': instance.paidAt?.toIso8601String(),
      'checkedAt': instance.checkedAt?.toIso8601String(),
      'auditedAt': instance.auditedAt?.toIso8601String(),
    };
