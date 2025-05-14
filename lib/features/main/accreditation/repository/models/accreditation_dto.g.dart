// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accreditation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccreditationDto _$AccreditationDtoFromJson(Map<String, dynamic> json) =>
    AccreditationDto(
      undergraduateProgramsOffered:
          json['undergraduateProgramsOffered'] as String,
      yearOfInitialOperation: json['yearOfInitialOperation'] as String,
      programAccreditationStatus: json['programAccreditationStatus'] as String,
      validityOfAccreditationStartDate:
          json['validityOfAccreditationStartDate'] as String?,
      validityOfAccreditationEndDate:
          json['validityOfAccreditationEndDate'] as String?,
      recommendation: json['recommendation'] as String?,
      supportingDocuments: json['supportingDocuments'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$AccreditationDtoToJson(AccreditationDto instance) =>
    <String, dynamic>{
      'undergraduateProgramsOffered': instance.undergraduateProgramsOffered,
      'yearOfInitialOperation': instance.yearOfInitialOperation,
      'programAccreditationStatus': instance.programAccreditationStatus,
      'validityOfAccreditationStartDate':
          instance.validityOfAccreditationStartDate,
      'validityOfAccreditationEndDate': instance.validityOfAccreditationEndDate,
      'recommendation': instance.recommendation,
      'supportingDocuments': instance.supportingDocuments,
      'remarks': instance.remarks,
    };
