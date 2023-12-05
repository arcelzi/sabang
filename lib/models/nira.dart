import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'nira.g.dart';

List<Nira> niraFromJson(String str) => List<Nira>.from(json.decode(str).map((x) => Nira.fromJson(x)));

String niraToJson(List<Nira> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Nira {
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
    DateTime timestamp;
    @JsonKey(name: "paidAt")
    DateTime? paidAt;
    @JsonKey(name: "checkedAt")
    DateTime? checkedAt;
    @JsonKey(name: "auditedAt")
    DateTime? auditedAt;

    Nira({
        this.id,
        this.penyadapld,
        this.purchaserld,
        this.ph,
        this.sugarLevel,
        this.volume,
        this.lat,
        this.lng,
        this.amount,
        required this.timestamp,
        this.paidAt,
        this.checkedAt,
        this.auditedAt,
    });

    factory Nira.fromJson(Map<String, dynamic> json) => _$NiraFromJson(json);

    Map<String, dynamic> toJson() => _$NiraToJson(this);
}

  
