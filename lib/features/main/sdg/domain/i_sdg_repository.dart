import 'package:ipqaia/features/main/sdg/repository/article_model/article_vm.dart';
import 'package:ipqaia/features/main/sdg/repository/sdg_model/sdg_vm.dart';

abstract class ISdgRepository {
  Future<List<SdgVm>> getSdg();
  Future<void> addSdg(SdgVm sdg);
  Future<void> updateSdg(SdgVm sdg);
  Future<void> deleteReport(String sdgId);

  // New article methods
  Future<List<ArticleVm>> getArticles();
  Future<void> addArticle(ArticleVm article);
  Future<void> updateArticle(ArticleVm article);
  Future<void> deleteArticle(String articleId);
}
