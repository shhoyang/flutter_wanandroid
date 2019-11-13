import 'dart:async';

import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bean/project_type.dart';
import 'package:flutter_wanandroid/bloc/base_list_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc extends BaseListBloc<Article> {
  BehaviorSubject<List<ProjectType>> _projectTypeStreamController;

  ProjectBloc() : super() {
    _projectTypeStreamController = BehaviorSubject();
  }

  Stream<List<ProjectType>> get projectTypeStream =>
      _projectTypeStreamController.stream;

  Sink<List<ProjectType>> get _projectTypeSink =>
      _projectTypeStreamController.sink;

  @override
  int pageSize() {
    return 15;
  }

  @override
  void refresh() async {
    super.refresh();
    _getProjectType();
  }

  @override
  void loadData([int page]) async {
    DioManager.getInstance()
        .get(ApiService.getUrl(ApiService.NEW_PROJECT_ARTICLE, page: page - 1),
            (data) {
      List list = data["datas"];
      List<Article> temp = list.map((item) {
        return Article.fromJson(item);
      }).toList();
      succeed(temp);
    }, errorCallBack: (code, msg) {});
  }

  void _getProjectType() async {
    DioManager.getInstance().get(ApiService.getUrl(ApiService.PROJECT_TYPE),
        (data) {
      List list = data;
      var types = list.map((item) {
        return ProjectType.fromJson(item);
      }).toList();
      if (types != null && types.isNotEmpty) {
        _projectTypeSink.add(types);
      }
    }, errorCallBack: (code, msg) {});
  }

  @override
  void dispose() {
    super.dispose();
    _projectTypeStreamController?.close();
  }
}
