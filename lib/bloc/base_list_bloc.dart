import 'package:flutter_wanandroid/bloc/base_bloc.dart';
import 'package:flutter_wanandroid/utils/list_state.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseListBloc<T> extends BaseBloc {
  bool _isRefresh = true;

  int _page = 1;

  List<T> _list;

  BehaviorSubject<List<T>> _streamController;

  BehaviorSubject<int> _stateStreamController;

  Stream<List<T>> get stream => _streamController.stream;

  Sink<List<T>> get _sink => _streamController.sink;

  Stream<int> get stateStream => _stateStreamController.stream;

  Sink<int> get _stateSink => _stateStreamController.sink;

  BaseListBloc() {
    _list = [];
    _streamController = BehaviorSubject();
    _stateStreamController = BehaviorSubject();
  }

  void refresh() async {
    _isRefresh = true;
    _page = 1;
    _list.clear();
    loadData(_page);
  }

  void loadMore() async {
    _isRefresh = false;
    loadData(_page + 1);
  }

  void succeed(List<T> data) {
    int ret;
    if (_isRefresh) {
      if (data == null) {
        ret = ListState.refresh |
            ListState.failed |
            ListState.noMore |
            ListState.noData;
      } else if (data.isEmpty) {
        ret = ListState.refresh |
            ListState.succeed |
            ListState.noMore |
            ListState.noData;
      } else if (data.length < pageSize()) {
        ret = ListState.refresh | ListState.succeed | ListState.noMore;
      } else {
        ret = ListState.refresh | ListState.succeed;
      }
      if (data != null && data.isNotEmpty) {
        _list.addAll(data);
      }
    } else {
      if (data == null) {
        ret = ListState.loadMore | ListState.failed;
      } else if (data.length < pageSize()) {
        ret = ListState.loadMore | ListState.succeed | ListState.noMore;
      } else {
        ret = ListState.loadMore | ListState.succeed;
      }
      if (data != null && data.isNotEmpty) {
        _list.addAll(data);
      }
    }

    _stateSink.add(ret);
    _sink.add(_list);
    if (!_isRefresh) {
      _page++;
    }
  }

  void failed(int code, String msg) {
    succeed(null);
  }

  int pageSize() {
    return 20;
  }

  @override
  void dispose() {
    _streamController?.close();
    _stateStreamController?.close();
  }
}
