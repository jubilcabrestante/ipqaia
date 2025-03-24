import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipqaia/features/main/sdg/domain/i_sdg_repository.dart';
import 'package:ipqaia/features/main/sdg/repository/sdg_model/sdg_vm.dart';

class SdgRepository implements ISdgRepository {
  final FirebaseFirestore _firestore;
  final String dbName;

  SdgRepository({required FirebaseFirestore firestore, this.dbName = "sdg"})
      : _firestore = firestore;

  @override
  Future<List<SdgVm>> getSdg(String selectedType) async {
    try {
      final querySnapshot = await _firestore
          .collection(dbName)
          .where('type', isEqualTo: selectedType)
          .get();

      return querySnapshot.docs
          .map((doc) => SdgVm.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<SdgVm>> addSdg(String selectedType) async {
    try {
      final querySnapshot = await _firestore
          .collection(dbName)
          .where('type', isEqualTo: selectedType)
          .get();
      return querySnapshot.docs
          .map((doc) => SdgVm.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateSdg(SdgVm sdg) async {
    try {
      await _firestore.collection(dbName).doc(sdg.sdgId).update({
        ...sdg.toJson(),
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteReport(String sdgId) async {
    await _firestore.collection(dbName).doc(sdgId).delete();
  }
}
