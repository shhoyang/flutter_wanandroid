import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/space.dart';
import 'package:flutter_wanandroid/widget/text_styles.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final VoidCallback onPressed;
  final VoidCallback onFavPressed;
  final bool showAuthor;

  ArticleItem(
      {Key key,
      this.article,
      this.onPressed,
      this.onFavPressed,
      this.showAuthor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.listTitle,
              ),
              Space.v8,
              Row(
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    article.niceDate,
                    style: TextStyles.listExtra,
                  ),
                  Space.h16,
                  Expanded(
                    child: showAuthor
                        ? Text(
                            article.author,
                            style: TextStyles.listExtra,
                          )
                        : Container(),
                  ),
                  Space.h16,
                  InkWell(
                    child: Text(
                      "项目链接",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 12.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      NavigatorUtils.pushWeb(
                          context, article.title, article.projectLink);
                    },
                  ),
                  Space.h16,
                  InkWell(
                    child: Image.asset(
                      CommonUtils.getImage(
                          article.collect ? "ic_fav_1" : "ic_fav_0"),
                      width: 32.0,
                      height: 32.0,
                    ),
                    onTap: onFavPressed,
                  ),
                ],
              ),
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
