import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/features/main/personnel_profile/repository/models/personel_profile_dto.dart';
part 'personel_profile_vm.g.dart';

@JsonSerializable()
class PersonnelVm {
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

  const PersonnelVm({
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

  factory PersonnelVm.fromDto(PersonnelDto dto) {
    return PersonnelVm(
      name: dto.name,
      contactNumber: dto.contactNumber,
      gender: dto.gender,
      pwd: dto.pwd,
      seniorCitizen: dto.seniorCitizen,
      civilStatus: dto.civilStatus,
      employmentStatus: dto.employmentStatus,
      datestarted: dto.datestarted,
    );
  }

  factory PersonnelVm.fromJson(Map<String, dynamic> json) =>
      _$PersonnelVmFromJson(json);

  Map<String, dynamic> toJson() => _$PersonnelVmToJson(this);
}
