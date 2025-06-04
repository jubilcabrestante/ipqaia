// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentProfileVm _$StudentProfileVmFromJson(Map<String, dynamic> json) =>
    StudentProfileVm(
      studentId: json['studentId'] as String,
      yearEnrolled: json['yearEnrolled'] as String,
      cluster: json['cluster'] as String,
      campus: json['campus'] as String,
      program: json['program'] as String,
      citizenship: json['citizenship'] as String,
      ethnicGroup: json['ethnicGroup'] as bool?,
      major: json['major'] as String?,
      yearGraduate: json['yearGraduate'] as String?,
      financialAssistance: json['financialAssistance'] as String?,
      pwd: json['pwd'] as bool?,
    );

Map<String, dynamic> _$StudentProfileVmToJson(StudentProfileVm instance) =>
    <String, dynamic>{
      'cluster': instance.cluster,
      'campus': instance.campus,
      'program': instance.program,
      'major': instance.major,
      'studentId': instance.studentId,
      'yearEnrolled': instance.yearEnrolled,
      'yearGraduate': instance.yearGraduate,
      'citizenship': instance.citizenship,
      'financialAssistance': instance.financialAssistance,
      'ethnicGroup': instance.ethnicGroup,
      'pwd': instance.pwd,
    };
