import 'dart:async';
import 'package:flutter_wanandroid/controller/user_manager_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_controller.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-08

abstract class BaseListController<T> extends BaseController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  StreamSubscription? userStateSubscription;

  /// 是否正在刷新中
  bool _refreshing = false;

  /// 是否正在加载中
  bool _loading = false;
  int _page = 1;
  List<T>? _data;

  List<T>? get data => _data;

  @override
  void onInit() {
    if (addUserStateListener()) {
      userStateSubscription = UserManagerController().userStateChange.listen((_) {
        onRefresh();
      });
    }
    super.onInit();
  }

  @override
  void onClose() {
    userStateSubscription?.cancel();
    refreshController.dispose();
    super.onClose();
  }

  // @mustCallSuper
  void onRefresh() async {
    if (_refreshing) {
      return;
    }

    _refreshing = true;
    _page = 1;
    loadData(_page);
  }

  void onLoadMore() async {
    if (_loading) {
      return;
    }
    _loading = true;
    loadData(_page + 1);
  }

  void succeed(List<T>? data) {
    if (_data == null) {
      _data = [];
    }
    if (_refreshing) {
      _refreshing = false;
      if (data == null) {
        refreshController.loadNoData();
        refreshController.refreshFailed();
      } else if (data.length < pageSize()) {
        refreshController.loadNoData();
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshCompleted(resetFooterState: true);
      }
      _data!.clear();
    } else if (_loading) {
      _refreshing = false;
      if (data == null) {
        refreshController.loadFailed();
      } else if (data.length < pageSize()) {
        _page++;
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
        _page++;
      }
    }

    if (data != null && data.isNotEmpty) {
      _data!.addAll(data);
    }
    update();
  }

  void failed(int code, String msg) {
    succeed(null);
  }

  int pageSize() {
    return 20;
  }

  bool addUserStateListener() {
    return false;
  }
}
