import 'package:flutter_wanandroid/controller/project_article_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ProjectArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectArticleController>(() => ProjectArticleController());
  }
}
