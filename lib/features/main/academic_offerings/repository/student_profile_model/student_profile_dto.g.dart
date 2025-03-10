// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentProfileDto _$StudentProfileDtoFromJson(Map<String, dynamic> json) =>
    StudentProfileDto(
      uid: json['uid'] as String,
      name: json['name'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
      courseAndProgram: json['courseAndProgram'] as String,
      yearLevel: json['yearLevel'] as String,
      ethnicGroup: json['ethnicGroup'] as String?,
      financialAssistance: json['financialAssistance'] as String?,
      pwd: json['pwd'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$StudentProfileDtoToJson(StudentProfileDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'courseAndProgram': instance.courseAndProgram,
      'yearLevel': instance.yearLevel,
      'ethnicGroup': instance.ethnicGroup,
      'financialAssistance': instance.financialAssistance,
      'pwd': instance.pwd,
      'createdAt': instance.createdAt,
    };
