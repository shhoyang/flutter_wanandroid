import 'package:flutter_wanandroid/api/api_service.dart';
import 'package:flutter_wanandroid/api/dio_manager.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bloc/base_list_bloc.dart';

class SearchResultBloc extends BaseListBloc<Article> {
  final String keyWord;

  SearchResultBloc(this.keyWord) : super();

  @override
  void loadData([int page]) async {
    DioManager.getInstance()
        .post(ApiService.getUrl(ApiService.SEARCH, page: page - 1), (data) {
      List list = data["datas"];
      List<Article> temp = list.map((item) {
        return Article.fromJson(item);
      }).toList();
      succeed(temp);
    }, errorCallBack: (code, msg) {
      failed(code, msg);
    }, params: {"k": keyWord});
  }
}
