import 'package:json_annotation/json_annotation.dart';

part 'personel_profile_dto.g.dart';

@JsonSerializable()
class PersonelDto {
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

  const PersonelDto({
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

  factory PersonelDto.fromJson(Map<String, dynamic> json) =>
      _$PersonelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonelDtoToJson(this);
}



