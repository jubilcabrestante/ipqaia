import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/features/main/students_life_and_facilties/repository/models/slf_dto.dart';
part 'slf_vm.g.dart';

@JsonSerializable()
class SlfVm {
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

  const SlfVm({
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

factory SlfVm.fromDto(SlfDto dto) {
    return SlfVm(
      name: dto.name, contactNumber: dto.contactNumber, 
      gender: dto.gender, pwd: dto.pwd, seniorCitizen: dto.seniorCitizen, 
      civilStatus: dto.civilStatus, employmentStatus: dto.employmentStatus,
      datestarted: dto.datestarted,
    );
  }


  factory SlfVm.fromJson(Map<String, dynamic> json) =>
      _$SlfVmFromJson(json);

  Map<String, dynamic> toJson() => _$SlfVmToJson(this);
}