import 'package:flutter_wanandroid/utils/reg_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Object {
  String? author;
  String? chapterName;
  bool? collect;
  String? desc;
  String? envelopePic;
  int? id;
  String? link;
  String? niceDate;
  String? origin;
  String? projectLink;
  String? title;

  Article(
    this.author,
    this.chapterName,
    this.collect,
    this.desc,
    this.envelopePic,
    this.id,
    this.link,
    this.niceDate,
    this.origin,
    this.projectLink,
    this.title,
  );

  String get showTitle => RegUtils.removeSymbol(title);

  String get showDesc => RegUtils.removeSymbol(desc);

  factory Article.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
