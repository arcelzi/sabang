// To parse this JSON data, do
//
//     final dropdownmodel = dropdownmodelFromJson(jsonString);

import 'dart:convert';

List<Users> dropdownmodelFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String dropdownmodelToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    int? id;
    String name;
    String? nik;
    String? phone;
    String? address;
    String? email;
    String? username;
    String? password;
    dynamic villageId;
    dynamic avatar;
    int? status;
    String? token;

    Users({
        this.id,
        required this.name,
        this.nik,
        this.phone,
        this.address,
        this.email,
        this.username,
        this.password,
        this.villageId,
        this.avatar,
        this.status,
        this.token
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
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
        token: json["token"]
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
        "token": token
    };
}
