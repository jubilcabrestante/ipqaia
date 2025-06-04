// program_vm.dart
import 'package:json_annotation/json_annotation.dart';

part 'program_vm.g.dart';

class ProgramVm {
  final String? id;
  final String cluster;
  final List<Campus> campuses;

  ProgramVm({
    this.id,
    required this.cluster,
    List<Campus>? campuses,
  }) : campuses = campuses ?? [];
}

class Campus {
  final String campusName;
  final List<College> colleges;

  Campus({
    required this.campusName,
    List<College>? colleges,
  }) : colleges = colleges ?? [];
}

@JsonSerializable()
class College {
  final String collegeName;
  final List<Program>? programs;

  College({
    required this.collegeName,
    this.programs,
  });

  factory College.fromJson(Map<String, dynamic> json) =>
      _$CollegeFromJson(json);
  Map<String, dynamic> toJson() => _$CollegeToJson(this);
}

@JsonSerializable()
class Program {
  final String programName;
  final List<Major>? majors;

  Program({
    required this.programName,
    this.majors,
  });

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}

@JsonSerializable()
class Major {
  final String majorName;

  Major({
    required this.majorName,
  });

  factory Major.fromJson(Map<String, dynamic> json) => _$MajorFromJson(json);
  Map<String, dynamic> toJson() => _$MajorToJson(this);
}
