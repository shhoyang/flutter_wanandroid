import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/knowledge.dart';
import 'package:flutter_wanandroid/page/knowledge/knowledge_article/knowledge_article_controller.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class KnowledgeArticlePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var knowledge = ModalRoute.of(context)?.settings.arguments as Knowledge?;
    return Scaffold(
      appBar: SimpleAppBar(knowledge?.showName ?? ""),
      body: GetBuilder<KnowledgeArticleController>(
          init: KnowledgeArticleController(knowledge?.id ?? 60),
          builder: (controller) {
            return SmartRefresher(
              controller: controller.refreshController,
              child: ArticleList(data: controller.data).build(context),
              header: MaterialClassicHeader(),
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoadMore,
            );
          }),
    );
  }
}
