/// @Author: Yang Shihao
/// @Date: 2021-01-08

import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/knowledge.dart';
import 'package:flutter_wanandroid/controller/base_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';

class KnowledgeController extends BaseController {
  List<Knowledge> _data;
  List<Knowledge> get data => _data;

  List<Knowledge> _children = List();
  List<Knowledge> get children => _children;

  @override
  void loadData([int page]) async {
    DioManager.of().get(ApiService.getUrl(ApiService.knowledgeTree), (data) {
      _data = EntityFactory.generateList(data);
      _data.removeWhere((element) => element.children == null || element.children.isEmpty);
      if (_data.isEmpty) {
        update();
      } else {
        selected(_data[0]);
      }
    }, errorCallBack: (code, msg) {
      _data = [];
      update();
    });
  }

  void selected(Knowledge parent) {
    _data.forEach((element) {
      element.isSelected = element.id == parent.id;
      if (element.isSelected) {
        _children = element.children;
      }
    });
    update();
  }
}
