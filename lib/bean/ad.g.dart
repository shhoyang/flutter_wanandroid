// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    json['id'] as int,
    json['imagePath'] as String,
    json['title'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'title': instance.title,
      'url': instance.url,
    };
