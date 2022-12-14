import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/bean/project_type.dart';
import 'package:flutter_wanandroid/page/project/project_article/project_article_controller.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class ProjectArticlePage extends StatelessWidget {
  Widget build(BuildContext context) {
    var projectType =
        ModalRoute.of(context)?.settings.arguments as ProjectType?;
    return Scaffold(
      appBar: SimpleAppBar(projectType?.showName ?? ""),
      body: GetBuilder<ProjectArticleController>(
          init: ProjectArticleController(projectType?.id ?? 294),
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
