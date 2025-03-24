import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipqaia/features/main/academic_offerings/domain/i_academic_offerings_repository.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/student_profile_model/student_profile_vm.dart';

class AcademicOfferingsRepository implements IAcademicOfferingsRepository {
  final FirebaseFirestore _firestore;
  final String dbNameStudentProfile;
  final String dbNameProgram;

  AcademicOfferingsRepository(FirebaseFirestore firestore,
      {this.dbNameStudentProfile = "student_profile",
      this.dbNameProgram = "program"})
      : _firestore = firestore;

  // ADD FUNCTION FOR ADD
  @override
  Future<void> addStudentProfile(StudentProfileVm studentProfile) async {
    try {
      await _firestore
          .collection(dbNameStudentProfile)
          .add(studentProfile.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> addProgram(ProgramVm program) async {
    try {
      await _firestore.collection(dbNameProgram).add(program.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  // ADD FUNCTION FOR DELETE
  @override
  Future<void> deleteStudentProfile(String studentProfileId) async {
    try {
      await _firestore
          .collection(dbNameStudentProfile)
          .doc(studentProfileId)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteProgram(String programId) async {
    try {
      await _firestore.collection(dbNameProgram).doc(programId).delete();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<StudentProfileVm>> getStudentProfiles() async {
    try {
      final snapshot = await _firestore.collection(dbNameStudentProfile).get();
      return snapshot.docs
          .map((doc) => StudentProfileVm.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ProgramVm>> getPrograms() async {
    try {
      final snapshot = await _firestore.collection(dbNameProgram).get();
      return snapshot.docs
          .map((doc) => ProgramVm.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
