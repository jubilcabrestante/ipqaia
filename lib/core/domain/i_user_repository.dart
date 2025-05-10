import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';

abstract class IUserRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(AccountVm user, String password);

  Future<void> signOut();
}
