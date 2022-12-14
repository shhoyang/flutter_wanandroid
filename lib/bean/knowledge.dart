import 'package:flutter_wanandroid/utils/reg_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'knowledge.g.dart';

@JsonSerializable()
class Knowledge extends Object {
  List<Knowledge>? children;
  int? id;
  String? name;
  bool isSelected = false;

  Knowledge(
    this.children,
    this.id,
    this.name,
  );

  String get showName => RegUtils.removeSymbol(name);

  factory Knowledge.fromJson(Map<String, dynamic> srcJson) =>
      _$KnowledgeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$KnowledgeToJson(this);
}
