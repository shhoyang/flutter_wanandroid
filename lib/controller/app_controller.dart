import 'package:flutter_wanandroid/bean/user.dart';
import 'package:flutter_wanandroid/controller/base_controller.dart';
import 'package:get/state_manager.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-15

class AppController extends BaseController {
  User _user;

  User get user => _user;

  final isLogin = RxBool(false);

  final doRefresh = RxInt(0);

  @override
  void loadData([int page]) {
    doRefresh.value++;
  }
}
