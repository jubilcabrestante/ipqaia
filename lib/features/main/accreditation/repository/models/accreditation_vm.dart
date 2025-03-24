import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/features/main/accreditation/repository/models/accreditation_dto.dart';
part 'accreditation_vm.g.dart';

@JsonSerializable()
class AccreditationVm {
  final String name;
  final String contactNumber;
  final String gender;
  final String civilStatus;
  final String employmentStatus;
  final bool datestarted;
  final String? department;
  final String? degree;
  final String? specialization;
  final String pwd;
  final String seniorCitizen;

  const AccreditationVm({
    required this.name,
    required this.contactNumber,
    required this.gender,
    required this.pwd,
    required this.seniorCitizen,
    required this.civilStatus,
    required this.employmentStatus,
    required this.datestarted,
    this.department,
    this.degree,
    this.specialization,
  });

  factory AccreditationVm.fromJson(Map<String, dynamic> json) =>
      _$AccreditationVmFromJson(json);

  Map<String, dynamic> toJson() => _$AccreditationVmToJson(this);
}