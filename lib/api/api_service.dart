class ApiService {
  static const String base = "https://www.wanandroid.com/";

  static const String ad = "banner";

  static const String authors = "wxarticle/chapters";

  static const String wechatArticle = "wxarticle/list";

  static const String projectTree = "project/tree";

  static const String projectNewArticle = "article/listproject";

  /// https://www.wanandroid.com/project/list/1/json?cid=294
  static const String projectArticle = "project/list";

  static const String knowledgeTree = "tree";

  /// https://www.wanandroid.com/article/list/0/json?cid=60
  static const String knowledgeArticle = "article/list";

  static const String hotSearch = "hotkey";

  /// https://www.wanandroid.com/article/query/0/json  k
  static const String search = "article/query";

  static const String login = "user/login";

  static const String register = "user/register";

  static String getUrl(String path, {int? id, int? page, bool isJson = true}) {
    StringBuffer sb = StringBuffer(path);

    if (id != null) {
      sb.write("/$id");
    }

    if (page != null) {
      sb.write("/$page");
    }

    if (isJson) {
      sb.write("/json");
    }

    return sb.toString();
  }
}
