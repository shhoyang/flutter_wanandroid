import 'package:json_annotation/json_annotation.dart';

part 'hot_word.g.dart';

@JsonSerializable()
class HotWord extends Object {
  int? id;
  String? name;

  HotWord(
    this.id,
    this.name,
  );

  factory HotWord.fromJson(Map<String, dynamic> srcJson) =>
      _$HotWordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWordToJson(this);
}
