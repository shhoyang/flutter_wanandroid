import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author extends Object {
  int id;
  String name;
  int order;
  int visible;

  Author(
    this.id,
    this.name,
    this.order,
    this.visible,
  );

  factory Author.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
