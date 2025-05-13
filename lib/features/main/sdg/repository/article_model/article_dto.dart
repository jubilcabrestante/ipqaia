import 'package:json_annotation/json_annotation.dart';

part 'article_dto.g.dart';

@JsonSerializable()
class ArticleDto {
  final String id;
  final String sdg;
  final String title;
  final String link;
  final String description;
  final DateTime year;

  const ArticleDto(
      {required this.id,
      required this.sdg,
      required this.title,
      required this.link,
      required this.description,
      required this.year});

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDtoToJson(this);
}
