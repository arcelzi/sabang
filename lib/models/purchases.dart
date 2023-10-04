import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'purchases.g.dart';

List<Purchases> purchasesFromJson(String str) => List<Purchases>.from(json.decode(str).map((x) => Purchases.fromJson(x)));

String purchasesToJson(List<Purchases> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Purchases {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "penyadapld")
    int? penyadapld;
    @JsonKey(name: "purchaserld")
    int? purchaserld;
    @JsonKey(name: "ph")
    num? ph;
    @JsonKey(name: "sugarLevel")
    num? sugarLevel;
    @JsonKey(name: "volume")
    num? volume;
    @JsonKey(name: "lat")
    num? lat;
    @JsonKey(name: "lng")
    num? lng;
    @JsonKey(name: "amount")
    num? amount;
    @JsonKey(name: "timestamp")
    DateTime? timestamp;
    @JsonKey(name: "paidAt")
    DateTime? paidAt;
    @JsonKey(name: "checkedAt")
    DateTime? checkedAt;
    @JsonKey(name: "auditedAt")
    DateTime? auditedAt;

    Purchases({
        this.id,
        this.penyadapld,
        this.purchaserld,
        this.ph,
        this.sugarLevel,
        this.volume,
        this.lat,
        this.lng,
        this.amount,
        this.timestamp,
        this.paidAt,
        this.checkedAt,
        this.auditedAt,
    });

    factory Purchases.fromJson(Map<String, dynamic> json) => _$PurchasesFromJson(json);

    Map<String, dynamic> toJson() => _$PurchasesToJson(this);
}
