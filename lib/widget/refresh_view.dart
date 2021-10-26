/// @Author: Yang Shihao
/// @Date: 2021-01-12

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/controller/base_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshView<T extends BaseListController> extends SmartRefresher {
  RefreshView({Key key, @required T listController, @required Widget list})
      : super(
          key: key,
          controller: listController.refreshController,
          child: list,
          header: WaterDropHeader(),
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: listController.onRefresh,
          onLoading: listController.onLoadMore,
        );
}
