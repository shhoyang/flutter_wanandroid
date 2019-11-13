import 'package:json_annotation/json_annotation.dart';

part 'project_type.g.dart';

@JsonSerializable()
class ProjectType extends Object {
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

  ProjectType(
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory ProjectType.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectTypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectTypeToJson(this);
}
