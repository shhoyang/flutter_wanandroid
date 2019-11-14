class ApiService {
  static const String BASE = "https://www.wanandroid.com/";

  static const String BANNER = "banner";

  static const String WX_AUTHORS = "wxarticle/chapters";

  static const String WX_ARTICLE_LIST = "wxarticle/list";

  static const String PROJECT_TREE = "project/tree";

  static const String PROJECT_NEW_LIST = "article/listproject";

  /// https://www.wanandroid.com/project/list/1/json?cid=294
  static const String PROJECT_LIST = "project/list";

  static const String TREE = "tree";

  /// https://www.wanandroid.com/article/list/0/json?cid=60
  static const String TREE_PROJECT_LIST = "article/list";

  static const String HOT_SEARCH = "hotkey";

  /// https://www.wanandroid.com/article/query/0/json  k
  static const String SEARCH = "article/query";

  static String getUrl(String path, {int id, int page}) {
    StringBuffer sb = StringBuffer(BASE);

    sb.write(path);

    if (id != null) {
      sb.write("/$id");
    }

    if (page != null) {
      sb.write("/$page");
    }

    sb.write("/json");

    return sb.toString();
  }
}
