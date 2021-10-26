/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Object {
  int id;
  String username;
  String token;
  String email;
  String icon;
  String extension;

  User(this.id, this.username, this.token, this.email, this.icon, this.extension);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
