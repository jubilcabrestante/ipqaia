import 'package:ipqaia/core/repository/user_model/user_dto.dart';

abstract class IUserRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> saveUser(UserDto user);

  Future<void> createUserWithEmailAndPassword(
      UserDto user, String password, String adminPassword);

  Future<void> signOut();
}
