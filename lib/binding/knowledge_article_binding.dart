import 'package:flutter_wanandroid/controller/knowledge_article_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class KnowledgeArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KnowledgeArticleController>(() => KnowledgeArticleController());
  }
}
