import 'package:json_annotation/json_annotation.dart';

part 'sdg_dto.g.dart';

@JsonSerializable()
class SdgDto {
  final int sdgNumber;
  final String sdgTitle;
  final String words;

  const SdgDto({
    required this.sdgNumber,
    required this.sdgTitle,
    required this.words,
  });

  factory SdgDto.fromJson(Map<String, dynamic> json) => _$SdgDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SdgDtoToJson(this);
}
