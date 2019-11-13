import 'package:flutter_wanandroid/bloc/base_bloc.dart';
import 'package:flutter_wanandroid/event/list_state.dart';
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
        ret = ListState.REFRESH |
            ListState.FAILED |
            ListState.NO_MORE |
            ListState.NO_DATA;
      } else if (data.isEmpty) {
        ret = ListState.REFRESH |
            ListState.SUCCEED |
            ListState.NO_MORE |
            ListState.NO_DATA;
      } else if (data.length < pageSize()) {
        ret = ListState.REFRESH | ListState.SUCCEED | ListState.NO_MORE;
      } else {
        ret = ListState.REFRESH | ListState.SUCCEED;
      }
      if (data != null && data.isNotEmpty) {
        _list.addAll(data);
      }
    } else {
      if (data == null) {
        ret = ListState.LOAD_MORE | ListState.FAILED;
      } else if (data.length < pageSize()) {
        ret = ListState.LOAD_MORE | ListState.SUCCEED | ListState.NO_MORE;
      } else {
        ret = ListState.LOAD_MORE | ListState.SUCCEED;
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
