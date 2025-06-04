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
      : super(const AcademicOfferingsState()) {
    getPrograms();
  }

  Future<void> addStudentProfile(StudentProfileVm studentProfile) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.addStudentProfile(studentProfile);

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
      getPrograms();
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

  Future<void> deleteMajor({
    required String programId,
    required String campusName,
    required String collegeName,
    required String programName,
    required String majorName,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.deleteMajor(
        programId,
        campusName,
        collegeName,
        programName,
        majorName,
      );

      await getPrograms();
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

  updateSelectedCluster(String cluster) {
    emit(state.copyWith(selectedCluster: cluster));
  }

  updateSelectedCampus(String campus) {
    emit(state.copyWith(selectedCampus: campus));
  }

  List<Map<String, String>> getFlattenedAcademicStructure() {
    final data = <Map<String, String>>[];

    for (final cluster in state.program) {
      // Handle cluster with no campuses
      if (cluster.campuses.isEmpty) {
        data.add({
          'cluster': cluster.cluster,
          'campus': '',
          'college': '',
          'program': '',
          'major': '',
        });
        continue;
      }

      for (final campus in cluster.campuses) {
        // Handle campus with no colleges
        if (campus.colleges.isEmpty) {
          data.add({
            'cluster': cluster.cluster,
            'campus': campus.campusName,
            'college': '',
            'program': '',
            'major': '',
          });
          continue;
        }

        for (final college in campus.colleges) {
          // Handle college with no programs
          if (college.programs?.isEmpty ?? true) {
            data.add({
              'cluster': cluster.cluster,
              'campus': campus.campusName,
              'college': college.collegeName,
              'program': '',
              'major': '',
            });
            continue;
          }

          for (final program in college.programs!) {
            // Handle program with no majors
            if (program.majors?.isEmpty ?? true) {
              data.add({
                'cluster': cluster.cluster,
                'campus': campus.campusName,
                'college': college.collegeName,
                'program': program.programName,
                'major': '',
              });
            } else {
              // Add rows for each major
              for (final major in program.majors!) {
                data.add({
                  'cluster': cluster.cluster,
                  'campus': campus.campusName,
                  'college': college.collegeName,
                  'program': program.programName,
                  'major': major.majorName,
                });
              }
            }
          }
        }
      }
    }

    return data;
  }
}
