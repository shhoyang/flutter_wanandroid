import 'package:flutter_wanandroid/controller/search_result_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class SearchResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchResultController>(() => SearchResultController());
  }
}
