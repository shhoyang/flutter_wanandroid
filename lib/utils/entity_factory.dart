import 'package:flutter_wanandroid/bean/bean.dart';

/// @Author: Yang Shihao
/// @Date: 2021-01-15

class EntityFactory {
  static T? generateEntity<T>(json) {
    if (json == null) {
      return null;
    }

    T? t;

    switch (T.toString()) {
      case "Ad":
        t = Ad.fromJson(json) as T;
        break;
      case "Article":
        t = Article.fromJson(json) as T;
        break;
      case "Author":
        t = Author.fromJson(json) as T;
        break;
      case "HotWord":
        t = HotWord.fromJson(json) as T;
        break;
      case "Knowledge":
        t = Knowledge.fromJson(json) as T;
        break;
      case "ProjectType":
        t = ProjectType.fromJson(json) as T;
        break;
      case "User":
        t = User.fromJson(json) as T;
        break;
      default:
        t = null;
        break;
    }

    return t;
  }

  static List<T> generateList<T>(List? data) {
    if (data == null || data.isEmpty) {
      return [];
    }

    var ret = <T>[];
    data.forEach((item) {
      T? t = generateEntity<T>(item);
      if (t != null) {
        ret.add(t);
      }
    });
    return ret;
  }
}
