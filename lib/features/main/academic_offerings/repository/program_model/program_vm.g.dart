// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramVm _$ProgramVmFromJson(Map<String, dynamic> json) => ProgramVm(
      id: json['id'] as String?,
      campus: json['campus'] as String,
      cluster: json['cluster'] as String,
      college: json['college'] as String?,
      program: json['program'] as String,
      major: json['major'] as String?,
    );

Map<String, dynamic> _$ProgramVmToJson(ProgramVm instance) => <String, dynamic>{
      'id': instance.id,
      'campus': instance.campus,
      'cluster': instance.cluster,
      'college': instance.college,
      'program': instance.program,
      'major': instance.major,
    };
