import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_vm.g.dart';

@JsonSerializable()
class UserVm {
  final String? uid;
  final String name;
  final String email;
  final String? age;
  final String? gender;
  final String role;
  final String? createdAt;

  const UserVm({
    this.uid,
    this.age,
    this.gender,
    required this.name,
    required this.email,
    required this.role,
    this.createdAt,
  });

  factory UserVm.fromJson(Map<String, dynamic> json) => _$UserVmFromJson(json);

  Map<String, dynamic> toJson() => _$UserVmToJson(this);

  UserVm copyWith({
    String? uid,
    String? name,
    String? email,
    String? age,
    String? gender,
    String? role,
    String? createdAt,
  }) {
    return UserVm(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserVm.fromFirebaseUser(User user,
      {required String role, String? name}) {
    return UserVm(
      uid: user.uid,
      name: name ?? '', // Or fetch/display name from somewhere
      email: user.email ?? '',
      role: role,
      createdAt: DateTime.now().toIso8601String(),
    );
  }
}
