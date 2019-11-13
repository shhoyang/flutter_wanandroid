import 'dart:async';

import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/banner_item.dart';
import 'package:flutter_wanandroid/bean/wx_author.dart';
import 'package:flutter_wanandroid/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class WechatBloc extends BaseBloc {
  List<WxAuthor> _list;

  BehaviorSubject<List<BannerItem>> _bannerStreamController;
  BehaviorSubject<List<WxAuthor>> _authorsStreamController;

  WechatBloc() {
    _list = [];
    _bannerStreamController = BehaviorSubject();
    _authorsStreamController = BehaviorSubject();
  }

  Stream<List<BannerItem>> get bannerStream => _bannerStreamController.stream;

  Sink<List<BannerItem>> get _bannerSink => _bannerStreamController.sink;

  Stream<List<WxAuthor>> get authorsStream => _authorsStreamController.stream;

  Sink<List<WxAuthor>> get _authorsSink => _authorsStreamController.sink;

  @override
  void loadData([int page]) async {
    _getBanner();
    DioManager.getInstance().get(ApiService.getUrl(ApiService.WX_AUTHORS), (data) {
      List list = data;
      _list = list.map((item) {
        return WxAuthor.fromJson(item);
      }).toList();
      _authorsSink.add(_list);
    }, errorCallBack: (code, msg) {});
  }

  void _getBanner() async {
    DioManager.getInstance().get(ApiService.getUrl(ApiService.BANNER), (data) {
      List list = data;
      var banners = list.map((item) {
        return BannerItem.fromJson(item);
      }).toList();
      if (banners != null && banners.isNotEmpty) {
        _bannerSink.add(banners);
      }
    }, errorCallBack: (code, msg) {});
  }

  @override
  void dispose() {
    _bannerStreamController?.close();
    _authorsStreamController?.close();
  }
}
