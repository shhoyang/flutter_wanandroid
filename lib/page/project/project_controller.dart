import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bean/project_type.dart';
import 'package:flutter_wanandroid/controller/base_list_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-08

class ProjectController extends BaseListController<Article> {
  List<ProjectType> _projectTypes = [];

  List<ProjectType> get projectTypes => _projectTypes;

  @override
  void onRefresh() async {
    DioManager().get(ApiService.getUrl(ApiService.projectTree), (data) {
      _projectTypes = EntityFactory.generateList(data);
      super.onRefresh();
    }, errorCallBack: (code, msg) {
      super.onRefresh();
    });
  }

  @override
  void loadData([int? page]) async {
    DioManager()
        .get(ApiService.getUrl(ApiService.projectNewArticle, page: page! - 1),
            (data) {
      succeed(EntityFactory.generateList(data["datas"]));
    }, errorCallBack: (code, msg) {
      failed(code, msg);
    });
  }

  @override
  int pageSize() => 15;

  @override
  bool addUserStateListener() {
    return true;
  }
}
