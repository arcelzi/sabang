// import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';


part 'garden_control.g.dart';


@JsonSerializable(explicitToJson: true)
class GardenControl {
    @JsonKey(name: "penyadapId")
    num? penyadapId;
    @JsonKey(name: "icsId")
    num? icsId;
    @JsonKey(name: "timestamp")
    DateTime? timestamp;
    @JsonKey(name: "lat")
    num? lat;
    @JsonKey(name: "lng")
    num? lng;
    @JsonKey(name: "id")
    int? id;
    final List<GardenControlItems> items;
    

    GardenControl({
        this.penyadapId,
        this.icsId,
        this.timestamp,
        this.lat,
        this.lng,
        this.id,
        required this.items
    });

    factory GardenControl.fromJson(Map<String, dynamic> json) => _$GardenControlFromJson(json);

    Map<String, dynamic> toJson() => _$GardenControlToJson(this);
}





@JsonSerializable()
class GardenControlItems {
    int id;
    String title;
    String? value;
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