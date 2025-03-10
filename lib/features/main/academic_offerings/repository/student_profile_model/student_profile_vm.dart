import 'package:json_annotation/json_annotation.dart';
import 'student_profile_dto.dart'; // Import DTO class

part 'student_profile_vm.g.dart';

@JsonSerializable()
class StudentProfileVm {
  final String name;
  final String dateOfBirth;
  final String gender;
  final String courseAndProgram;
  final String yearLevel;
  final String? ethnicGroup;
  final String? financialAssistance;
  final String? pwd;

  const StudentProfileVm({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.courseAndProgram,
    required this.yearLevel,
    this.ethnicGroup,
    this.financialAssistance,
    this.pwd,
  });

  factory StudentProfileVm.fromDto(StudentProfileDto dto) {
    return StudentProfileVm(
      name: dto.name,
      dateOfBirth: dto.dateOfBirth,
      gender: dto.gender,
      courseAndProgram: dto.courseAndProgram,
      yearLevel: dto.yearLevel,
      ethnicGroup: dto.ethnicGroup,
      financialAssistance: dto.financialAssistance,
      pwd: dto.pwd,
    );
  }

  factory StudentProfileVm.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileVmFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileVmToJson(this);
}
