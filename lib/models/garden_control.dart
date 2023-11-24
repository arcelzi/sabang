import 'package:json_annotation/json_annotation.dart';


part 'garden_control.g.dart';


@JsonSerializable(explicitToJson: true)
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
    String value;
    String type;

    GardenControlItems({
      required this.id,
      required this.title,
      required this.value,
      required this.type
    });
    
    factory GardenControlItems.fromJson(Map<String, dynamic> json) => _$GardenControlItemsFromJson(json);

    Map<String, dynamic> toJson() => _$GardenControlItemsToJson(this);
}