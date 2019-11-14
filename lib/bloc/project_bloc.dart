import 'dart:async';

import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bean/project_tree.dart';
import 'package:flutter_wanandroid/bloc/base_list_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc extends BaseListBloc<Article> {
  BehaviorSubject<List<ProjectTree>> _projectTreeStreamController;

  ProjectBloc() : super() {
    _projectTreeStreamController = BehaviorSubject();
  }

  Stream<List<ProjectTree>> get projectTreeStream =>
      _projectTreeStreamController.stream;

  Sink<List<ProjectTree>> get _projectTreeSink =>
      _projectTreeStreamController.sink;

  @override
  int pageSize() => 15;

  @override
  void refresh() async {
    super.refresh();
    _getProjectTree();
  }

  @override
  void loadData([int page]) async {
    DioManager.getInstance()
        .get(ApiService.getUrl(ApiService.PROJECT_NEW_LIST, page: page - 1),
            (data) {
      List list = data["datas"];
      List<Article> temp = list.map((item) {
        return Article.fromJson(item);
      }).toList();
      succeed(temp);
    }, errorCallBack: (code, msg) {});
  }

  void _getProjectTree() async {
    DioManager.getInstance().get(ApiService.getUrl(ApiService.PROJECT_TREE),
        (data) {
      List list = data;
      var types = list.map((item) {
        return ProjectTree.fromJson(item);
      }).toList();
      if (types != null && types.isNotEmpty) {
        _projectTreeSink.add(types);
      }
    }, errorCallBack: (code, msg) {});
  }

  @override
  void dispose() {
    _projectTreeStreamController?.close();
    super.dispose();
  }
}
