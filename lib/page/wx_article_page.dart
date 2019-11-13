import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/bean/article.dart';
import 'package:flutter_wanandroid/bloc/bloc_provider.dart';
import 'package:flutter_wanandroid/bloc/wx_article_bloc.dart';
import 'package:flutter_wanandroid/event/list_state.dart';
import 'package:flutter_wanandroid/utils/common_utils.dart';
import 'package:flutter_wanandroid/widget/article_item.dart';
import 'package:flutter_wanandroid/widget/article_item_no_image.dart';
import 'package:flutter_wanandroid/widget/space.dart';
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
  WxArticleBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<WxArticleBloc>(context);
//    bloc.stateStream.listen((state) {
//      if (state & ListState.NO_DATA != ListState.EMPTY) {}
//
//      if (state & ListState.REFRESH != ListState.EMPTY) {
//        _refreshController?.refreshCompleted();
//      } else {
//        if (state & ListState.LOAD_MORE_FAILED != ListState.EMPTY) {
//          _refreshController?.loadFailed();
//        } else if (state & ListState.NO_MORE != ListState.EMPTY) {
//          _refreshController?.loadNoData();
//        } else {
//          _refreshController?.loadComplete();
//        }
//      }
//    });
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
            child: _buildList(bloc, snapshot.data),
          );
        });
  }

  Widget _buildList(WxArticleBloc bloc, List<Article> data) {
    if (data == null) {
      bloc.refresh();
      return Container(
        child: Center(
          child: Text("LOADING..."),
        ),
      );
    }

    if (data.isEmpty) {
      return Container(
        child: Center(
          child: Text("NO DATA"),
        ),
      );
    }

    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        Article article = data[index];
        return ArticleItemNoImage(
            article: article,
            onPressed: () {},
            onFavPressed: () {},
            showAuthor: false);
      },
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
