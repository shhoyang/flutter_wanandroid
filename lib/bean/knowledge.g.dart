// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Knowledge _$KnowledgeFromJson(Map<String, dynamic> json) => Knowledge(
      (json['children'] as List<dynamic>?)
          ?.map((e) => Knowledge.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$KnowledgeToJson(Knowledge instance) => <String, dynamic>{
      'children': instance.children,
      'id': instance.id,
      'name': instance.name,
    };
