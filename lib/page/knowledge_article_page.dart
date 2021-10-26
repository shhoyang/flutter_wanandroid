/// @Author: Yang Shihao
/// @Date: 2021-01-06

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/knowledge.dart';
import 'package:flutter_wanandroid/controller/knowledge_article_controller.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KnowledgeArticlePage extends GetView<KnowledgeArticleController> {
  @override
  Widget build(BuildContext context) {
    final Knowledge knowledge = Get.arguments;
    return Scaffold(
      appBar: SimpleAppBar(knowledge.showName),
      body: GetBuilder(
          init: controller,
          builder: (_) {
            return SmartRefresher(
              controller: _.refreshController,
              child: ArticleList(data: _.data).build(context),
              header: MaterialClassicHeader(),
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _.onRefresh,
              onLoading: _.onLoadMore,
            );
          }),
    );
  }
}
