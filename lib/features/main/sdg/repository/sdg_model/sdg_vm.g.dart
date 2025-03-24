// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdg_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SdgVm _$SdgVmFromJson(Map<String, dynamic> json) => SdgVm(
      sdgId: json['sdgId'] as String?,
      sdgNumber: (json['sdgNumber'] as num?)?.toInt(),
      sdgTitle: json['sdgTitle'] as String?,
      words: json['words'] as String?,
    );

Map<String, dynamic> _$SdgVmToJson(SdgVm instance) => <String, dynamic>{
      'sdgId': instance.sdgId,
      'sdgNumber': instance.sdgNumber,
      'sdgTitle': instance.sdgTitle,
      'words': instance.words,
    };
