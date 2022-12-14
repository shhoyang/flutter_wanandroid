/// @Author: Yang Shihao
/// @Date: 2021-01-08

import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/controller/base_list_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/state_manager.dart';

class WechatArticleController extends BaseListController<Article> with GetSingleTickerProviderStateMixin {
  final int authorId;

  WechatArticleController(this.authorId) : super();

  @override
  void loadData([int? page]) {
    DioManager().get(ApiService.getUrl(ApiService.wechatArticle, id: authorId, page: page), (data) {
      succeed(EntityFactory.generateList(data["datas"]));
    }, errorCallBack: (code, msg) {
      failed(code, msg);
    });
  }

  @override
  bool addUserStateListener() {
    return true;
  }
}
