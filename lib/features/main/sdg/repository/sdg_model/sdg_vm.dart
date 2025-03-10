import 'package:json_annotation/json_annotation.dart';

part 'sdg_vm.g.dart';

@JsonSerializable()
class SdgVm {
  final int sdgNumber;
  final String sdgTitle;
  final String words;

  const SdgVm({
    required this.sdgNumber,
    required this.sdgTitle,
    required this.words,
  });

  factory SdgVm.fromJson(Map<String, dynamic> json) => _$SdgVmFromJson(json);

  Map<String, dynamic> toJson() => _$SdgVmToJson(this);
}
