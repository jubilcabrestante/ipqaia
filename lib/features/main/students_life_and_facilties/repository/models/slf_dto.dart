import 'package:json_annotation/json_annotation.dart';

part 'slf_dto.g.dart';

@JsonSerializable()
class SlfDto {
  final String uid;
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

  const SlfDto({
    required this.uid,
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

  factory SlfDto.fromJson(Map<String, dynamic> json) =>
      _$SlfDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SlfDtoToJson(this);
}



