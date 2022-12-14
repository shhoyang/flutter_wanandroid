import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/page/wechat/wechat_article/wechat_article_controller.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class WechatArticlePage extends StatefulWidget {
  final int authorId;

  WechatArticlePage({Key? key, required this.authorId}) : super(key: key);

  @override
  _WechatArticlePageState createState() => _WechatArticlePageState();
}

class _WechatArticlePageState extends State<WechatArticlePage> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GetBuilder<WechatArticleController>(
        global: false,
        init: WechatArticleController(widget.authorId),
        builder: (controller) {
          return SmartRefresher(
            controller: controller.refreshController,
            child: ArticleList(data: controller.data, showAuthor: false).build(context),
            header: MaterialClassicHeader(),
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoadMore,
          );
        });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }
}
