import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/features/main/accounts/repository/models/account_creation.dto.dart';
part 'account_creation_vm.g.dart';

@JsonSerializable()
class AccountVm {
  final String name;
  final String email;
  final String role;
  final String gender;
  final int age;

  const AccountVm({
    required this.name,
    required this.email,
    required this.role,
    required this.gender,
    required this.age,
  });

  factory AccountVm.fromDto(AccountDto dto) {
    return AccountVm(
      name: dto.name,
      email: dto.email,
      gender: dto.gender,
      role: dto.role,
      age: dto.age,
    );
  }

  factory AccountVm.fromJson(Map<String, dynamic> json) =>
      _$AccountVmFromJson(json);

  Map<String, dynamic> toJson() => _$AccountVmToJson(this);
}
