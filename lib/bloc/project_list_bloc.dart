import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bloc/base_list_bloc.dart';

class ProjectListBloc extends BaseListBloc<Article> {
  final int typeId;

  ProjectListBloc(this.typeId) : super();

  @override
  void loadData([int page]) async {
    DioManager.getInstance()
        .get(ApiService.getUrl(ApiService.projectList, page: page), (data) {
      List list = data["datas"];
      List<Article> temp = list.map((item) {
        return Article.fromJson(item);
      }).toList();
      succeed(temp);
    }, errorCallBack: (code, msg) {
      failed(code, msg);
    }, params: {"cid": typeId});
  }
}
