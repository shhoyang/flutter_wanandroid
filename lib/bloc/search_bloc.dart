import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/hot_word.dart';
import 'package:flutter_wanandroid/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc {
  List<HotWord> _list;

  BehaviorSubject<List<HotWord>> _streamController;

  SearchBloc() {
    _list = [];
    _streamController = BehaviorSubject();
  }

  Stream<List<HotWord>> get stream => _streamController.stream;

  Sink<List<HotWord>> get _sink => _streamController.sink;

  @override
  void loadData([int page]) async {
    DioManager.getInstance().get(ApiService.getUrl(ApiService.HOT_SEARCH), (data) {
      List list = data;
      List<HotWord> temp = list.map((item) {
        return HotWord.fromJson(item);
      }).toList();

      _list.clear();
      if (temp != null && temp.isNotEmpty) {
        _list.addAll(temp);
      }

      _sink.add(_list);
    });
  }

  @override
  void dispose() {
    _streamController?.close();
  }
}
