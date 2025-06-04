import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipqaia/features/main/academic_offerings/domain/i_academic_offerings_repository.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/program_model/program_vm.dart';
import 'package:ipqaia/features/main/academic_offerings/repository/student_profile_model/student_profile_vm.dart';
import 'package:ipqaia/talker_service.dart';

class AcademicOfferingsRepository implements IAcademicOfferingsRepository {
  final FirebaseFirestore _firestore;
  final String dbNameStudentProfile;
  final String dbNameProgram;

  AcademicOfferingsRepository(
      {FirebaseFirestore? firestore,
      this.dbNameStudentProfile = "student_profile",
      this.dbNameProgram = "program"})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // ADD FUNCTION FOR ADD
  @override
  Future<void> addStudentProfileMain(StudentProfileVm studentProfile) async {
    try {
      await _firestore
          .collection(dbNameStudentProfile)
          .add(studentProfile.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> addProgramMain(ProgramVm program) async {
    try {
      final docRef = _firestore.collection(dbNameProgram).doc(program.id);
      final existingDoc = await docRef.get();

      if (existingDoc.exists) {
        await _updateExistingProgram(docRef, existingDoc.data()!, program);
      } else {
        final data = _programToMap(program);
        data["id"] = program.id ?? docRef.id;
        await docRef.set(data); // Removed lowercase conversion here
      }

      TalkerService.talker.log("Saved program: ${program.toString()}");
    } catch (e) {
      TalkerService.talker.log("Error saving program: $e");
      throw e.toString();
    }
  }

  Future<void> _updateExistingProgram(DocumentReference docRef,
      Map<String, dynamic> existingData, ProgramVm newProgram) async {
    // Convert both to maps
    final existingMap = existingData;
    final newMap = _programToMap(newProgram);

    // Merge campuses
    final mergedCampuses = _mergeNestedArrays(
        existingMap['campuses'] ?? [], newMap['campuses'] ?? [], 'campusName');

    await docRef.update({
      'cluster': newMap['cluster'],
      'campuses': mergedCampuses,
    });
  }

  List<dynamic> _mergeNestedArrays(
      List<dynamic> existingArray, List<dynamic> newArray, String matchKey) {
    final result = List<dynamic>.from(existingArray);

    for (final newItem in newArray) {
      final existingIndex =
          result.indexWhere((item) => item[matchKey] == newItem[matchKey]);

      if (existingIndex >= 0) {
        result[existingIndex] = {
          ...(result[existingIndex] as Map<String, dynamic>),
          ...(newItem as Map<String, dynamic>),
        };
      } else {
        result.add(newItem);
      }
    }

    return result;
  }

  Map<String, dynamic> _programToMap(ProgramVm program) {
    return {
      'id': program.id,
      'cluster': program.cluster,
      'campuses': program.campuses.map((campus) {
        return {
          'campusName': campus.campusName,
          'colleges': campus.colleges.map((college) {
            return {
              'collegeName': college.collegeName,
              'programs': college.programs?.map((program) {
                return {
                  'programName': program.programName,
                  'majors': program.majors
                      ?.map((major) => {'name': major.majorName})
                      .toList(),
                };
              }).toList(),
            };
          }).toList(),
        };
      }).toList(),
    };
  }

  @override
  Future<List<ProgramVm>> getPrograms() async {
    try {
      final snapshot = await _firestore.collection(dbNameProgram).get();

      // Convert Firestore documents to ProgramVm objects
      return snapshot.docs.map((doc) {
        final data = doc.data();

        TalkerService.talker.debug(data.toString());
        return ProgramVm(
          id: doc.id,
          cluster: data['cluster'],
          campuses: _parseCampuses(data['campuses']),
        );
      }).toList();
    } catch (e) {
      TalkerService.talker.log("Error getting programs: $e");
      throw e.toString();
    }
  }

  List<Campus>? _parseCampuses(dynamic campusesData) {
    if (campusesData is! List) return null;

    return campusesData.map((campus) {
      return Campus(
        campusName: campus['campusName'] ?? '',
        colleges: _parseColleges(campus['colleges']),
      );
    }).toList();
  }

  List<College>? _parseColleges(dynamic collegesData) {
    if (collegesData is! List) return null;

    return collegesData.map((college) {
      return College(
        collegeName: college['collegeName'] ?? '',
        programs: _parsePrograms(college['programs']),
      );
    }).toList();
  }

  List<Program>? _parsePrograms(dynamic programsData) {
    if (programsData is! List) return null;

    return programsData.map((program) {
      return Program(
        programName: program['programName'] ?? '',
        majors: _parseMajors(program['majors']),
      );
    }).toList();
  }

  List<Major>? _parseMajors(dynamic majorsData) {
    if (majorsData is! List) return null;

    return majorsData.map((major) {
      return Major(
        majorName: major['majorName'] ?? '',
      );
    }).toList();
  }

  @override
  Future<void> deleteMajor(
    String programId,
    String campusName,
    String collegeName,
    String programName,
    String majorName,
  ) async {
    try {
      final docRef = _firestore.collection(dbNameProgram).doc(programId);
      final snapshot = await docRef.get();

      if (!snapshot.exists) throw 'Program not found';

      final data = snapshot.data()!;
      final campuses = data['campuses'] as List<dynamic>;

      for (var campus in campuses) {
        if (campus['campusName'] == campusName) {
          for (var college in campus['colleges']) {
            if (college['collegeName'] == collegeName) {
              final programs = college['programs'] as List<dynamic>;
              for (var program in programs) {
                if (program['programName'] == programName) {
                  final majors = program['majors'] as List<dynamic>;
                  program['majors'] = majors
                      .where((major) => major['name'] != majorName)
                      .toList();
                }
              }
            }
          }
        }
      }

      await docRef.update({'campuses': campuses});
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
  Future<List<StudentProfileVm>> getStudentProfilesMain() async {
    try {
      final snapshot = await _firestore.collection(dbNameStudentProfile).get();
      return snapshot.docs
          .map((doc) => StudentProfileVm.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
