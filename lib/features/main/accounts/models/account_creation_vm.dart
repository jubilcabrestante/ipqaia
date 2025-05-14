import 'package:freezed_annotation/freezed_annotation.dart';
part 'account_creation_vm.g.dart';

@JsonSerializable()
class AccountVm {
  final String? uid;
  final String name;
  final String email;
  final String role;
  final String gender;
  final int age;
  final String? createdAt;

  const AccountVm({
    this.uid,
    this.createdAt,
    required this.name,
    required this.email,
    required this.role,
    required this.gender,
    required this.age,
  });

  factory AccountVm.fromJson(Map<String, dynamic> json) =>
      _$AccountVmFromJson(json);

  Map<String, dynamic> toJson() => _$AccountVmToJson(this);

  factory AccountVm.fromFirebaseUser(
      {required String role, String? name, String? email, int? age}) {
    return AccountVm(
      name: name ?? '',
      email: email ?? '',
      role: role,
      gender: '',
      age: age ?? 0,
    );
  }
}
