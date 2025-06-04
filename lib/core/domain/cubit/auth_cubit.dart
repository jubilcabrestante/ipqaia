import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/core/domain/i_user_repository.dart';
import 'package:ipqaia/core/repository/user_model/user_vm.dart';
import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';
part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final IUserRepository _iUserRepository;
  AuthCubit(this._iUserRepository) : super(AuthState()) {
    _getAccounts();
  }

  _getAccounts() async {
    emit(state.copyWith(
      isLoadingAccounts: true,
    ));

    try {
      final accounts = await _iUserRepository.getUserList();
      emit(state.copyWith(
        accounts: accounts,
        isLoadingAccounts: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> createAccount(AccountVm user, String password) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    try {
      await _iUserRepository.createUserWithEmailAndPassword(
        user,
        password,
      );

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
      _getAccounts();
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  updateAccount(AccountVm user) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    try {
      await _iUserRepository.updateUser(user);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
      _getAccounts();
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> logOut() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _iUserRepository.signOut();
      emit(state.copyWith(
        currentUser: null,
        isLoading: false,
        isSuccess: false,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isSuccess: false,
      ));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    ));

    try {
      final user =
          await _iUserRepository.signInWithEmailAndPassword(email, password);
      emit(state.copyWith(
        currentUser: user,
        isLoading: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      rethrow;
    }
  }

  Future<void> deleteUser(String accoundId) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    ));

    try {
      await _iUserRepository.deleteUser(accoundId);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateSelectedRole(String role) async {
    emit(state.copyWith(
      selectedRole: role,
    ));
  }

  Future<void> updateSelectedGender(String gender) async {
    emit(state.copyWith(selectedGender: gender));
  }
}
