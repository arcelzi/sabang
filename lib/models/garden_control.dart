import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'garden_control.g.dart';

List<GardenControl> gardenControlFromJson(String str) => List<GardenControl>.from(json.decode(str).map((x) => GardenControl.fromJson(x)));

String gardenControlToJson(List<GardenControl> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GardenControl {
    @JsonKey(name: "penyadapId")
    String? penyadapId;
    @JsonKey(name: "icsId")
    String? icsId;
    @JsonKey(name: "timestamp")
    DateTime? timestamp;
    @JsonKey(name: "lat")
    num? lat;
    @JsonKey(name: "lng")
    num? lng;
    @JsonKey(name: "id")
    int? id;

    GardenControl({
        this.penyadapId,
        this.icsId,
        this.timestamp,
        this.lat,
        this.lng,
        this.id,
    });

    factory GardenControl.fromJson(Map<String, dynamic> json) => _$GardenControlFromJson(json);

    Map<String, dynamic> toJson() => _$GardenControlToJson(this);
}