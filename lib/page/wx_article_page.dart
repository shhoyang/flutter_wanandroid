import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/wx_article_bloc.dart';
import 'package:flutter_wanandroid/utils/list_state.dart';
import 'package:flutter_wanandroid/widget/article_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WxArticlePage extends StatefulWidget {
  WxArticlePage({Key key}) : super(key: key);

  @override
  _WxArticlePageState createState() => _WxArticlePageState();
}

class _WxArticlePageState extends State<WxArticlePage>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    WxArticleBloc bloc = BlocProvider.of<WxArticleBloc>(context);
    bloc.stateStream.listen((state) {
      ListState.setController(_refreshController, state);
    });
    return StreamBuilder(
        stream: bloc.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          return SmartRefresher(
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: bloc.refresh,
            onLoading: bloc.loadMore,
            controller: _refreshController,
            header: WaterDropHeader(),
            child: ArticleList(
              data: snapshot.data,
              refresh: bloc.refresh,
              showAuthor: false,
            ).build(context),
          );
        });
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
