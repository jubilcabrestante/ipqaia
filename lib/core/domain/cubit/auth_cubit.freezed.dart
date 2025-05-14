// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthState {
  UserVm? get currentUser;
  List<AccountVm> get accounts;
  bool get isLoading;
  bool get isLoadingAccounts;
  bool get isSuccess;
  bool get isError;
  bool get isAuthenticated;
  bool get isNewUser;
  bool get isConnected;
  String get selectedRole;
  String get selectedGender;
  String get password;
  String? get errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateCopyWith<AuthState> get copyWith =>
      _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthState &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            const DeepCollectionEquality().equals(other.accounts, accounts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingAccounts, isLoadingAccounts) ||
                other.isLoadingAccounts == isLoadingAccounts) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            (identical(other.isNewUser, isNewUser) ||
                other.isNewUser == isNewUser) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.selectedRole, selectedRole) ||
                other.selectedRole == selectedRole) &&
            (identical(other.selectedGender, selectedGender) ||
                other.selectedGender == selectedGender) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentUser,
      const DeepCollectionEquality().hash(accounts),
      isLoading,
      isLoadingAccounts,
      isSuccess,
      isError,
      isAuthenticated,
      isNewUser,
      isConnected,
      selectedRole,
      selectedGender,
      password,
      errorMessage);

  @override
  String toString() {
    return 'AuthState(currentUser: $currentUser, accounts: $accounts, isLoading: $isLoading, isLoadingAccounts: $isLoadingAccounts, isSuccess: $isSuccess, isError: $isError, isAuthenticated: $isAuthenticated, isNewUser: $isNewUser, isConnected: $isConnected, selectedRole: $selectedRole, selectedGender: $selectedGender, password: $password, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) =
      _$AuthStateCopyWithImpl;
  @useResult
  $Res call(
      {UserVm? currentUser,
      List<AccountVm> accounts,
      bool isLoading,
      bool isLoadingAccounts,
      bool isSuccess,
      bool isError,
      bool isAuthenticated,
      bool isNewUser,
      bool isConnected,
      String selectedRole,
      String selectedGender,
      String password,
      String? errorMessage});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUser = freezed,
    Object? accounts = null,
    Object? isLoading = null,
    Object? isLoadingAccounts = null,
    Object? isSuccess = null,
    Object? isError = null,
    Object? isAuthenticated = null,
    Object? isNewUser = null,
    Object? isConnected = null,
    Object? selectedRole = null,
    Object? selectedGender = null,
    Object? password = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserVm?,
      accounts: null == accounts
          ? _self.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountVm>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAccounts: null == isLoadingAccounts
          ? _self.isLoadingAccounts
          : isLoadingAccounts // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _self.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticated: null == isAuthenticated
          ? _self.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewUser: null == isNewUser
          ? _self.isNewUser
          : isNewUser // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedRole: null == selectedRole
          ? _self.selectedRole
          : selectedRole // ignore: cast_nullable_to_non_nullable
              as String,
      selectedGender: null == selectedGender
          ? _self.selectedGender
          : selectedGender // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _AuthState implements AuthState {
  const _AuthState(
      {this.currentUser,
      final List<AccountVm> accounts = const [],
      this.isLoading = false,
      this.isLoadingAccounts = false,
      this.isSuccess = false,
      this.isError = false,
      this.isAuthenticated = false,
      this.isNewUser = false,
      this.isConnected = false,
      this.selectedRole = '',
      this.selectedGender = '',
      this.password = '',
      this.errorMessage})
      : _accounts = accounts;

  @override
  final UserVm? currentUser;
  final List<AccountVm> _accounts;
  @override
  @JsonKey()
  List<AccountVm> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingAccounts;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final bool isAuthenticated;
  @override
  @JsonKey()
  final bool isNewUser;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final String selectedRole;
  @override
  @JsonKey()
  final String selectedGender;
  @override
  @JsonKey()
  final String password;
  @override
  final String? errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthStateCopyWith<_AuthState> get copyWith =>
      __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthState &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingAccounts, isLoadingAccounts) ||
                other.isLoadingAccounts == isLoadingAccounts) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            (identical(other.isNewUser, isNewUser) ||
                other.isNewUser == isNewUser) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.selectedRole, selectedRole) ||
                other.selectedRole == selectedRole) &&
            (identical(other.selectedGender, selectedGender) ||
                other.selectedGender == selectedGender) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentUser,
      const DeepCollectionEquality().hash(_accounts),
      isLoading,
      isLoadingAccounts,
      isSuccess,
      isError,
      isAuthenticated,
      isNewUser,
      isConnected,
      selectedRole,
      selectedGender,
      password,
      errorMessage);

  @override
  String toString() {
    return 'AuthState(currentUser: $currentUser, accounts: $accounts, isLoading: $isLoading, isLoadingAccounts: $isLoadingAccounts, isSuccess: $isSuccess, isError: $isError, isAuthenticated: $isAuthenticated, isNewUser: $isNewUser, isConnected: $isConnected, selectedRole: $selectedRole, selectedGender: $selectedGender, password: $password, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(
          _AuthState value, $Res Function(_AuthState) _then) =
      __$AuthStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {UserVm? currentUser,
      List<AccountVm> accounts,
      bool isLoading,
      bool isLoadingAccounts,
      bool isSuccess,
      bool isError,
      bool isAuthenticated,
      bool isNewUser,
      bool isConnected,
      String selectedRole,
      String selectedGender,
      String password,
      String? errorMessage});
}

/// @nodoc
class __$AuthStateCopyWithImpl<$Res> implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentUser = freezed,
    Object? accounts = null,
    Object? isLoading = null,
    Object? isLoadingAccounts = null,
    Object? isSuccess = null,
    Object? isError = null,
    Object? isAuthenticated = null,
    Object? isNewUser = null,
    Object? isConnected = null,
    Object? selectedRole = null,
    Object? selectedGender = null,
    Object? password = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_AuthState(
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserVm?,
      accounts: null == accounts
          ? _self._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AccountVm>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingAccounts: null == isLoadingAccounts
          ? _self.isLoadingAccounts
          : isLoadingAccounts // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _self.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticated: null == isAuthenticated
          ? _self.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewUser: null == isNewUser
          ? _self.isNewUser
          : isNewUser // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedRole: null == selectedRole
          ? _self.selectedRole
          : selectedRole // ignore: cast_nullable_to_non_nullable
              as String,
      selectedGender: null == selectedGender
          ? _self.selectedGender
          : selectedGender // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
