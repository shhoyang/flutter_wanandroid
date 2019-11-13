class ListState {
  /// 刷新
  static final int REFRESH = 0x1000;

  /// 加载，可不做运算
  static final int LOAD_MORE = 0;

  /// 成功
  static final int SUCCEED = 0x100;

  /// 失败，可不做运算
  static final int FAILED = 0;

  /// 没有更多
  static final int NO_MORE = 0x10;

  /// 无数据
  static final int NO_DATA = 0x1;

  /// 刷新成功
  static final int REFRESH_SUCCEED = 0x1100;

  /// 加载失败
  static final int LOAD_MORE_FAILED = 0;

  /// 无任何标记
  static final int EMPTY = 0;
}
