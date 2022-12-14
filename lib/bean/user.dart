/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Object {
  int? id;
  String? username;
  String? token;

  User(this.id, this.username, this.token);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
