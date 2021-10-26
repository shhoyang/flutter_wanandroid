import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/widget/article_item.dart';
import 'package:flutter_wanandroid/widget/state/empty_view.dart';
import 'package:flutter_wanandroid/widget/state/loading_view.dart';

class ArticleList {
  final List<Article> data;
  final bool showAuthor;
  final bool showChapter;

  ArticleList(
      {@required this.data, this.showAuthor = true, this.showChapter = false});

  Widget build(BuildContext context) {
    if (data == null) {
      return LoadingView();
    }

    if (data.isEmpty) {
      return EmptyView();
    }

    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return ArticleItem(
          article: data[index],
          showAuthor: showAuthor,
          showChapter: showChapter,
        );
      },
    );
  }
}
