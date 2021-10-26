// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Knowledge _$KnowledgeFromJson(Map<String, dynamic> json) {
  return Knowledge(
    (json['children'] as List)
        ?.map((e) =>
            e == null ? null : Knowledge.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] as int,
    json['name'] as String,
  )..isSelected = json['isSelected'] as bool;
}

Map<String, dynamic> _$KnowledgeToJson(Knowledge instance) => <String, dynamic>{
      'children': instance.children,
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };
