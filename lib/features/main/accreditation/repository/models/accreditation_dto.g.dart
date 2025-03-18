// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accreditation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccreditationDto _$AccreditationDtoFromJson(Map<String, dynamic> json) =>
    AccreditationDto(
      uid: json['uid'] as String,
      name: json['name'] as String,
      contactNumber: json['contactNumber'] as String,
      gender: json['gender'] as String,
      pwd: json['pwd'] as String,
      seniorCitizen: json['seniorCitizen'] as String,
      civilStatus: json['civilStatus'] as String,
      employmentStatus: json['employmentStatus'] as String,
      datestarted: json['datestarted'] as bool,
      department: json['department'] as String?,
      degree: json['degree'] as String?,
      specialization: json['specialization'] as String?,
    );

Map<String, dynamic> _$AccreditationDtoToJson(AccreditationDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'contactNumber': instance.contactNumber,
      'gender': instance.gender,
      'civilStatus': instance.civilStatus,
      'employmentStatus': instance.employmentStatus,
      'datestarted': instance.datestarted,
      'department': instance.department,
      'degree': instance.degree,
      'specialization': instance.specialization,
      'pwd': instance.pwd,
      'seniorCitizen': instance.seniorCitizen,
    };
