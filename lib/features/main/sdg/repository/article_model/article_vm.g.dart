// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleVm _$ArticleVmFromJson(Map<String, dynamic> json) => ArticleVm(
      sdg: json['sdg'] as String?,
      articleId: json['articleId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      link: json['link'] as String,
      year: DateTime.parse(json['year'] as String),
    );

Map<String, dynamic> _$ArticleVmToJson(ArticleVm instance) => <String, dynamic>{
      'articleId': instance.articleId,
      'sdg': instance.sdg,
      'title': instance.title,
      'link': instance.link,
      'description': instance.description,
      'year': instance.year.toIso8601String(),
    };
