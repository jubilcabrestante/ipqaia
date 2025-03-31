import 'package:ipqaia/features/main/sdg/repository/article_model/article_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_vm.g.dart';

@JsonSerializable()
class ArticleVm {
  final String articleId;
  final String sdg;
  final String title;
  final String link;
  final String year;

  const ArticleVm(
      {required this.articleId,
      required this.sdg,
      required this.title,
      required this.link,
      required this.year});

  factory ArticleVm.fromDto(ArticleDto dto) {
    return ArticleVm(
        sdg: dto.sdg,
        title: dto.title,
        link: dto.link,
        year: dto.year,
        articleId: dto.id);
  }

  factory ArticleVm.fromJson(Map<String, dynamic> json) =>
      _$ArticleVmFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleVmToJson(this);
}
