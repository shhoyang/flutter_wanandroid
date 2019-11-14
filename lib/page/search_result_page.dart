import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/search_result_bloc.dart';
import 'package:flutter_wanandroid/utils/list_state.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:flutter_wanandroid/widget/simple_app_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultPage extends StatefulWidget {
  final String keyWord;

  SearchResultPage({Key key, this.keyWord}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    SearchResultBloc bloc = BlocProvider.of<SearchResultBloc>(context);
    bloc.stateStream.listen((state) {
      ListState.setController(_refreshController, state);
    });
    return Scaffold(
      appBar: SimpleAppBar(widget.keyWord),
      body: StreamBuilder(
          stream: bloc.stream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            return SmartRefresher(
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: bloc.refresh,
              onLoading: bloc.loadMore,
              controller: _refreshController,
              header: WaterDropHeader(),
              child: ArticleList(
                data: snapshot.data,
                showChapter: true,
                refresh: bloc.refresh,
              ).build(context),
            );
          }),
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }
}
