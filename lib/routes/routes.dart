import 'package:flutter_wanandroid/page/pages.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-13

abstract class Routes {
  static const HOME = "home";
  static const TEXT = "text";
  static const PROJECT_ARTICLE = "project_article";
  static const KNOWLEDGE_ARTICLE = "knowledge_article";
  static const SEARCH_RESULT = "search_result";
  static const WEB = "web";
  static const LOGIN = "login";

  static final routes = {
    HOME: (_) => HomePage(),
    TEXT: (_) => TextPage(),
    PROJECT_ARTICLE: (_) => ProjectArticlePage(),
    KNOWLEDGE_ARTICLE: (_) => KnowledgeArticlePage(),
    SEARCH_RESULT: (_) => SearchResultPage(),
    WEB: (_) => WebPage(),
    LOGIN: (_) => LoginPage(),
  };
}
