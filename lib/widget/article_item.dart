import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/widget/style/h_colors.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/style/h_radius.dart';
import 'package:flutter_wanandroid/widget/style/space.dart';
import 'package:flutter_wanandroid/widget/style/text_styles.dart';

class ArticleItem extends StatefulWidget {
  final Article article;
  final bool showAuthor;
  final bool showChapter;

  ArticleItem({
    Key key,
    this.article,
    this.showAuthor = true,
    this.showChapter = false,
  }) : super(key: key);

  @override
  _ArticleItemState createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return _buildItem(context, widget.article);
  }

  Widget _buildImage(Article article) {
    if (article.envelopePic == null || article.envelopePic.isEmpty) {
      return Container();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: CachedNetworkImage(
              imageUrl: article.envelopePic,
            ),
          ),
        ),
        Space.h16,
        Expanded(
          flex: 3,
          child: Text(
            article.desc,
            maxLines: 6,
            style: TextStyles.listSubtitle,
          ),
        ),
      ],
    );
  }

  Widget _buildExtra(BuildContext context, Article article) {
    Widget chapter;
    Widget author;
    Widget link;

    if (article.chapterName != null &&
        article.chapterName.isNotEmpty &&
        widget.showChapter) {
      chapter = Container(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
        child: Text(
          article.chapterName,
          style: TextStyle(color: HColors.white, fontSize: 10.0),
        ),
        decoration: BoxDecoration(
          color: HColors.tag,
          borderRadius: HRadius.r4,
        ),
      );
    }

    if (article.author != null &&
        article.author.isNotEmpty &&
        widget.showAuthor) {
      author = Text(article.author, style: TextStyles.listExtra);
    }

    if (article.projectLink != null && article.projectLink.isNotEmpty) {
      link = InkWell(
        child: Text(
          "项目链接",
          style: TextStyle(
            color: HColors.link,
            fontSize: 12.0,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () {
          NavigatorUtils.pushWeb(context, article.title, article.projectLink);
        },
      );
    }

    List<Widget> list = [];

    if (chapter != null) {
      list.add(chapter);
      list.add(Space.h8);
    }

    list.add(Text(
      article.niceDate,
      style: TextStyles.listExtra,
    ));
    list.add(Space.h8);

    if (author != null) {
      list.add(author);
      list.add(Space.h8);
    }

    list.add(Expanded(child: Container()));

    if (link != null) {
      list.add(link);
      list.add(Space.h8);
    }

    list.add(InkWell(
      child: Image.asset(
        CommonUtils.getImage(article.collect ? "icon_fav_ed" : "icon_fav_un"),
        width: 32.0,
        height: 32.0,
      ),
      onTap: () {},
    ));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: list,
    );
  }

  Widget _buildItem(BuildContext context, Article article) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 标题
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.listTitle,
              ),
              Space.v8,
              // 图片
              _buildImage(article),
              // 底部
              _buildExtra(context, article),
            ],
          ),
        ),
      ),
      onTap: () {
        NavigatorUtils.pushWeb(context, article.title, article.link);
      },
    );
  }
}
