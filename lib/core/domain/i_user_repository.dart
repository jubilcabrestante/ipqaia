import 'package:ipqaia/core/repository/user_model/user_vm.dart';
import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';

abstract class IUserRepository {
  Future<UserVm> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(AccountVm user, String password);

  Future<void> updateUser(AccountVm user);

  Future<void> signOut();

  Future<List<AccountVm>> getUserList();

  Future<void> deleteUser(String uid);
}
