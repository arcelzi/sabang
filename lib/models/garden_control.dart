// import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'garden_control.g.dart';


@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class GardenControl {
    @JsonKey(name: "penyadapId")
    @HiveField(0)
    num? penyadapId;
    @JsonKey(name: "icsId")
    @HiveField(1)
    num? icsId;
    @JsonKey(name: "timestamp")
    @HiveField(2)
    DateTime timestamp;
    @JsonKey(name: "lat")
    @HiveField(3)
    num? lat;
    @JsonKey(name: "lng")
    @HiveField(4)
    num? lng;
    @JsonKey(name: "id")
    @HiveField(5)
    int? id;
    @HiveField(6)
    final List<GardenControlItems> items;
    

    GardenControl({
        this.penyadapId,
        this.icsId,
        required this.timestamp,
        this.lat,
        this.lng,
        this.id,
        required this.items
    });

    factory GardenControl.fromJson(Map<String, dynamic> json) => _$GardenControlFromJson(json);

    Map<String, dynamic> toJson() => _$GardenControlToJson(this);

   
}





@JsonSerializable()
@HiveType(typeId: 2)
class GardenControlItems {
    @HiveField(0)
    int id;
    @HiveField(1)
    String title;
    @HiveField(2)
    String? value;
    @HiveField(3)
    String type;
    

    GardenControlItems({
      required this.id,
      required this.title,
      this.value,
      required this.type,
      
    });
    
    factory GardenControlItems.fromJson(Map<String, dynamic> json) => _$GardenControlItemsFromJson(json);

    Map<String, dynamic> toJson() => _$GardenControlItemsToJson(this);
}