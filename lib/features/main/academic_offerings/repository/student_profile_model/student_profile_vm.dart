import 'package:json_annotation/json_annotation.dart';

part 'student_profile_vm.g.dart';

@JsonSerializable()
class StudentProfileVm {
  final String cluster;
  final String campus;
  final String program;
  final String? major;
  final String studentId;
  final String yearEnrolled;
  final String? yearGraduate;
  final String citizenship;
  final String? financialAssistance;
  final bool? ethnicGroup;
  final bool? pwd;

  const StudentProfileVm({
    required this.studentId,
    required this.yearEnrolled,
    required this.cluster,
    required this.campus,
    required this.program,
    required this.citizenship,
    this.ethnicGroup,
    this.major,
    this.yearGraduate,
    this.financialAssistance,
    this.pwd,
  });

  factory StudentProfileVm.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileVmFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileVmToJson(this);
}
