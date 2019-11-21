class ApiService {
  static const String base = "https://www.wanandroid.com/";

  static const String banner = "banner";

  static const String wxAuthors = "wxarticle/chapters";

  static const String wxArticleList = "wxarticle/list";

  static const String projectTree = "project/tree";

  static const String projectNewList = "article/listproject";

  /// https://www.wanandroid.com/project/list/1/json?cid=294
  static const String projectList = "project/list";

  static const String tree = "tree";

  /// https://www.wanandroid.com/article/list/0/json?cid=60
  static const String treeProjectList = "article/list";

  static const String hotSearch = "hotkey";

  /// https://www.wanandroid.com/article/query/0/json  k
  static const String search = "article/query";

  static const String login = "user/login";

  static const String register = "user/register";

  static String getUrl(String path, {int id, int page, bool isJson = true}) {
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
