import 'package:json_annotation/json_annotation.dart';

part 'wx_author.g.dart';

@JsonSerializable()
class WxAuthor extends Object {
  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'parentChapterId')
  int parentChapterId;

  @JsonKey(name: 'userControlSetTop')
  bool userControlSetTop;

  @JsonKey(name: 'visible')
  int visible;

  WxAuthor(
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory WxAuthor.fromJson(Map<String, dynamic> srcJson) =>
      _$WxAuthorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WxAuthorToJson(this);
}
