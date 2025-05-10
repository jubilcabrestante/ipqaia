import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/core/domain/i_user_repository.dart';
import 'package:ipqaia/core/repository/user_model/user_vm.dart';
import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final IUserRepository _iUserRepository;
  AuthCubit(this._iUserRepository) : super(AuthState());

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
}
