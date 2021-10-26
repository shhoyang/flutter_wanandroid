/// @Author: Yang Shihao
/// @Date: 2021-01-08

import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/controller/base_list_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';
import 'package:get/get.dart';

class SearchResultController extends BaseListController<Article> {
  final String keyWord = Get.arguments;

  @override
  void loadData([int page]) async {
    DioManager.of().post(ApiService.getUrl(ApiService.search, page: page - 1), (data) {
      succeed(EntityFactory.generateList(data["datas"]));
    }, errorCallBack: (code, msg) {
      failed(code, msg);
    }, params: {"k": keyWord});
  }

  @override
  bool addUserStateListener() {
    return true;
  }
}
