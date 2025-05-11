// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVm _$UserVmFromJson(Map<String, dynamic> json) => UserVm(
      uid: json['uid'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$UserVmToJson(UserVm instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'role': instance.role,
      'createdAt': instance.createdAt,
    };
