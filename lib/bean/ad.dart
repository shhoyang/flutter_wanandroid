import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad extends Object {
  int? id;
  String? imagePath;
  String? title;
  String? url;

  Ad(
    this.id,
    this.imagePath,
    this.title,
    this.url,
  );

  factory Ad.fromJson(Map<String, dynamic> srcJson) => _$AdFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdToJson(this);
}
