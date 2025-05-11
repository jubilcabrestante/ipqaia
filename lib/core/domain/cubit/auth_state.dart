part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    UserVm? currentUser,
    @Default([]) List<AccountVm> accounts,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingAccounts,
    @Default(false) bool isSuccess,
    @Default(false) bool isError,
    @Default(false) bool isAuthenticated,
    @Default(false) bool isNewUser,
    @Default(false) bool isConnected,
    String? errorMessage,
  }) = _AuthState;
}
