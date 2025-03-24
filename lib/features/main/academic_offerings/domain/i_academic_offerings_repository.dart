import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/student_profile_model/student_profile_vm.dart';

abstract class IAcademicOfferingsRepository {
  Future<void> addStudentProfile(StudentProfileVm studentProfile);

  Future<void> addProgram(ProgramVm program);

  Future<void> deleteStudentProfile(String studentProfileId);

  Future<void> deleteProgram(String programId);

  Future<List<StudentProfileVm>> getStudentProfiles();
  Future<List<ProgramVm>> getPrograms();
}
