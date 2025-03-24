import 'package:json_annotation/json_annotation.dart';

part 'sdg_vm.g.dart';

@JsonSerializable()
class SdgVm {
  final String? sdgId;
  final int? sdgNumber;
  final String? sdgTitle;
  final String? words;

  SdgVm({
    this.sdgId,
    this.sdgNumber,
    this.sdgTitle,
    this.words,
  });

  factory SdgVm.fromJson(Map<String, dynamic> json) => _$SdgVmFromJson(json);
  Map<String, dynamic> toJson() => _$SdgVmToJson(this);

  SdgVm copyWith({
    String? sdgId,
    int? sdgNumber,
    String? sdgTitle,
    String? words,
  }) {
    return SdgVm(
      sdgId: sdgId ?? this.sdgId,
      sdgNumber: sdgNumber ?? this.sdgNumber,
      sdgTitle: sdgTitle ?? this.sdgTitle,
      words: words ?? this.words,
    );
  }
}
