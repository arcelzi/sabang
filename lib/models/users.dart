// To parse this JSON data, do
//
//     final dropdownmodel = dropdownmodelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

List<Users> dropdownmodelFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String dropdownmodelToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
@HiveType(typeId : 3)
class Users {
    

    Users({
        required this.id,
        required this.name,
        this.nik,
        this.phone,
        this.address,
        this.email,
        required this.username,
        this.password,
        this.villageId,
        this.avatar,
        this.status,
        this.token
    });

    factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

    Map<String, dynamic> toJson() => _$UsersToJson(this);
    
    @HiveField(0)
    int id;

    @HiveField(1)
    String name;

    @HiveField(2)
    String? nik;

    @HiveField(3)
    String? phone;

    @HiveField(4)
    String? address;

    @HiveField(5)
    String? email;

    @HiveField(6)
    String username;

    @HiveField(7)
    String? password;

    @HiveField(8)
    dynamic villageId;

    @HiveField(9)
    dynamic avatar;

    @HiveField(10)
    int? status;

    @HiveField(11)
    String? token;
}


