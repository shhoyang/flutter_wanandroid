import 'package:flutter_wanandroid/utils/reg_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_type.g.dart';

@JsonSerializable()
class ProjectType extends Object {
  int? id;
  String? name;

  ProjectType(
    this.id,
    this.name,
  );

  String get showName => RegUtils.removeSymbol(name);

  factory ProjectType.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectTypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectTypeToJson(this);
}
