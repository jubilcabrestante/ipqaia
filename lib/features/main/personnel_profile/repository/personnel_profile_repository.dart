import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipqaia/features/main/personnel_profile/repository/models/personel_profile_vm.dart';

class PPRepository {
  final FirebaseFirestore _firestore;
  final String dbName;

  // Constructor to initialize FirebaseFirestore and collection names
  PPRepository(
    this._firestore, {
    this.dbName = "personnel_profile",
  });

  // Add a new PP document to Firestore
  Future<void> add(Map<String, dynamic> pp) async {
    try {
      await _firestore.collection(dbName).add(pp);
    } catch (e, stackTrace) {
      throw Exception("Failed to add PPR: $e\n$stackTrace");
    }
  }

  // Delete a report document from Firestore
  Future<void> deletePersonnelProfile(String uid) async {
    try {
      await _firestore.collection(dbName).doc(uid).delete();
    } catch (e, stackTrace) {
      throw Exception("Failed to delete Report: $e\n$stackTrace");
    }
  }

  Future<List<PersonnelVm>> getpp(String selectedType) async {
    try {
      final querySnapshot = await _firestore.collection(dbName).get();

      return querySnapshot.docs
          .map((doc) => PersonnelVm.fromJson(doc.data()))
          .toList();
    } catch (e, stacktrace) {
      print('Error in getpp: $e\n$stacktrace');
      rethrow;
    }
  }
}
