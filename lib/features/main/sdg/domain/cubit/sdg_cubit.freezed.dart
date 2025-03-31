// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sdg_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SdgState {
  bool get isLoading;
  bool get isSuccess;
  String get errorMessage;
  List<SdgVm> get sdg;
  List<ArticleVm> get articles;
  String? get selectedArticle;
  String? get selectedSdg;
  List<String> get newWords;

  /// Create a copy of SdgState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SdgStateCopyWith<SdgState> get copyWith =>
      _$SdgStateCopyWithImpl<SdgState>(this as SdgState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SdgState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other.sdg, sdg) &&
            const DeepCollectionEquality().equals(other.articles, articles) &&
            (identical(other.selectedArticle, selectedArticle) ||
                other.selectedArticle == selectedArticle) &&
            (identical(other.selectedSdg, selectedSdg) ||
                other.selectedSdg == selectedSdg) &&
            const DeepCollectionEquality().equals(other.newWords, newWords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isSuccess,
      errorMessage,
      const DeepCollectionEquality().hash(sdg),
      const DeepCollectionEquality().hash(articles),
      selectedArticle,
      selectedSdg,
      const DeepCollectionEquality().hash(newWords));

  @override
  String toString() {
    return 'SdgState(isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage, sdg: $sdg, articles: $articles, selectedArticle: $selectedArticle, selectedSdg: $selectedSdg, newWords: $newWords)';
  }
}

/// @nodoc
abstract mixin class $SdgStateCopyWith<$Res> {
  factory $SdgStateCopyWith(SdgState value, $Res Function(SdgState) _then) =
      _$SdgStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      bool isSuccess,
      String errorMessage,
      List<SdgVm> sdg,
      List<ArticleVm> articles,
      String? selectedArticle,
      String? selectedSdg,
      List<String> newWords});
}

/// @nodoc
class _$SdgStateCopyWithImpl<$Res> implements $SdgStateCopyWith<$Res> {
  _$SdgStateCopyWithImpl(this._self, this._then);

  final SdgState _self;
  final $Res Function(SdgState) _then;

  /// Create a copy of SdgState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? errorMessage = null,
    Object? sdg = null,
    Object? articles = null,
    Object? selectedArticle = freezed,
    Object? selectedSdg = freezed,
    Object? newWords = null,
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
      sdg: null == sdg
          ? _self.sdg
          : sdg // ignore: cast_nullable_to_non_nullable
              as List<SdgVm>,
      articles: null == articles
          ? _self.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<ArticleVm>,
      selectedArticle: freezed == selectedArticle
          ? _self.selectedArticle
          : selectedArticle // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSdg: freezed == selectedSdg
          ? _self.selectedSdg
          : selectedSdg // ignore: cast_nullable_to_non_nullable
              as String?,
      newWords: null == newWords
          ? _self.newWords
          : newWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _SdgState implements SdgState {
  const _SdgState(
      {this.isLoading = false,
      this.isSuccess = false,
      this.errorMessage = '',
      final List<SdgVm> sdg = const [],
      final List<ArticleVm> articles = const [],
      this.selectedArticle,
      this.selectedSdg,
      final List<String> newWords = const []})
      : _sdg = sdg,
        _articles = articles,
        _newWords = newWords;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  @JsonKey()
  final String errorMessage;
  final List<SdgVm> _sdg;
  @override
  @JsonKey()
  List<SdgVm> get sdg {
    if (_sdg is EqualUnmodifiableListView) return _sdg;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sdg);
  }

  final List<ArticleVm> _articles;
  @override
  @JsonKey()
  List<ArticleVm> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  final String? selectedArticle;
  @override
  final String? selectedSdg;
  final List<String> _newWords;
  @override
  @JsonKey()
  List<String> get newWords {
    if (_newWords is EqualUnmodifiableListView) return _newWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newWords);
  }

  /// Create a copy of SdgState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SdgStateCopyWith<_SdgState> get copyWith =>
      __$SdgStateCopyWithImpl<_SdgState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SdgState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._sdg, _sdg) &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.selectedArticle, selectedArticle) ||
                other.selectedArticle == selectedArticle) &&
            (identical(other.selectedSdg, selectedSdg) ||
                other.selectedSdg == selectedSdg) &&
            const DeepCollectionEquality().equals(other._newWords, _newWords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isSuccess,
      errorMessage,
      const DeepCollectionEquality().hash(_sdg),
      const DeepCollectionEquality().hash(_articles),
      selectedArticle,
      selectedSdg,
      const DeepCollectionEquality().hash(_newWords));

  @override
  String toString() {
    return 'SdgState(isLoading: $isLoading, isSuccess: $isSuccess, errorMessage: $errorMessage, sdg: $sdg, articles: $articles, selectedArticle: $selectedArticle, selectedSdg: $selectedSdg, newWords: $newWords)';
  }
}

/// @nodoc
abstract mixin class _$SdgStateCopyWith<$Res>
    implements $SdgStateCopyWith<$Res> {
  factory _$SdgStateCopyWith(_SdgState value, $Res Function(_SdgState) _then) =
      __$SdgStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isSuccess,
      String errorMessage,
      List<SdgVm> sdg,
      List<ArticleVm> articles,
      String? selectedArticle,
      String? selectedSdg,
      List<String> newWords});
}

/// @nodoc
class __$SdgStateCopyWithImpl<$Res> implements _$SdgStateCopyWith<$Res> {
  __$SdgStateCopyWithImpl(this._self, this._then);

  final _SdgState _self;
  final $Res Function(_SdgState) _then;

  /// Create a copy of SdgState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? errorMessage = null,
    Object? sdg = null,
    Object? articles = null,
    Object? selectedArticle = freezed,
    Object? selectedSdg = freezed,
    Object? newWords = null,
  }) {
    return _then(_SdgState(
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
      sdg: null == sdg
          ? _self._sdg
          : sdg // ignore: cast_nullable_to_non_nullable
              as List<SdgVm>,
      articles: null == articles
          ? _self._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<ArticleVm>,
      selectedArticle: freezed == selectedArticle
          ? _self.selectedArticle
          : selectedArticle // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSdg: freezed == selectedSdg
          ? _self.selectedSdg
          : selectedSdg // ignore: cast_nullable_to_non_nullable
              as String?,
      newWords: null == newWords
          ? _self._newWords
          : newWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
