class ApiService {
  static const String BASE = "https://www.wanandroid.com/";

  static const String BANNER = "banner";

  static const String WX_AUTHORS = "wxarticle/chapters";

  static const String WX_ARTICLES = "wxarticle/list";

  static const String PROJECT_TYPE = "project/tree";

  static const String NEW_PROJECT_ARTICLE = "article/listproject";

  static const String PROJECT_ARTICLE = "project/list";

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
