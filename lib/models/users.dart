// To parse this JSON data, do
//
//     final dropdownmodel = dropdownmodelFromJson(jsonString);

import 'dart:convert';

List<Dropdownmodel> dropdownmodelFromJson(String str) => List<Dropdownmodel>.from(json.decode(str).map((x) => Dropdownmodel.fromJson(x)));

String dropdownmodelToJson(List<Dropdownmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dropdownmodel {
    int? id;
    String? name;
    String? nik;
    String? phone;
    String? address;
    String? email;
    String? username;
    String? password;
    dynamic villageId;
    dynamic avatar;
    int? status;

    Dropdownmodel({
        this.id,
        this.name,
        this.nik,
        this.phone,
        this.address,
        this.email,
        this.username,
        this.password,
        this.villageId,
        this.avatar,
        this.status,
    });

    factory Dropdownmodel.fromJson(Map<String, dynamic> json) => Dropdownmodel(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        phone: json["phone"],
        address: json["address"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        villageId: json["villageId"],
        avatar: json["avatar"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "phone": phone,
        "address": address,
        "email": email,
        "username": username,
        "password": password,
        "villageId": villageId,
        "avatar": avatar,
        "status": status,
    };
}
