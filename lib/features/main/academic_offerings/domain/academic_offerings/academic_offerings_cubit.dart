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

  Future<void> addStudentProfile(StudentProfileVm studentProfile) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addStudentProfile(studentProfile);

      await getStudentProfiles(); // getStudentProfiles para maka kuha ng update uli
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addProgram(ProgramVm program) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addProgram(program);

      await getPrograms(); // await getPrograms(); para makakuha uli programs na bago
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteStudentProfile(String studentProfileId) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.deleteStudentProfile(studentProfileId);

      await getStudentProfiles(); // getStudentProfiles para maka kuha ng update uli
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

      await getPrograms(); // await getPrograms(); para makakuha uli na programs after delete
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  // 🔹 New method: Get all student profiles
  Future<void> getStudentProfiles() async {
    emit(state.copyWith(isLoading: true));
    try {
      final students = await _repository.getStudentProfiles();
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

  // 🔹 New method: Get all programs
  Future<void> getPrograms() async {
    emit(state.copyWith(isLoading: true));
    try {
      final programs = await _repository.getPrograms();
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
}
