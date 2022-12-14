import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/ad.dart';
import 'package:flutter_wanandroid/bean/author.dart';
import 'package:flutter_wanandroid/controller/base_controller.dart';
import 'package:flutter_wanandroid/utils/entity_factory.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-08

class WechatController extends BaseController {
  List<Author>? _authors;

  List<Author>? get authors => _authors;

  List<Ad> _ad = [];

  List<Ad> get ad => _ad;

  @override
  void loadData([int? page]) {
    _getAd();
  }

  void _getAd() async {
    DioManager().get(ApiService.getUrl(ApiService.ad), (data) {
      List<Ad> list = EntityFactory.generateList(data);
      if (list.isNotEmpty) {
        _ad = list;
        _getAuthor();
      }
    }, errorCallBack: (code, msg) {
      _getAuthor();
    });
  }

  void _getAuthor() {
    DioManager().get(ApiService.getUrl(ApiService.authors), (data) {
      List<Author> list = EntityFactory.generateList(data);
      if (list.isNotEmpty) {
        _authors = list;
        update();
      }
    }, errorCallBack: (code, msg) {});
  }
}
