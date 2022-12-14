import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListState {
  /// 刷新
  static const int refresh = 0x00000008;

  /// 加载，可不做运算
  static const int loadMore = 0;

  /// 成功
  static const int succeed = 0x00000004;

  /// 失败，可不做运算
  static const int failed = 0;

  /// 没有更多
  static const int noMore = 0x00000002;

  /// 无数据
  static const int noData = 0x00000001;

  static void setController(RefreshController refreshController, int state) {
    if (refresh & state > 0) {
      if (succeed & state > 0) {
        refreshController.refreshCompleted(resetFooterState: true);
        if ((noMore | noData) & state > 0) {
          refreshController.loadNoData();
        }
      } else {
        refreshController.refreshFailed();
        refreshController.loadNoData();
      }
    } else {
      if (succeed & state > 0) {
        if (noMore & state > 0) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        refreshController.loadFailed();
      }
    }
  }
}
