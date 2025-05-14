import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/student_profile_model/student_profile_vm.dart';

abstract class IAcademicOfferingsRepository {
  Future<void> addStudentProfileMain(StudentProfileVm studentProfile);

  Future<void> addStudentProfileExternal(StudentProfileVm studentProfile);

  Future<void> addProgramMain(ProgramVm program);

  Future<void> addProgramExternal(ProgramVm program);

  Future<void> deleteStudentProfile(String studentProfileId);

  Future<void> deleteProgram(String programId);

  Future<List<StudentProfileVm>> getStudentProfilesMain();

  Future<List<StudentProfileVm>> getStudentProfilesExternal();

  Future<List<ProgramVm>> getProgramsMain();

  Future<List<ProgramVm>> getProgramsExternal();
}
