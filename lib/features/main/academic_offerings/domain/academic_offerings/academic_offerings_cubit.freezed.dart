// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academic_offerings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AcademicOfferingsState {
  bool get isLoading;
  bool get isSuccess;
  String get errorMessage;
  List<StudentProfileVm> get studentProfile;
  List<ProgramVm>? get program;

  /// Create a copy of AcademicOfferingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AcademicOfferingsStateCopyWith<AcademicOfferingsState> get copyWith =>
      _$AcademicOfferingsStateCopyWithImpl<AcademicOfferingsState>(
          this as AcademicOfferingsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AcademicOfferingsState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other.studentProfile, studentProfile) &&
            const DeepCollectionEquality().equals(other.program, program));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isSuccess,
      errorMessage,
      const DeepCollectionEquality().hash(studentProfile),
      const DeepCollectionEquality().hash(program));

  @override
  String toString() {
    return 'AcademicOfferingsState(isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage, studentProfile: $studentProfile, program: $program)';
  }
}

/// @nodoc
abstract mixin class $AcademicOfferingsStateCopyWith<$Res> {
  factory $AcademicOfferingsStateCopyWith(AcademicOfferingsState value,
          $Res Function(AcademicOfferingsState) _then) =
      _$AcademicOfferingsStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      bool isSuccess,
      String errorMessage,
      List<StudentProfileVm> studentProfile,
      List<ProgramVm>? program});
}

/// @nodoc
class _$AcademicOfferingsStateCopyWithImpl<$Res>
    implements $AcademicOfferingsStateCopyWith<$Res> {
  _$AcademicOfferingsStateCopyWithImpl(this._self, this._then);

  final AcademicOfferingsState _self;
  final $Res Function(AcademicOfferingsState) _then;

  /// Create a copy of AcademicOfferingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? errorMessage = null,
    Object? studentProfile = null,
    Object? program = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      studentProfile: null == studentProfile
          ? _self.studentProfile
          : studentProfile // ignore: cast_nullable_to_non_nullable
              as List<StudentProfileVm>,
      program: freezed == program
          ? _self.program
          : program // ignore: cast_nullable_to_non_nullable
              as List<ProgramVm>?,
    ));
  }
}

/// @nodoc

class _AcademicOfferingsState implements AcademicOfferingsState {
  const _AcademicOfferingsState(
      {this.isLoading = false,
      this.isSuccess = false,
      this.errorMessage = '',
      final List<StudentProfileVm> studentProfile = const [],
      final List<ProgramVm>? program = const []})
      : _studentProfile = studentProfile,
        _program = program;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final String errorMessage;
  final List<StudentProfileVm> _studentProfile;
  @override
  @JsonKey()
  List<StudentProfileVm> get studentProfile {
    if (_studentProfile is EqualUnmodifiableListView) return _studentProfile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_studentProfile);
  }

  final List<ProgramVm>? _program;
  @override
  @JsonKey()
  List<ProgramVm>? get program {
    final value = _program;
    if (value == null) return null;
    if (_program is EqualUnmodifiableListView) return _program;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of AcademicOfferingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AcademicOfferingsStateCopyWith<_AcademicOfferingsState> get copyWith =>
      __$AcademicOfferingsStateCopyWithImpl<_AcademicOfferingsState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AcademicOfferingsState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._studentProfile, _studentProfile) &&
            const DeepCollectionEquality().equals(other._program, _program));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isSuccess,
      errorMessage,
      const DeepCollectionEquality().hash(_studentProfile),
      const DeepCollectionEquality().hash(_program));

  @override
  String toString() {
    return 'AcademicOfferingsState(isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage, studentProfile: $studentProfile, program: $program)';
  }
}

/// @nodoc
abstract mixin class _$AcademicOfferingsStateCopyWith<$Res>
    implements $AcademicOfferingsStateCopyWith<$Res> {
  factory _$AcademicOfferingsStateCopyWith(_AcademicOfferingsState value,
          $Res Function(_AcademicOfferingsState) _then) =
      __$AcademicOfferingsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isSuccess,
      String errorMessage,
      List<StudentProfileVm> studentProfile,
      List<ProgramVm>? program});
}

/// @nodoc
class __$AcademicOfferingsStateCopyWithImpl<$Res>
    implements _$AcademicOfferingsStateCopyWith<$Res> {
  __$AcademicOfferingsStateCopyWithImpl(this._self, this._then);

  final _AcademicOfferingsState _self;
  final $Res Function(_AcademicOfferingsState) _then;

  /// Create a copy of AcademicOfferingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? errorMessage = null,
    Object? studentProfile = null,
    Object? program = freezed,
  }) {
    return _then(_AcademicOfferingsState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      studentProfile: null == studentProfile
          ? _self._studentProfile
          : studentProfile // ignore: cast_nullable_to_non_nullable
              as List<StudentProfileVm>,
      program: freezed == program
          ? _self._program
          : program // ignore: cast_nullable_to_non_nullable
              as List<ProgramVm>?,
    ));
  }
}

// dart format on
