part of 'academic_offerings_cubit.dart';

@freezed
abstract class AcademicOfferingsState with _$AcademicOfferingsState {
  const factory AcademicOfferingsState(
      {@Default(false) bool isLoading,
      @Default(false) bool isSuccess,
      @Default('') String errorMessage,
      @Default([]) List<StudentProfileVm> studentProfile,
      @Default([]) List<ProgramVm> program,
      @Default('') String selectedCluster,
      @Default('') String selectedCampus}) = _AcademicOfferingsState;
}
