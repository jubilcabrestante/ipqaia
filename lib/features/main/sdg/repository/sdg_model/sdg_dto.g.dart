// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdg_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SdgDto _$SdgDtoFromJson(Map<String, dynamic> json) => SdgDto(
      sdgNumber: (json['sdgNumber'] as num).toInt(),
      sdgTitle: json['sdgTitle'] as String,
      words: json['words'] as String,
    );

Map<String, dynamic> _$SdgDtoToJson(SdgDto instance) => <String, dynamic>{
      'sdgNumber': instance.sdgNumber,
      'sdgTitle': instance.sdgTitle,
      'words': instance.words,
    };
