// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      id: json['id'] as int?,
      name: json['name'] as String,
      nik: json['nik'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      villageId: json['villageId'],
      avatar: json['avatar'],
      status: json['status'] as int?,
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nik': instance.nik,
      'phone': instance.phone,
      'address': instance.address,
      'email': instance.email,
      'username': instance.username,
      'villageId': instance.villageId,
      'avatar': instance.avatar,
      'status': instance.status,
      'token': instance.token,
    };
