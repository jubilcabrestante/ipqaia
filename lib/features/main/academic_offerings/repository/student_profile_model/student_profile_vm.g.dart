// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentProfileVm _$StudentProfileVmFromJson(Map<String, dynamic> json) =>
    StudentProfileVm(
      name: json['name'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
      courseAndProgram: json['courseAndProgram'] as String,
      yearLevel: json['yearLevel'] as String,
      ethnicGroup: json['ethnicGroup'] as String?,
      financialAssistance: json['financialAssistance'] as String?,
      pwd: json['pwd'] as String?,
    );

Map<String, dynamic> _$StudentProfileVmToJson(StudentProfileVm instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'courseAndProgram': instance.courseAndProgram,
      'yearLevel': instance.yearLevel,
      'ethnicGroup': instance.ethnicGroup,
      'financialAssistance': instance.financialAssistance,
      'pwd': instance.pwd,
    };
