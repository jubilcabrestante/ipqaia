// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      uid: json['uid'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'role': instance.role,
      'createdAt': instance.createdAt,
    };
