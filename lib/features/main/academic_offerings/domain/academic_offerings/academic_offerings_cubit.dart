import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/features/main/academic_offerings/domain/i_academic_offerings_repository.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/student_profile_model/student_profile_vm.dart';

part 'academic_offerings_state.dart';
part 'academic_offerings_cubit.freezed.dart';

class AcademicOfferingsCubit extends Cubit<AcademicOfferingsState> {
  final IAcademicOfferingsRepository _repository;

  AcademicOfferingsCubit(this._repository)
      : super(const AcademicOfferingsState());

  Future<void> addStudentProfileMain(StudentProfileVm studentProfile) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addStudentProfileMain(studentProfile);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addStudentProfileExternal(
      StudentProfileVm studentProfile) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addStudentProfileExternal(studentProfile);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addProgramMain(ProgramVm program) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addProgramMain(program);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addProgramExternal(ProgramVm program) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addProgramExternal(program);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteStudentProfileMain(String studentProfileId) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.deleteStudentProfile(studentProfileId);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteStudentProfileExternal(String studentProfileId) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.deleteStudentProfile(studentProfileId);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteProgram(String programId) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.deleteProgram(programId);

      await getProgramsMain();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getStudentProfilesMain() async {
    emit(state.copyWith(isLoading: true));
    try {
      final students = await _repository.getStudentProfilesMain();
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        studentProfile: students,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getStudentProfilesExternal() async {
    emit(state.copyWith(isLoading: true));
    try {
      final students = await _repository.getStudentProfilesExternal();
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        studentProfile: students,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getProgramsMain() async {
    emit(state.copyWith(isLoading: true));
    try {
      final programs = await _repository.getProgramsMain();
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        program: programs,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getProgramsExternal() async {
    emit(state.copyWith(isLoading: true));
    try {
      final programs = await _repository.getProgramsExternal();
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        program: programs,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  updateSelectedProgram(String program) {
    emit(state.copyWith(selectedProgram: program));
  }

  updateSelectedYear(String year) {
    emit(state.copyWith(selectedYear: year));
  }
}
