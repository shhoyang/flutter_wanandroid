/// @Author: Yang Shihao
/// @Date: 2021-01-13

import 'package:flutter_wanandroid/binding/binding.dart';
import 'package:flutter_wanandroid/page/pages.dart';
import 'package:flutter_wanandroid/routes/routes.dart';
import 'package:get/get.dart';

abstract class GetPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.TEXT,
      page: () => TextPage(),
    ),
    GetPage(
      name: Routes.PROJECT_ARTICLE,
      page: () => ProjectArticlePage(),
      binding: ProjectArticleBinding(),
    ),
    GetPage(
      name: Routes.KNOWLEDGE_ARTICLE,
      page: () => KnowledgeArticlePage(),
      binding: KnowledgeArticleBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_RESULT,
      page: () => SearchResultPage(),
      binding: SearchResultBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
