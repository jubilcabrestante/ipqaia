import 'package:json_annotation/json_annotation.dart';

part 'account_creation.dto.g.dart';

@JsonSerializable()
class AccountDto {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String gender;
  final int age;

  const AccountDto({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.gender,
    required this.age,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) => _$AccountDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDtoToJson(this);
}
