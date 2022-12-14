import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/page/search/search_result/search_result_controller.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-06

class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var keyWord = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: SimpleAppBar(keyWord ?? ""),
      body: GetBuilder<SearchResultController>(
        init: SearchResultController(keyWord ?? ""),
        builder: (controller) {
          return SmartRefresher(
            controller: controller.refreshController,
            child: ArticleList(data: controller.data, showChapter: true).build(context),
            header: MaterialClassicHeader(),
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoadMore,
          );
        },
      ),
    );
  }
}
