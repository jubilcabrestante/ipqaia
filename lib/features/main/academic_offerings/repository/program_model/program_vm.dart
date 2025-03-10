import 'package:json_annotation/json_annotation.dart';

part 'program_vm.g.dart';

@JsonSerializable()
class ProgramVm {
  final String id;
  final String campus;
  final String cluster;
  final String? college;
  final String program;
  final String? major;
  final String numberEnrolled;
  final String perYear;
  final String perSem;

  // Correct constructor
  const ProgramVm({
    required this.id,
    required this.campus,
    required this.cluster,
    this.college,
    required this.program,
    this.major,
    required this.numberEnrolled,
    required this.perYear,
    required this.perSem,
  });

  // JSON serialization methods
  factory ProgramVm.fromJson(Map<String, dynamic> json) =>
      _$ProgramVmFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramVmToJson(this);
}
