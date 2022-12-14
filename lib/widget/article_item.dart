import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/constant/strings.dart';
import 'package:flutter_wanandroid/constant/images.dart';
import 'package:flutter_wanandroid/style/style.dart';
import 'package:flutter_wanandroid/routes/navigator_utils.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final bool showAuthor;
  final bool showChapter;

  ArticleItem({
    Key? key,
    required this.article,
    this.showAuthor = true,
    this.showChapter = false,
  }) : super(key: key);

  Widget _buildExtra(BuildContext context, Article article) {
    Widget? chapter;
    Widget? author;
    Widget? link;

    if (article.chapterName != null && article.chapterName!.isNotEmpty && showChapter) {
      chapter = Container(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
        child: Text(article.chapterName!, style: TextStyles.caption(context).copyWith(color: HColors.white, fontSize: 10.0)),
        decoration: BoxDecoration(color: HColors.tag, borderRadius: HRadius.r4),
      );
    }

    if (article.author != null && article.author!.isNotEmpty && showAuthor) {
      author = Text(article.author!, style: TextStyles.caption(context));
    }

    if (article.projectLink != null && article.projectLink!.isNotEmpty) {
      link = InkWell(
        child: Text(
          Strings.link,
          style: TextStyles.caption(context).copyWith(color: HColors.textLink, decoration: TextDecoration.underline),
        ),
        onTap: () {
          NavigatorUtils.pushWeb(context, article.showTitle, article.projectLink!);
        },
      );
    }

    List<Widget> children = [];

    if (chapter != null) {
      children.add(chapter);
      children.add(Space.h8);
    }

    if (author != null) {
      children.add(author);
      children.add(Space.h8);
    }

    children.add(
      Text(
        article.niceDate!,
        style: TextStyles.caption(context),
      ),
    );

    children.add(Expanded(child: Container()));

    if (link != null) {
      children.add(link);
      children.add(Space.h8);
    }

    children.add(
      InkWell(
        child: SvgPicture.asset(
          article.collect == true ? Images.iconFavoriteEd : Images.iconFavoriteUn,
          width: 24.0,
          height: 24.0,
          color: article.collect == true ? HColors.favoriteEd : HColors.favoriteUn,
        ),
        onTap: () {},
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: children,
    );
  }

  /// 不带图片
  List<Widget> _buildItemNoImage(BuildContext context, Article article) {
    List<Widget> children = [];
    children.add(
      Text(
        article.showTitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.title1(context),
      ),
    );
    children.add(Space.v8);
    if (article.desc != null && article.desc!.isNotEmpty) {
      children.add(
        Text(
          article.showDesc,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.subtitle1(context),
        ),
      );
      children.add(Space.v8);
    }

    children.add(_buildExtra(context, article));
    return children;
  }

  /// 带图片
  List<Widget> _buildItemWithImage(BuildContext context, Article article) {
    List<Widget> children = [];
    children.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: CachedNetworkImage(
                imageUrl: article.envelopePic!,
              ),
            ),
          ),
          Space.h8,
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.showTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.title1(context),
                ),
                Space.v8,
                Text(
                  article.showDesc,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.subtitle1(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    children.add(Space.v8);
    children.add(_buildExtra(context, article));
    return children;
  }

  Widget _buildItem(BuildContext context, Article article) {
    List<Widget> children;
    if (article.envelopePic == null || article.envelopePic!.isEmpty) {
      children = _buildItemNoImage(context, article);
    } else {
      children = _buildItemWithImage(context, article);
    }

    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(8.0),
        color: HColors.grayWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
      onTap: () {
        NavigatorUtils.pushWeb(context, article.showTitle, article.link!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildItem(context, article);
  }
}
