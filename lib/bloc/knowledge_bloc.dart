import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/project_tree.dart';
import 'package:flutter_wanandroid/bloc/base_list_bloc.dart';

class KnowledgeBloc extends BaseListBloc<ProjectTree> {
  KnowledgeBloc() : super();

  @override
  void loadData([int page]) async {
    DioManager.getInstance().get(ApiService.getUrl(ApiService.tree), (data) {
      List list = data;
      List<ProjectTree> temp = list.map((item) {
        return ProjectTree.fromJson(item);
      }).toList();
      succeed(temp);
    }, errorCallBack: (code, msg) {
      failed(code, msg);
    });
  }
}
