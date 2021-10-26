/// @Author: Yang Shihao
/// @Date: 2021-01-08

/// @Author: Yang Shihao
/// @Date: 2021-01-08

import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bean/knowledge.dart';
import 'package:flutter_wanandroid/controller/base_list_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';
import 'package:get/get.dart';

class KnowledgeArticleController extends BaseListController<Article> {
  final Knowledge knowledge = Get.arguments;

  @override
  void loadData([int page]) async {
    DioManager.of().get(ApiService.getUrl(ApiService.knowledgeArticle, page: page - 1), (data) {
      succeed(EntityFactory.generateList(data["datas"]));
    }, errorCallBack: (code, msg) {
      failed(code, msg);
    }, params: {"cid": knowledge.id});
  }

  @override
  bool addUserStateListener() {
    return true;
  }
}
