// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleVm _$ArticleVmFromJson(Map<String, dynamic> json) => ArticleVm(
      sdg: json['sdg'] as String,
      title: json['title'] as String,
      link: json['link'] as String,
      year: json['year'] as String,
    );

Map<String, dynamic> _$ArticleVmToJson(ArticleVm instance) => <String, dynamic>{
      'sdg': instance.sdg,
      'title': instance.title,
      'link': instance.link,
      'year': instance.year,
    };
