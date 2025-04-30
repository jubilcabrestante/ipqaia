part of 'sdg_cubit.dart';

@freezed
abstract class SdgState with _$SdgState {
  const factory SdgState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool isLoadingArticle,
    @Default(false) bool isSuccessArticle,
    @Default('') String errorMessage,
    @Default([]) List<SdgVm> sdg,
    @Default([]) List<ArticleVm> articles,
    String? selectedArticle,
    String? selectedSdg,
    DateTime? selectedDate,
    @Default([]) List<String> newWords,
  }) = _SdgState;
}
