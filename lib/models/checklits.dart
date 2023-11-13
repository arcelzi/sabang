import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'checklits.g.dart';

List<Check> checkFromJson(String str) => List<Check>.from(json.decode(str).map((x) => Check.fromJson));

String checkToJson(List<Check> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Check {
  int id;
  String title;
  String type;

  Check({
    required this.id,
    required this.title,
    required this.type
  });

  factory Check.fromJson(Map<String, dynamic> json) => _$CheckFromJson(json);

  Map<String, dynamic> toJson() => _$CheckToJson(this);
}