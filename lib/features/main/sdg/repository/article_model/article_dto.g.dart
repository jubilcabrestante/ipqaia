// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => ArticleDto(
      id: json['id'] as String,
      sdg: json['sdg'] as String,
      title: json['title'] as String,
      link: json['link'] as String,
      year: json['year'] as String,
    );

Map<String, dynamic> _$ArticleDtoToJson(ArticleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sdg': instance.sdg,
      'title': instance.title,
      'link': instance.link,
      'year': instance.year,
    };
