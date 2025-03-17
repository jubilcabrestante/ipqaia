// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_creation_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountVm _$AccountVmFromJson(Map<String, dynamic> json) => AccountVm(
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$AccountVmToJson(AccountVm instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'gender': instance.gender,
      'age': instance.age,
    };
