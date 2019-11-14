import 'package:json_annotation/json_annotation.dart';

part 'hot_word.g.dart';

@JsonSerializable()
class HotWord extends Object {
  @JsonKey(name: 'name')
  String name;

  HotWord(
    this.name,
  );

  factory HotWord.fromJson(Map<String, dynamic> srcJson) =>
      _$HotWordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWordToJson(this);
}
