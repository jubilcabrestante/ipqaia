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
      major: json['major'] as String?,
      ethnicGroup: json['ethnicGroup'] as String?,
      financialAssistance: json['financialAssistance'] as String?,
      pwd: json['pwd'] as String?,
    );

Map<String, dynamic> _$StudentProfileVmToJson(StudentProfileVm instance) =>
    <String, dynamic>{
      'cluster': instance.cluster,
      'campus': instance.campus,
      'program': instance.program,
      'major': instance.major,
      'studentId': instance.studentId,
      'yearEnrolled': instance.yearEnrolled,
      'ethnicGroup': instance.ethnicGroup,
      'financialAssistance': instance.financialAssistance,
      'pwd': instance.pwd,
    };
