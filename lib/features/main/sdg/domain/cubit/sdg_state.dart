part of 'sdg_cubit.dart';

@freezed
abstract class SdgState with _$SdgState {
  const factory SdgState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default('') String errorMessage,
    @Default([]) List<SdgVm> sdg,
  }) = _SdgState;
}
