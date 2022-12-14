// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      json['author'] as String?,
      json['chapterName'] as String?,
      json['collect'] as bool?,
      json['desc'] as String?,
      json['envelopePic'] as String?,
      json['id'] as int?,
      json['link'] as String?,
      json['niceDate'] as String?,
      json['origin'] as String?,
      json['projectLink'] as String?,
      json['title'] as String?,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'author': instance.author,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'projectLink': instance.projectLink,
      'title': instance.title,
    };
