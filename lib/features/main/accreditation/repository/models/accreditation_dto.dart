import 'package:json_annotation/json_annotation.dart';
part 'accreditation_dto.g.dart';

@JsonSerializable()
class AccreditationDto {
  final String undergraduateProgramsOffered;
final String yearOfInitialOperation;
final String programAccreditationStatus;
final String? validityOfAccreditationStartDate;
final String? validityOfAccreditationEndDate;
final String? recommendation;
final String? supportingDocuments;
final String? remarks;

  const AccreditationDto({
   required this.undergraduateProgramsOffered,
   required this.yearOfInitialOperation,
   required this.programAccreditationStatus,
   this.validityOfAccreditationStartDate,
   this.validityOfAccreditationEndDate,
   this.recommendation,
   this.supportingDocuments,
   this.remarks,
  
   
  });

  factory AccreditationDto.fromJson(Map<String, dynamic> json) =>
      _$AccreditationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AccreditationDtoToJson(this);
}



