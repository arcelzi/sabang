import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'auth.g.dart';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

@JsonSerializable()
class Auth {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "nik")
    String? nik;
    @JsonKey(name: "phone")
    String? phone;
    @JsonKey(name: "address")
    String? address;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "username")
    String? username;
    @JsonKey(name: "villageId")
    dynamic villageId;
    @JsonKey(name: "avatar")
    dynamic avatar;
    @JsonKey(name: "status")
    int? status;
    @JsonKey(name: "token")
    String token;

    Auth({
        this.id,
        this.name,
        this.nik,
        this.phone,
        this.address,
        this.email,
        this.username,
        this.villageId,
        this.avatar,
        this.status,
        required this.token,
    });

    factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

    Map<String, dynamic> toJson() => _$AuthToJson(this);
}
