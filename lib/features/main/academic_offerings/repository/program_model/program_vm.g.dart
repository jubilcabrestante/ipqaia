// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

College _$CollegeFromJson(Map<String, dynamic> json) => College(
      collegeName: json['collegeName'] as String,
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollegeToJson(College instance) => <String, dynamic>{
      'collegeName': instance.collegeName,
      'programs': instance.programs,
    };

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
      programName: json['programName'] as String,
      majors: (json['majors'] as List<dynamic>?)
          ?.map((e) => Major.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'programName': instance.programName,
      'majors': instance.majors,
    };

Major _$MajorFromJson(Map<String, dynamic> json) => Major(
      majorName: json['majorName'] as String,
    );

Map<String, dynamic> _$MajorToJson(Major instance) => <String, dynamic>{
      'majorName': instance.majorName,
    };
