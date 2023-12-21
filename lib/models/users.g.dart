// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersAdapter extends TypeAdapter<Users> {
  @override
  final int typeId = 3;

  @override
  Users read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Users(
      id: fields[0] as int,
      name: fields[1] as String,
      nik: fields[2] as String?,
      phone: fields[3] as String?,
      address: fields[4] as String?,
      email: fields[5] as String?,
      username: fields[6] as String,
      password: fields[7] as String?,
      villageId: fields[8] as dynamic,
      avatar: fields[9] as dynamic,
      status: fields[10] as int?,
      token: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Users obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nik)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.password)
      ..writeByte(8)
      ..write(obj.villageId)
      ..writeByte(9)
      ..write(obj.avatar)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: json['id'] as int,
      name: json['name'] as String,
      nik: json['nik'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String,
      password: json['password'] as String?,
      villageId: json['villageId'],
      avatar: json['avatar'],
      status: json['status'] as int?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nik': instance.nik,
      'phone': instance.phone,
      'address': instance.address,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'villageId': instance.villageId,
      'avatar': instance.avatar,
      'status': instance.status,
      'token': instance.token,
    };
