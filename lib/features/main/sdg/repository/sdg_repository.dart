import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipqaia/features/main/sdg/domain/i_sdg_repository.dart';
import 'package:ipqaia/features/main/sdg/repository/article_model/article_vm.dart';
import 'package:ipqaia/features/main/sdg/repository/sdg_model/sdg_vm.dart';

class SdgRepository implements ISdgRepository {
  final FirebaseFirestore _firestore;
  final String dbNameSdg;
  final String dbNameArticle;

  SdgRepository(
      {FirebaseFirestore? firestore,
      this.dbNameSdg = "sdg",
      this.dbNameArticle = "article"})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<SdgVm>> getSdg() async {
    try {
      final querySnapshot =
          await _firestore.collection(dbNameSdg).orderBy('sdgNumber').get();

      return querySnapshot.docs
          .map((doc) => SdgVm.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> addSdg(SdgVm sdg) async {
    try {
      final docRef = _firestore.collection(dbNameSdg).doc();
      final updatedSdg = sdg.copyWith(sdgId: docRef.id);
      await docRef.set(updatedSdg.toJson());
    } catch (e) {
      throw Exception('Failed to add SDG: $e');
    }
  }

  @override
  Future<void> updateSdg(SdgVm sdg) async {
    try {
      await _firestore.collection(dbNameSdg).doc(sdg.sdgId).update({
        ...sdg.toJson(),
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteReport(String sdgId) async {
    await _firestore.collection(dbNameSdg).doc(sdgId).delete();
  }

  @override
  Future<List<ArticleVm>> getArticles() async {
    try {
      final querySnapshot = await _firestore.collection(dbNameArticle).get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['articleId'] = doc.id;
        return ArticleVm.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addArticle(ArticleVm article) async {
    try {
      final docRef =
          await _firestore.collection(dbNameArticle).add(article.toJson());
      await docRef.update({'articleId': docRef.id});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateArticle(ArticleVm article) async {
    try {
      await _firestore
          .collection(dbNameArticle)
          .doc(article.articleId)
          .update(article.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteArticle(String articleId) async {
    try {
      await _firestore.collection(dbNameArticle).doc(articleId).delete();
    } catch (e) {
      throw e.toString();
    }
  }
}
