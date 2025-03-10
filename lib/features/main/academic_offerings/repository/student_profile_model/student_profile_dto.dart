import 'package:json_annotation/json_annotation.dart';

part 'student_profile_dto.g.dart'; // Ensure this part is correct

@JsonSerializable()
class StudentProfileDto {
  final String uid;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String courseAndProgram;
  final String yearLevel;
  final String? ethnicGroup;
  final String? financialAssistance;
  final String? pwd;
  final String? createdAt;

  const StudentProfileDto({
    required this.uid,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.courseAndProgram,
    required this.yearLevel,
    this.ethnicGroup,
    this.financialAssistance,
    this.pwd,
    this.createdAt,
  });

  factory StudentProfileDto.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileDtoToJson(this);
}
