import 'package:json_annotation/json_annotation.dart';

part 'nira.g.dart';

@JsonSerializable()
class Nira {
    final int id;
  final double ph;
  final double sugarlevel;
  final double volume;

  Nira({
     required this.id,
     required this.ph,
      required this.sugarlevel,
      required this.volume});
  factory Nira.fromJson(Map<String, dynamic> json) =>_$NiraFromJson(json);
  Map<String, dynamic> toJson() => _$NiraToJson(this);

}
  
  
