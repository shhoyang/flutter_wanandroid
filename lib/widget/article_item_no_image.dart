import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/utils/navigator_utils.dart';
import 'package:flutter_wanandroid/widget/space.dart';
import 'package:flutter_wanandroid/widget/text_styles.dart';

class ArticleItemNoImage extends StatefulWidget {

  final Article article;
  final VoidCallback onPressed;
  final VoidCallback onFavPressed;
  final bool showAuthor;

  ArticleItemNoImage({Key key,
    this.article,
    this.onPressed,
    this.onFavPressed,
    this.showAuthor = true})
      : super(key: key);

  @override
  _ArticleItemNoImageState createState() => _ArticleItemNoImageState();
}

class _ArticleItemNoImageState extends State<ArticleItemNoImage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                bottomRight: Radius.circular(16.0))),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.listTitle,
              ),
              Space.v8,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.article.niceDate,
                    style: TextStyles.listExtra,
                  ),
                  Space.h16,
                  Expanded(
                    child: widget.showAuthor
                        ? Text(
                      widget.article.chapterName.toString(),
                      style: TextStyles.listExtra,
                    )
                        : Container(),
                  ),
                  Space.h16,
                  InkWell(
                    child: Image.asset(
                      CommonUtils.getImage(
                          widget.article.collect ? "ic_fav_1" : "ic_fav_0"),
                      width: 32.0,
                      height: 32.0,
                    ),
                    onTap: widget.onFavPressed,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
//      onTap: () {
//        NavigatorUtils.pushWeb(context, article.title, article.link);
//      },
    );
  }
}