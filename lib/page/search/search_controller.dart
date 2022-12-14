import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/hot_word.dart';
import 'package:flutter_wanandroid/controller/base_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-08

class SearchController extends BaseController {
  TextEditingController contentController = TextEditingController();

  String get content => contentController.text.trim();

  List<HotWord> _data = [];

  List<HotWord> get data => _data;

  @override
  void loadData([int? page]) {
    DioManager().get(ApiService.getUrl(ApiService.hotSearch), (data) {
      _data = EntityFactory.generateList(data);
      update(["HotWord"]);
    }, errorCallBack: (code, msg) {
      _data = [];
      update(["HotWord"]);
    });
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
